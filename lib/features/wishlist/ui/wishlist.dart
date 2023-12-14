import 'package:bloc_training/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bloc_training/features/wishlist/ui/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          if (state is WishlistRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Wishlist item removed from Cart'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;

              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                        productDataModel: successState.wishlistItems[index],
                        wishlistBloc: wishlistBloc);
                  });
            default:
          }
          return Container();
        },
      ),
    );
  }
}
