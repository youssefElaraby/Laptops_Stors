
import '../model/cart_model.dart';

abstract class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartSuccess extends CartState {
  final CartModel cartResponse;
  CartSuccess({required this.cartResponse});
}
final class CartError extends CartState {
  final String message;
  CartError({required this.message});
}
