import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../cache/cache_helper.dart';
import '../model/auth_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  GlobalKey<FormState> signUpFormKey = GlobalKey();
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpPhoneNumber = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpNationalId = TextEditingController();
  TextEditingController signUpGender = TextEditingController();

  XFile? profilePic;

  bool isUploadingImage = false;
  bool isImageUploaded = false;

  void upLoadProfilePicture(XFile image) {
    profilePic = image;
    isUploadingImage = true;
    emit(UploadProfilePicture());
  }

  Future<void> signUp() async {
    if (!signUpFormKey.currentState!.validate()) return;

    emit(SignUpLoading());

    try {
      String? base64Image;
      if (profilePic != null) {
        final bytes = await profilePic!.readAsBytes();
        final base64Str = base64Encode(bytes);
        final extension = profilePic!.path.split('.').last;
        base64Image = "data:image/$extension;base64,$base64Str";

        isUploadingImage = false;
        emit(UploadProfilePicture());
      }

      final response = await Dio().post(
        "https://elwekala.onrender.com/user/register",
        data: {
          "name": signUpName.text,
          "email": signUpEmail.text,
          "phone": signUpPhoneNumber.text,
          "password": signUpPassword.text,
          "nationalId": signUpNationalId.text,
          "gender": signUpGender.text,
          "profileImage": base64Image,
        },
      );

      final authModel = AuthModel.fromJson(response.data);

      await CacheHelper.saveData(key: "token", value: authModel.user?.token);
      await CacheHelper.saveData(key: "userId", value: authModel.user?.nationalId);
      await CacheHelper.saveData(key: "name", value: authModel.user?.name);
      await CacheHelper.saveData(key: "phone", value: authModel.user?.phone);
      await CacheHelper.saveData(key: "email", value: authModel.user?.email);
      await CacheHelper.saveData(key: "profileImage", value: authModel.user?.profileImage);


      print("token: ${authModel.user?.token}");
      print("userId: ${authModel.user?.nationalId}");
      print("name: ${authModel.user?.name}");
      print("phone: ${authModel.user?.phone}");
      print("email: ${authModel.user?.email}");
      print("profileImage: ${authModel.user?.profileImage}");

      isImageUploaded = true;

      // ✅ أرسل الحالة بعد التخزين
      emit(SignUpSuccess(authmodel: authModel));
    } on DioError catch (e) {
      emit(SignUpFailure(errorMessage: e.response?.data["message"] ?? e.message));
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
