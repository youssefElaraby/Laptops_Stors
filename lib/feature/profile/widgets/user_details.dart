import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../view_model/profile_cubit.dart';
import '../view_model/profile_state.dart';

Widget buildInfoCard(BuildContext context) {
  final state = context.watch<ProfileCubit>().state;

  if (state is ProfileSuccess) {
    final user = state.profileResponse;

    return Column(
      children: [

        GestureDetector(
          onTap: () {
            if ((user.profileImage ?? "").isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: InteractiveViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          user.profileImage!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            height: 200.h,
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: Icon(Icons.person, size: 100.r, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.r),
            child: Image.network(
              user.profileImage ?? "",
              height: 100.r,
              width: 100.r,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 100.r,
                width: 100.r,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Icon(Icons.person, size: 60.r, color: Colors.white),
              ),
            ),
          ),
        ),

        SizedBox(height: 20.h),


        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              buildInfoTile(Icons.person, user.name ?? "", iconColor: Colors.indigo),
              buildDivider(),
              buildInfoTile(Icons.email, user.email ?? "", iconColor: Colors.teal),
              buildDivider(),
              buildInfoTile(Icons.phone, user.phone ?? "", iconColor: Colors.green),
              buildDivider(),
              buildInfoTile(Icons.credit_card, user.nationalId ?? "", iconColor: Colors.red),
              buildDivider(),
              buildInfoTile(
                user.gender == "male" ? Icons.male : Icons.female,
                user.gender == "male" ? "ذكر" : "أنثى",
                iconColor: Colors.purple,
              ),
            ],
          ),
        ),
      ],
    );
  } else if (state is ProfileLoading) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: const Color(0xff3b3b72),
        size: 50.r,
      ),
    );
  } else if (state is ProfileFailure) {
    return Center(child: Text(state.errorMessage));
  } else {
    return const SizedBox();
  }
}


Widget buildInfoTile(IconData icon, String text, {Color iconColor = Colors.blue}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20.r),
      ),
      SizedBox(width: 12.w),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget buildDivider() => Padding(
  padding: EdgeInsets.symmetric(vertical: 12.h),
  child: Divider(height: 1, color: Colors.grey.shade300),
);
