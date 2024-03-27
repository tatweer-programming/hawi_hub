import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/routing/routes.dart';
import '../../bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthBloc bloc = AuthBloc.get(context);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            authBackGround(50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              child: Column(
                children: [
                  mainFormField(
                      controller: emailController,
                      label: 'Email',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      }),
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
                      }),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       _selectOneButton("Player", ColorManager.grey3),
                  //       _selectOneButton("Owner", ColorManager.primary),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is LoginPlayerSuccessState) {
                        context.pushAndRemove(Routes.home);
                      }
                    },
                    builder: (context, state) {
                      return defaultButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            bloc.add(LoginPlayerEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        text: "LOGIN",
                        fontSize: 17.sp,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Keep me logged in",
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(color: ColorManager.black),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/or.png",
                    width: 60.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset("assets/images/icons/facebook.webp"),
                            const Text("Facebook")
                          ],
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        Column(
                          children: [
                            Image.asset("assets/images/icons/google.webp"),
                            const Text("Google")
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextButton(
                    onPressed: () {
                      context.push(Routes.register);
                    },
                    child: const Text(
                      "Don’t have an account? SIGN UP",
                      style: TextStyle(
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

Widget _selectOneButton(String text, Color color) => Row(
      children: [
        Container(
          height: 3.h,
          width: 5.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 15.sp, color: ColorManager.grey3),
        )
      ],
    );
