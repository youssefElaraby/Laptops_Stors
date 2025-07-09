import '../model/profile_response.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserProfileResponse profileResponse;

  ProfileSuccess(this.profileResponse);
}

class ProfileFailure extends ProfileState {
  final String errorMessage;

  ProfileFailure(this.errorMessage);
}
