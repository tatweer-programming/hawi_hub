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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    bool acceptTerms = false;
    File? image;
    TextEditingController confirmPasswordController = TextEditingController();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);

        if (state is AddProfilePictureSuccessState) {
          image = state.profilePictureFile;
          print(image);
        }
        if (state is AcceptConfirmTermsState) {
          acceptTerms = state.accept;
          print(acceptTerms);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
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
                      Center(
                        child: InkWell(
                          onTap: () {
                            bloc.add(AddProfilePictureEvent());
                          },
                          child: const CircleAvatar(
                            radius: 35,
                            backgroundColor: ColorManager.primary,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      mainFormField(
                        controller: userNameController,
                        label: 'Username',
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                        controller: passwordController,
                        label: 'Password',
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      mainFormField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
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
                          bloc.add(
                            RegisterPlayerEvent(
                              player: Player(
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                profilePictureFile: image,
                                profilePictureUrl:
                                    "https://wegotthiscovered.com/wp-content/uploads/2022/08/hisoka-hunter-x-hunter.jpg",
                                myWallet: 0,
                              ),
                            ),
                          );
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
