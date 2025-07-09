import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../../core/widgets/top_curve_clipper.dart';
import '../view_model/sign_up_cubit.dart';
import '../widgets/already_have_an_account_widget.dart';
import '../widgets/custom_form_button.dart';
import '../widgets/page_heading.dart';
import '../widgets/pick_image_widget.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }

          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.authmodel.message ?? "تم التسجيل بنجاح")),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();

          return Scaffold(
            backgroundColor: const Color(0xffEEF1F3),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: TopCurveClipper(),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff2f2f57), Color(0xff3b3b72)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: cubit.signUpFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const PickImageWidget(),
                          const PageHeading(title: 'Sign-up'),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'Name',
                            hint: 'Your name',
                            controller: cubit.signUpName,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'Email',
                            hint: 'Your email',
                            controller: cubit.signUpEmail,
                            textInputType: TextInputType.emailAddress,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              if (!value.contains('@') || !value.contains('.')) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'Password',
                            hint: 'Your password',
                            controller: cubit.signUpPassword,
                            isObscured: true,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password is required";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'Phone number',
                            hint: 'Your phone number ex:01234567890',
                            controller: cubit.signUpPhoneNumber,
                            textInputType: TextInputType.phone,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Phone number is required";
                              }
                              if (value.length != 11 || !value.startsWith('01')) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'National ID',
                            hint: 'National ID must be 14 digits',
                            controller: cubit.signUpNationalId,
                            textInputType: TextInputType.number,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "National ID is required";
                              }
                              if (value.length != 14) {
                                return "National ID must be exactly 14 digits";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          BuildTextField(
                            label: 'Gender',
                            hint: 'male or female',
                            controller: cubit.signUpGender,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return "Gender is required";
                              }
                              if (value.toLowerCase() != "male" &&
                                  value.toLowerCase() != "female") {
                                return "Gender must be 'male' or 'female'";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 22),

                          CustomMainButton(
                            innerText: 'Sign up',
                            isLoading: state is SignUpLoading,
                            backgroundColor: AppColors.primaryDarkColor,
                            textColor: AppColors.whiteColor,
                            onPressed: () {
                              if (cubit.signUpFormKey.currentState!.validate()) {
                                cubit.signUp();
                              }
                            },
                          ),

                          const SizedBox(height: 18),
                          const AlreadyHaveAnAccountWidget(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
