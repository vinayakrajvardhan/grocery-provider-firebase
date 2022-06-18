import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_implementation/const/firebase_consts.dart';
import 'package:grocery_implementation/providers/wishlist_provider.dart';
import 'package:grocery_implementation/services/global_methods.dart';

import 'package:provider/provider.dart';

import '../services/utils.dart';

class HeartBTN extends StatefulWidget {
  const HeartBTN({Key? key, required this.productId, this.isInWishlist = false})
      : super(key: key);
  final String productId;
  final bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final wishListprovider = Provider.of<WishlistProvider>(context);
    return GestureDetector(
      onTap: () async {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.errorDialog(
              subtitle: 'No user found?Please log in', context: context);
          return;
        }
        wishListprovider.addRemoveProductToWishlist(
            productId: widget.productId);
      },
      child: loading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 15, width: 15, child: CircularProgressIndicator()),
            )
          : Icon(
              widget.isInWishlist != null && widget.isInWishlist == true
                  ? IconlyBold.heart
                  : IconlyLight.heart,
              size: 22,
              color: widget.isInWishlist != null && widget.isInWishlist == true
                  ? Colors.red
                  : color,
            ),
    );
  }
}
