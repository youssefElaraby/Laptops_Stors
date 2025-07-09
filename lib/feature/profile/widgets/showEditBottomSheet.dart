import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_model/profile_cubit.dart';
import 'build_edit_field.dart';

void showEditProfileSheet(BuildContext context, String token) {
  final cubit = context.read<ProfileCubit>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20.h,
          right: 20.w,
          left: 20.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "تعديل الملف الشخصي",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),

              buildEditField("الاسم", cubit.nameController),
              buildEditField("البريد الالكتروني", cubit.emailController),
              buildEditField("رقم الهاتف", cubit.phoneController),

              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text("النوع", style: TextStyle(fontSize: 14.sp)),
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'male',
                    groupValue: cubit.gender,
                    onChanged: (value) {
                      cubit.gender = value!;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                  const Text("ذكر"),
                  SizedBox(width: 16.w),
                  Radio<String>(
                    value: 'female',
                    groupValue: cubit.gender,
                    onChanged: (value) {
                      cubit.gender = value!;
                      (context as Element).markNeedsBuild();
                    },
                  ),
                  const Text("أنثى"),
                ],
              ),

              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  cubit.updateProfile(token);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3b3b72),
                  padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 32.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text("تحديث", style: TextStyle(color: Colors.white, fontSize: 16.sp)),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    },
  );
}
