// lib/feature/favorite_screen/view_model/favorite_state.dart

part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteUpdated extends FavoriteState {
  final List<FavoriteProducts> favorites;

  FavoriteUpdated({required this.favorites});
}

final class FavoriteFailure extends FavoriteState {
  final String message;

  FavoriteFailure(this.message);
}
