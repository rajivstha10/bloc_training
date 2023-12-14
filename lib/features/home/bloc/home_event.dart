part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickeProduct; //pass the product throung events

  HomeProductWishlistButtonClickedEvent({required this.clickeProduct});
}

class HomeProductCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickeProduct;

  HomeProductCartButtonClickedEvent({required this.clickeProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}
