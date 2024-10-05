import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/auth/data/models/auth_player.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/error/exception_manager.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  final AuthBloc bloc;

  const RegisterScreen({super.key, required this.bloc});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    emailController.dispose();
    ageController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    bool acceptTerms = false;
    bool visible = false;
    TextEditingController confirmPasswordController = TextEditingController();
    AuthPlayer? authPlayer;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AcceptConfirmTermsState) {
          acceptTerms = state.accept;
        } else if (state is ChangePasswordVisibilityState) {
          visible = state.visible;
        }
        if (state is RegisterSuccessState) {
          widget.bloc.add(ConfirmEmailEvent());
          context.push(Routes.confirmEmail, arguments: {"bloc": widget.bloc});
        } else if (state is ConfirmEmailSuccessState) {
          defaultToast(msg: handleResponseTranslation(state.value, context));
        } else if (state is RegisterErrorState) {
          errorToast(
              msg: ExceptionManager(state.exception).translatedMessage());
        }
        if (state is SignupWithGoogleSuccessState) {
          authPlayer = state.authPlayer;
          userNameController.text = authPlayer!.userName;
          emailController.text = authPlayer!.email;
        } else if (state is SignupWithFacebookSuccessState) {
          authPlayer = state.authPlayer;
          userNameController.text = authPlayer!.userName;
          emailController.text = authPlayer!.email;
        } else if (state is SignupWithGoogleErrorState ||
            state is SignupWithFacebookErrorState) {
          errorToast(
              msg: handleResponseTranslation("Something went wrong", context));
        } else if (state is ShowBirthDateDialogState) {
          DateTime? selectedDate = await showDate(context);
          if (selectedDate != null) {
            ageController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  authBackGround(50.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        mainFormField(
                            controller: userNameController,
                            type: TextInputType.name,
                            label: S.of(context).userName,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterUsername;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: emailController,
                            label: S.of(context).email,
                            type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterEmail;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        InkWell(
                          onTap: () {
                            widget.bloc.add(ShowDialogEvent());
                          },
                          child: mainFormField(
                            controller: ageController,
                            label: S.of(context).birthDate,
                            enabled: false,
                            // type: TextInputType.emailAddress,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return S.of(context).enterEmail;
                            //   }
                            //   return null;
                            // },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                          controller: passwordController,
                          label: S.of(context).password,
                          obscureText: visible,
                          suffix: IconButton(
                              onPressed: () {
                                widget.bloc.add(
                                    ChangePasswordVisibilityEvent(visible));
                              },
                              icon: Icon(visible
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (value) {
                            return validPassword(value, context);
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        mainFormField(
                            controller: confirmPasswordController,
                            label: S.of(context).confirmPassword,
                            validator: (value) {
                              if (value.isEmpty) {
                                return S.of(context).enterConfirmPassword;
                              } else if (value != passwordController.text) {
                                return S.of(context).passwordDoesNotMatch;
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: orImageBuilder(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.w),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  widget.bloc.add(SignupWithFacebookEvent());
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/icons/facebook.webp",
                                      height: 5.h,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      "Facebook",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () async {
                                  widget.bloc.add(SignupWithGoogleEvent());
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/icons/google.webp",
                                      height: 5.h,
                                      width: 10.w,
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        _confirmTerms(
                            context: context,
                            onTap: () {
                              widget.bloc
                                  .add(AcceptConfirmTermsEvent(acceptTerms));
                            },
                            acceptTerms: acceptTerms),
                        SizedBox(
                          height: 2.h,
                        ),
                        state is RegisterLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate() &&
                                      acceptTerms) {
                                    widget.bloc.add(
                                      RegisterPlayerEvent(
                                        authPlayer: AuthPlayer(
                                            password: passwordController.text,
                                            userName: userNameController.text,
                                            email: emailController.text,
                                            birthDate: ageController.text,
                                            profilePictureUrl:
                                                authPlayer?.profilePictureUrl),
                                      ),
                                    );
                                  } else if (!acceptTerms) {
                                    errorToast(
                                        msg:
                                            "You should agree to terms of service and privacy policy");
                                  }
                                },
                                fontSize: 17.sp,
                                text: S.of(context).signUp,
                              ),
                        SizedBox(
                          height: 2.h,
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

  Future<DateTime?> showDate(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate:
          DateTime(DateTime.now().year - 6), // set the initial date to today
      firstDate: DateTime(1900, 1), // set the first allowed date
      lastDate: DateTime(DateTime.now().year - 6), // set the last allowed date
    );
    return selectedDate;
  }
}

Widget _confirmTerms(
        {required VoidCallback onTap,
        required BuildContext context,
        required bool acceptTerms}) =>
    Row(
      children: [
        IconButton(
            onPressed: onTap,
            icon: Icon(
                acceptTerms ? Icons.check_box : Icons.check_box_outline_blank)),
        Expanded(
            child: InkWell(
          onTap: () {
            context.push(Routes.termsAndCondition);
          },
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(vertical: 1.5.h),
            child: Text(
              S.of(context).agreeTerms,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ))
      ],
    );
