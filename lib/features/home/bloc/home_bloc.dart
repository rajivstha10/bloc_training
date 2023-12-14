// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_training/data/cart_items.dart';
import 'package:bloc_training/data/grocery_data.dart';
import 'package:bloc_training/data/wishlist_items.dart';
import 'package:bloc_training/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    //should be put in an ascending order
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent); //put the cursor on homeProductWishlistButtonClickedEvent click on the bulb and select create method and it will automatically create the method for it
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
//should be put in an ascending order
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(
        HomeLoadingState()); //initially we should have loading state to fetch the data
    await Future.delayed(const Duration(
        seconds:
            3)); //purpisefully putting the deley because we are fetching the data from out local database i.e. grocery_data.dart inside data folder
    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                //from class GroceryData of list groceryProducts and map(e) means the single instance of the list to be mapped to productDataModel
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList())); //.toList() to make it a list
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist product Clicked');
    wishlistItems.add(event
        .clickeProduct); //so this is how you pass the product through events
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart product Clicked');
    cartItems.add(event.clickeProduct);
    emit(HomeProductItemAddedToCartActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate Clicked');
    emit(
        HomeNavigatetoWishlistPageActionState()); //emiting the action state i.e. when i am going to get this state i want to take some actions.(Listen to this state and perform an action)
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate Clicked');
    emit(
        HomeNavigatetoCartPageActionState()); //emiting the action state i.e. when i am going to get this state i want to take some actions.(Listen to this state and perform an action)
  }
}
