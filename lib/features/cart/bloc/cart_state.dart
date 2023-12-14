part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

sealed class CartActionState extends CartState {}

final class CartInitial extends CartState {}

final class CartRemovedActionState extends CartActionState{}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartSuccessState({
    required this.cartItems,
  });

  get products => null;
}
