part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpSuccess extends SignUpState {
  final AuthModel authmodel;
  SignUpSuccess({required this.authmodel});
}
final class SignUpFailure extends SignUpState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}



final class UploadProfilePicture extends SignUpState {}

