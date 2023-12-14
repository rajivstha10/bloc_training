part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

//the state have two i.e. home state and home action state. home action is when the actions are taken place inside home page so it extends HomeState
sealed class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

//when fetching data it takes time. so until the data are fetched we need to show the loading state in the home state
class HomeLoadingState extends HomeState {}

//when data are fetched successfully we need to exit the loading state and show the data in the home state
class HomeLoadedSuccessState extends HomeState {
//when HomeLoadedSuccessState is emitted i want to get the list of products so,

  final List<ProductDataModel> products;

  HomeLoadedSuccessState({
    required this.products,
  });
}

//when fetching data some times we may get some error.so we need to handle the error state in the home state
class HomeErrorState extends HomeState {}

//when clicked on the button i.e. wishlist we need to navigate to the wishlistPage.So its an action where some actions need to be taken place
class HomeNavigatetoWishlistPageActionState extends HomeActionState {}

//when clicked on the button i.e. cart we need to navigate to the cartPage.So its an action where some actions need to be taken place
class HomeNavigatetoCartPageActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemAddedToCartActionState extends HomeActionState {}
