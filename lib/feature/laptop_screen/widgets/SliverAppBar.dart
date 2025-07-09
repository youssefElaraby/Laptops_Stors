import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/widgets/top_curve_clipper.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final double height;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: TopCurveClipper(),
          child: Container(
            height: height.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff2f2f57), Color(0xff3b3b72)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 70.h, left: 16.w, right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (actions != null)
                Row(children: actions!)
              else
                const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
