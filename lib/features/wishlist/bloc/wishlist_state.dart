part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistState {}

sealed class WishlistActionState extends WishlistState {}

final class WishlistInitial extends WishlistState {}

final class WishlistRemovedActionState extends WishlistActionState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishlistItems;

  WishlistSuccessState({
    required this.wishlistItems,
  });

  get products => null;
}
