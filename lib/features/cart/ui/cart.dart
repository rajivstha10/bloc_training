import 'package:bloc_training/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_training/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartRemovedActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Cart item removed from Cart'),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState
                      .cartItems.length, //defining the number of items
                  itemBuilder: (context, index) {
                    return CartTileWidget(
                        cartBloc:
                            cartBloc, //pass homeBloc to the producttilewidget
                        productDataModel: successState.cartItems[
                            index]); //each products is going to get theit own producttile
                  });

            default:
          }
          return Container();
        },
      ),
    );
  }
}
