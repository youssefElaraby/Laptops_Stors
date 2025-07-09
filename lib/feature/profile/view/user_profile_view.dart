import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/widgets/top_curve_clipper.dart';
import '../../Auth/signIn/view/signIn_view.dart';
import '../view_model/profile_cubit.dart';
import '../widgets/showEditBottomSheet.dart';
import '../widgets/user_details.dart';

class UserProfileView extends StatefulWidget {
  final String token;
  const UserProfileView({super.key, required this.token});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: Column(
        children: [
          ClipPath(
            clipper: TopCurveClipper(),
            child: Container(
              height: 230.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff2f2f57), Color(0xff3b3b72)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Text(
                  "الملف الشخصي",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                children: [
                  buildInfoCard(context),


                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          showEditProfileSheet(context, widget.token);
                        },
                        icon: const Icon(Icons.edit, color: Colors.blueGrey),
                        label: Text(
                          "تعديل الملف الشخصي",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          context.read<ProfileCubit>().deleteUser(widget.token);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const SignInView()),
                          );

                        },
                        icon: const Icon(Icons.delete, color: Colors.blueGrey),
                        label: Text(
                          "حذف الملف الشخصي",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),


                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SignInView()),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text("تسجيل الخروج", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3b3b72),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        textStyle: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
