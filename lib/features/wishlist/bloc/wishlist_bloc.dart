// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_training/data/wishlist_items.dart';
import 'package:bloc_training/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromCartEvent>(wishlistRemoveFromCartEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveFromCartEvent(
      WishlistRemoveFromCartEvent event, Emitter<WishlistState> emit) {
    print('Wishlist remove product clicked');
    wishlistItems.remove(event.productDataModel);
    emit(WishlistRemovedActionState());
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
