import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/main_text_field.dart';
import '../../../../core/widgets/top_curve_clipper.dart';
import '../../../laptop_screen/view/laptop_view.dart';
import '../../signUp/view/sign_up_view.dart';
import '../../signUp/widgets/custom_form_button.dart';
import '../view_model/sign_in_cubit.dart';
import '../view_model/sign_in_state.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SafeArea(

        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }

            if (state is SignInSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم تسجيل الدخول بنجاح")));

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  LaptopView()),
              );

              // Navigate if needed
            }
          },
          builder: (context, state) {
            return Stack(
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
                        "Welcome Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // المحتوى الرئيسي
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: cubit.signInFormKey,
                    child: Column(
                      children: [
                         SizedBox(height: 300.h),

                        BuildTextField(
                          label: 'Email',
                          hint: 'Your email',
                          controller: cubit.signInEmail,
                          textInputType: TextInputType.emailAddress,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        BuildTextField(
                          label: 'Password',
                          hint: 'Your password',
                          controller: cubit.signInPassword,
                          isObscured: true,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        CustomMainButton(
                          innerText: 'Login',
                          isLoading: state is SignInLoading,
                          backgroundColor: AppColors.primaryDarkColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () {
                            if (cubit.signInFormKey.currentState!.validate()) {
                              cubit.signIn();
                            }
                          },
                        ),


                        const SizedBox(height: 24),

                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpView(),
                              ),
                            );
                          },
                          child: const Text(
                            "Don't have an account? Sign up",
                            style: TextStyle(color: AppColors.primaryDarkColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}