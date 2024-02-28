import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/cart/ui/cart.dart';
import 'package:shop/features/home/bloc/home_bloc.dart';
import 'package:shop/features/home/model/home_product_datamodel.dart';
import 'package:shop/features/home/ui/product_tile_ui.dart';
import 'package:shop/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavToCartActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavToWishActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemCartlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('item Carted.')),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('item Wishlisted.')),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text('My Grocery app'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonNavigateEvent());
                      },
                      icon: Icon(Icons.shopping_cart))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTiles(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return Scaffold(
              body: Center(child: Text('Error')),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
