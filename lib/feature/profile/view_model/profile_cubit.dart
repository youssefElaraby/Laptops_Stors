import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/profile_response.dart';
import 'profile_state.dart';

UserProfileResponse? currentUser;

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String gender = "male";
  String token = "";

  Future<void> getProfile(String token) async {
    emit(ProfileLoading());
    this.token = token;

    try {
      final response = await Dio().post(
        "https://elwekala.onrender.com/user/profile",
        data: {"token": token},
      );

      if (response.data['status'] == "success") {
        final userProfile = UserProfileResponse.fromJson(response.data);

        currentUser = userProfile;

        nameController.text = userProfile.name ?? "";
        emailController.text = userProfile.email ?? "";
        phoneController.text = userProfile.phone ?? "";
        gender = userProfile.gender ?? "male";

        emit(ProfileSuccess(userProfile));
      } else {
        emit(ProfileFailure("فشل في تحميل البيانات"));
      }
    } catch (e) {
      emit(ProfileFailure("حدث خطأ ما: ${e.toString()}"));
    }
  }


  Future<void> updateProfile(String token) async {
    emit(ProfileLoading());

    try {
      final response = await Dio().put(
        "https://elwekala.onrender.com/user/update",
        data: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "gender": gender,
          "password": "12345678",
          "nationalId": currentUser?.nationalId ?? "",
          "token": token,
        },
      );

      print(response.data);

      if (response.data['status'] == "success") {
        await getProfile(token);
      } else {
        emit(ProfileFailure("فشل في تحديث البيانات"));
      }
    } catch (e) {
      emit(ProfileFailure("حدث خطأ أثناء التحديث: ${e.toString()}"));
    }
  }


  Future<void> deleteUser(String token) async {
    emit(ProfileLoading());

    try {
      final response = await Dio().delete(
        "https://elwekala.onrender.com/user/delete",
        data: {
          "token": token,
          "email": emailController.text.trim()
        },

      );
    }
    catch (e) {
      emit(ProfileFailure( e.toString()));
    }
  }


}
