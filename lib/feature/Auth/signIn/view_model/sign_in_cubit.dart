// ✅ SignInCubit الكامل بعد التعديل لمعالجة الحالات بشكل صحيح

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:laptops/feature/Auth/signIn/view_model/sign_in_state.dart';
import 'package:laptops/feature/Auth/signUp/model/auth_model.dart';

import '../../../../cache/cache_helper.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  GlobalKey<FormState> signInFormKey = GlobalKey();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();

  Future<void> signIn() async {
    emit(SignInLoading());

    try {
      final response = await Dio().post(
        'https://elwekala.onrender.com/user/login',
        data: {
          'email': signInEmail.text.trim(),
          'password': signInPassword.text.trim(),
        },
      );

      // Check status and user presence in response
      if (response.statusCode == 200 &&
          response.data['status'] == 'success' &&
          response.data['user'] != null) {

        final authModel = AuthModel.fromJson(response.data);

        // Save data to cache
        await CacheHelper.saveData(key: "token", value: authModel.user?.token);
        await CacheHelper.saveData(key: "userId", value: authModel.user?.nationalId);
        await CacheHelper.saveData(key: "name", value: authModel.user?.name);
        await CacheHelper.saveData(key: "email", value: authModel.user?.email);
        await CacheHelper.saveData(key: "phone", value: authModel.user?.phone);
        await CacheHelper.saveData(key: "profileImage", value: authModel.user?.profileImage);


        print("token: ${authModel.user?.token}");
        print("userId: ${authModel.user?.nationalId}");
        print("name: ${authModel.user?.name}");
        print("email: ${authModel.user?.email}");
        print("phone: ${authModel.user?.phone}");
        print("profileImage: ${authModel.user?.profileImage}");

    

        emit(SignInSuccess(authModel: authModel));
      } else {
        emit(SignInFailure(
          errorMessage: response.data['message'] ?? "فشل تسجيل الدخول، تأكد من البيانات",
        ));
      }
    } on DioError catch (e) {
      final msg = e.response?.data['message'] ?? "حدث خطأ أثناء الاتصال بالخادم";
      emit(SignInFailure(errorMessage: msg));
    } catch (e) {
      emit(SignInFailure(errorMessage: e.toString()));
    }
  }
}
