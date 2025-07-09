import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../cache/cache_helper.dart';
import '../../cart/view/cart_view.dart';
import '../../favorite_screen/view/favorite_view.dart';
import '../../profile/view/user_profile_view.dart';
import '../../profile/view_model/profile_cubit.dart';
import '../../profile/view_model/profile_state.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xfff5f6fa),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          String name = "زائر";
          String email = "email@example.com";
          String? profileImage;

          if (state is ProfileSuccess) {
            name = state.profileResponse.name ?? "زائر";
            email = state.profileResponse.email ?? "email@example.com";
            profileImage = state.profileResponse.profileImage;
          }

          return ListView(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserProfileView(token: CacheHelper.getData(key: "token") ?? ""),
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: profileImage != null && profileImage.isNotEmpty
                          ? (profileImage.startsWith('http')
                          ? NetworkImage(profileImage)
                          : MemoryImage(base64Decode(profileImage.split(',').last)))
                          : const AssetImage("assets/images/avatar.png") as ImageProvider,
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 9.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              ListTile(
                title: Text(
                  "القائمة",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.red, size: 30),
                title: Text(
                  "المفضلة",
                  style: TextStyle(fontSize: 16.sp),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoriteView()),
                  );
                },
              ),
              const Divider(height: 5),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.blue, size: 30),
                title: Text(
                  "السلة",
                  style: TextStyle(fontSize: 16.sp),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartView()),
                  );
                },
              ),
              const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
