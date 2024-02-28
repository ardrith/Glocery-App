import 'package:flutter/material.dart';
import 'package:shop/features/cart/bloc/cart_bloc.dart';
import 'package:shop/features/home/bloc/home_bloc.dart';
import 'package:shop/features/home/model/home_product_datamodel.dart';

class cartTiles extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;
  const cartTiles(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.imageUrl))),
            height: 200,
            width: double.maxFinite,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            productDataModel.description,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '\$' + productDataModel.price.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    // homeBloc.add(HomeProductCartButtonClickedEvent(
                    //   clickedProduct: productDataModel
                    // ));
                  },
                  icon: Icon(Icons.favorite_border)),
              IconButton(
                  onPressed: () {
                    // homeBloc.add(HomeProductWishlistButtonClickedEvent(
                    //   clickedProduct: productDataModel
                    // ));
                  },
                  icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ],
      ),
    );
  }
}
