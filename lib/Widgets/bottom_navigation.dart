import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/CustomerHomeScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../CustomerCart/customer_cart_screen.dart';
import '../CustomerOrderHistory/customer_order_history_screen.dart';
import '../CustomerProfile/customer_profile_screen.dart';
import '../CustomerSearch/customer_serach_screen.dart';
import '../utils/app_color.dart';

class BottomNavigation extends StatelessWidget {
  String? firstName;
  String? lastName;
  int? initialIndex;
  String? productName;
  String? image;
  int? qty;
  double? price;
  BottomNavigation({this.firstName,this.lastName,this.initialIndex,this.productName,this.image,this.qty,this.price});

  @override
  Widget build(BuildContext context) {

    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: initialIndex!);

    List<Widget> _buildScreens() {
      return [
        CustomerHomeScreen(firstName: firstName,lastName: lastName),
        CustomerSearchPage(),
        CustomerOrderHistory(),
        CustomerCartScreen(productName: productName,
          price: price,
          qty: qty,
          image: image),
        CustomerProfileScreen()
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_outlined),
          // title: ("Home"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search_outlined),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.history_outlined),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.shopping_cart_checkout),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.account_circle_outlined),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
      ];
    }

    return PersistentTabView(

      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.buttonColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: AppColors.buttonColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,

      // Choose the nav bar style with this property.
    );
  }
}
