import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../model/fav.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  List<FavoriteProducts> favorites = [];

  Future<void> getFavorites({
    required String token,
    required String nationalId,
  }) async {
    emit(FavoriteLoading());

    try {
      final response = await Dio().get(
        'https://elwekala.onrender.com/favorite',
        data: {"nationalId": nationalId},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      favorites = (response.data['favoriteProducts'] as List)
          .map((json) => FavoriteProducts.fromJson(json))
          .toList();

      emit(FavoriteUpdated(favorites: favorites));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> addToFavorite({
    required String token,
    required String nationalId,
    required String productId,
  }) async {
    emit(FavoriteLoading());

    try {
      final response = await Dio().post(
        'https://elwekala.onrender.com/favorite',
        data: {
          "nationalId": nationalId,
          "productId": productId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final status = response.data['status'] ?? '';
      final message = response.data['message'] ?? 'تمت الإضافة للمفضلة';

      if (status == 'success') {
        await getFavorites(token: token, nationalId: nationalId);
      } else {
        emit(FavoriteFailure(message));
      }
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> deleteFavorite({
    required String token,
    required String nationalId,
    required String productId,
  }) async {
    emit(FavoriteLoading());

    try {
      final response = await Dio().delete(
        'https://elwekala.onrender.com/favorite',
        data: {
          "nationalId": nationalId,
          "productId": productId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final status = response.data['status'] ?? '';
      final message = response.data['message'] ?? 'تم الحذف من المفضلة';

      if (status == 'success') {
        await getFavorites(token: token, nationalId: nationalId);
      } else {
        emit(FavoriteFailure(message));
      }
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }
}
