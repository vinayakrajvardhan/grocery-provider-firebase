import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:grocery_implementation/models/cart_model.dart';
import 'package:grocery_implementation/provider/dark_theme_provider.dart';
import 'package:grocery_implementation/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'cart/cart_screen.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'user_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': HomeScreen(), 'title': 'Home Screen'},
    {'page': CategoriesScreen(), 'title': 'Categories Screen'},
    {'page': CartScreen(), 'title': 'Cart Screen'},
    {'page': UserScreen(), 'title': 'User Screen'},
  ];
  @override
  Widget build(BuildContext context) {
    bool _isDark = context.watch<DarkThemeProvider>().getDarkTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        centerTitle: true,
        title: Text(
          _pages[_selectedIndex]['title'],
          style: TextStyle(
            color: _isDark ? Colors.amber : Colors.red,
          ),
        ),
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          currentIndex: _selectedIndex,
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: _isDark ? Colors.red : Colors.blueAccent,
          selectedLabelStyle: TextStyle(color: Colors.amber),
          unselectedLabelStyle: TextStyle(color: Colors.red),
          selectedItemColor:
              _isDark ? Colors.lightBlue.shade200 : Colors.black87,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Consumer<CartProvider>(builder: (context, myCart, child) {
                return Badge(
                  toAnimate: true,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(2),
                  badgeContent: Text(
                    myCart.getCartItems.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  child: Icon(
                      _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                );
              }),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: "User",
            ),
          ]),
    );
  }
}
