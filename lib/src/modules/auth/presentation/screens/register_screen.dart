import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/presentation/screens/login_screen.dart';
import 'package:hawihub/src/modules/auth/presentation/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routing/routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool acceptTerms = false;
    File? image;
    TextEditingController confirmPasswordController = TextEditingController();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AddProfilePictureSuccessState) {
          image = state.profilePictureFile;
        }
        if (state is AcceptConfirmTermsState) {
          acceptTerms = state.accept;
        }
        else if(state is RegisterPlayerSuccessState){
          context.pushAndRemove(Routes.home);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  authBackGround(40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        mainFormField(
                          controller: userNameController,
                          label: 'Username',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                          controller: emailController,
                          label: 'Email',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                          controller: passwordController,
                          label: 'Password',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                          controller: confirmPasswordController,
                          label: 'Confirm Password',
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter confirm password';
                              }
                              else if (value != passwordController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            }
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        _confirmTerms(
                            onTap: () {
                              bloc.add(AcceptConfirmTermsEvent(acceptTerms));
                            },
                            acceptTerms: acceptTerms),
                        SizedBox(
                          height: 2.h,
                        ),
                        defaultButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate() && acceptTerms) {
                              bloc.add(
                                RegisterPlayerEvent(
                                  player: Player(
                                    userName: userNameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    profilePictureFile: image,
                                    myWallet: 0,
                                  ),
                                ),
                              );
                            }

                          },
                          fontSize: 17.sp,
                          text: "REGISTER",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _confirmTerms(
        {required VoidCallback onTap, required bool acceptTerms}) =>
    Row(
      children: [
        IconButton(onPressed: onTap, icon: Icon(acceptTerms ?  Icons.check_box : Icons.check_box_outline_blank)),
        SizedBox(
          width: 2.w,
        ),
        Expanded(
            child: Text(
          "I agree to the Terms of Service and Privacy Policy.",
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
        ))
      ],
    );