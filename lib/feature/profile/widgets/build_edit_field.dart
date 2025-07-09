import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEditField(String label, TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    ),
  );
}
