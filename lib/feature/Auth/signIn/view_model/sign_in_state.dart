

import '../../signUp/model/auth_model.dart';

abstract class SignInState {}

final class SignInInitial extends SignInState {}
final class SignInLoading extends SignInState {}
final class SignInSuccess extends SignInState {
  final AuthModel authModel;
  SignInSuccess({required this.authModel});
}
final class SignInFailure extends SignInState {
  final String errorMessage;
  SignInFailure({required this.errorMessage});
}
