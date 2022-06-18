import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../const/firebase_consts.dart';
import '../inner screen/product_details.dart';
import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../services/global_methods.dart';
import '../services/utils.dart';
import 'hrt_btn.dart';
import 'price_widget.dart';
import 'text_widget.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    bool _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishListItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FancyShimmerImage(
                    imageUrl: productModel.imageUrl,
                    height: size.width * 0.22,
                    width: size.width * 0.22,
                    boxFit: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: productModel.isPiece ? 'Piece' : '1KG',
                        color: color,
                        textSize: 22,
                        isTitle: true,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final User? user = authInstance.currentUser;
                              if (user == null) {
                                GlobalMethods.errorDialog(
                                    subtitle: 'No user found?Please log in',
                                    context: context);
                                return;
                              }

                              cartProvider.addProductsToCart(
                                  productId: productModel.id, quantity: 1);
                            },
                            child: Icon(
                              _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                              size: 22,
                              color: _isInCart ? Colors.green : color,
                            ),
                          ),
                          HeartBTN(
                            productId: productModel.id,
                            isInWishlist: _isInWishlist,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              PriceWidget(
                salePrice: productModel.salePrice,
                price: productModel.price,
                textPrice: '1',
                isOnSale: productModel.isOnSale,
              ),
              const SizedBox(height: 5),
              TextWidget(
                text: productModel.title,
                color: color,
                textSize: 16,
                isTitle: true,
              ),
              const SizedBox(height: 5),
            ]),
          ),
        ),
      ),
    );
  }
}
