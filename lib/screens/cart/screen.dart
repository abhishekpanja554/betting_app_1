import 'package:betting_app_1/constants/colors.dart';
import 'package:betting_app_1/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatefulWidget {
  static String routeName = '/cart_page';
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                buttonPrimary.withOpacity(0.2),
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              CommonHeader(
                title: "Cart",
                backButtonAction: () => context.pop(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
