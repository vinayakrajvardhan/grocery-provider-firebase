import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inner screen/product_details.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import '../../widget/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

    return ListTile(
      subtitle: Text('Paid:'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        imageUrl:
            'https://images.unsplash.com/photo-1572375835088-f13188b77a79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80',
        height: size.width * 0.22,
        width: size.width * 0.22,
        boxFit: BoxFit.cover,
      ),
      title: TextWidget(text: 'Title x 12', color: color, textSize: 18),
      trailing: TextWidget(
        text: "03/08/2022",
        color: color,
        textSize: 18,
      ),
    );
  }
}
