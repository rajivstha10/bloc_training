import 'package:bloc_training/features/home/bloc/home_bloc.dart';
import 'package:bloc_training/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(productDataModel.imageUrl),
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(productDataModel.description),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${productDataModel.price}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                          clickeProduct: productDataModel,
                        ));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickeProduct: productDataModel,
                        ));
                      },
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
