import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import '../../../cache/cache_helper.dart';
import '../model/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final String? token = CacheHelper.getData(key: "token");
  final String? nationalId = CacheHelper.getData(key: "userId");

  Future<void> getCart() async {
    emit(CartLoading());

    if (token == null || nationalId == null) {
      emit(CartError(message: "User token or ID missing"));
      return;
    }

    try {
      final response = await Dio().get(
        'https://elwekala.onrender.com/cart/allProducts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "nationalId": nationalId,
        },
      );

      final List<dynamic> listCart = response.data['products'] ?? [];
      final List<Products> products =
      listCart.map((json) => Products.fromJson(json)).toList();

      emit(CartSuccess(cartResponse: CartModel(products: products)));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> addToCart({required String productId, int quantity = 1}) async {
    emit(CartLoading());

    if (token == null || nationalId == null) {
      emit(CartError(message: "User token or ID missing"));
      return;
    }

    try {
      final response = await Dio().post(
        'https://elwekala.onrender.com/cart/add',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "nationalId": nationalId,
          "productId": productId,
          "quantity": quantity,
        },
      );

      if (response.data['status'] == 'success') {
        await getCart();
      } else {
        emit(CartError(message: "Failed to add product to cart"));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  Future<void> deleteFromCart({required String productId}) async {
    emit(CartLoading());

    if (token == null || nationalId == null) {
      emit(CartError(message: "User token or ID missing"));
      return;
    }

    try {
      final response = await Dio().delete(
        'https://elwekala.onrender.com/cart/delete',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "nationalId": nationalId,
          "productId": productId,
        },
      );

      if (response.data['status'] == 'success') {
        await getCart();
      } else {
        emit(CartError(message: "Failed to delete product from cart"));
      }
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
