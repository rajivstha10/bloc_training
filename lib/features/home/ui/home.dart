import 'package:bloc_training/features/cart/ui/cart.dart';
import 'package:bloc_training/features/home/bloc/home_bloc.dart';
import 'package:bloc_training/features/home/ui/product_tile_widget.dart';
import 'package:bloc_training/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //adding the init state so that we can show the initial event
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  //creating instance of the class homeBloc
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    //wraping the scafffold with the BlockConsumer where it will listen to the event and State that the block is providing
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        //if clicked on HomeNavigatetoCartPageActionState push to Cart page else if HomeNavigatetoWishlistPageActionState push to Wishlist Page
        if (state is HomeNavigatetoCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigatetoWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to Cart')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to Wishlist')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState: //the HomeLoadedSuccessState is holding the products list
            //so we can say that:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Rajiv Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState
                      .products.length, //defining the number of items
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc:
                            homeBloc, //pass homeBloc to the producttilewidget
                        productDataModel: successState.products[
                            index]); //each products is going to get theit own producttile
                  }),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
