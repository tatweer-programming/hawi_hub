import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/modules/auth/data/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../data/models/player.dart';
import '../data/models/sport.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc instance = AuthBloc(AuthInitial());

  static AuthBloc get(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthRepository _repository = AuthRepository();
  File? image;
  List<Sport> sports = [];

  AuthBloc(AuthState state) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is RegisterPlayerEvent) {
        emit(RegisterPlayerLoadingState());
        await _repository.registerPlayer(event.player).then((value) {
          print(value);
          if (value == "Registration Successful") {
            emit(RegisterPlayerSuccessState());
          } else {
            emit(RegisterPlayerErrorState(value));
          }
        });
      } else if (event is LoginPlayerEvent) {
        emit(LoginPlayerLoadingState());
        await _repository
            .loginPlayer(event.email, event.password)
            .then((value) {
          print(value);
          if (value == "Login Successfully") {
            emit(LoginPlayerSuccessState());
          } else {
            emit(LoginPlayerErrorState(value));
          }
        });
      } else if (event is AddProfilePictureEvent) {
        File? imagePicked = await _captureAndSaveGalleryImage();
        image = imagePicked;
        emit(AddProfilePictureSuccessState(profilePictureFile: imagePicked!));
      } else if (event is GetSportsEvent) {
        var res = await _repository.getSports();
        res.fold((l) {
          emit(GetSportsErrorState(l));
        }, (r) {
          sports = r;
          emit(GetSportsSuccessState());
        });
      } else if (event is AcceptConfirmTermsEvent) {
        if (event.accept) {
          emit(AcceptConfirmTermsState(false));
        } else {
          emit(AcceptConfirmTermsState(true));
        }
      }else if (event is ChangePasswordVisibilityEvent) {
        if (event.visible) {
          emit(ChangePasswordVisibilityState(false));
        } else {
          emit(ChangePasswordVisibilityState(true));
        }
      } else if (event is SelectSportEvent) {
        List<Sport> selectedSports = event.sports;
        if (event.sports.contains(event.sport)) {
          selectedSports.remove(event.sport);
          emit(SelectSportState(sports: selectedSports));
        } else {
          selectedSports.add(event.sport);
          emit(SelectSportState(sports: selectedSports));
        }
      }
    });
  }
}

Future<File?> _captureAndSaveGalleryImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final image = File(pickedFile.path);

    return image;
  } else {
    return null;
  }
}
