import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/AdminOrderManage/admin_order_manage_screen.dart';
import 'package:group1_mapd726_shoe_app/AdminProductManage/admin_product_manage_screen.dart';
import 'package:group1_mapd726_shoe_app/AdminUsersManage/admin_user_manage_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../AdminHome/AdminHomeScreen.dart';
import '../CustomerCart/customer_cart_screen.dart';
import '../CustomerOrderHistory/customer_order_history_screen.dart';
import '../CustomerProfile/customer_profile_screen.dart';
import '../CustomerSearch/customer_serach_screen.dart';
import '../utils/app_color.dart';

class AdminBottomNavigation extends StatelessWidget {
  String? firstName;
  String? lastName;
  int? index;
  AdminBottomNavigation({this.firstName,this.lastName,this.index});

  @override
  Widget build(BuildContext context) {

    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: index!);

    List<Widget> _buildScreens() {
      return [
        AdminHomeScreen(firstName: firstName,lastName: lastName),
        AdminOrderManageScreen(),
        AdminProductManageScreen(),
        AdminUserManageScreen(),
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
          icon: Icon(Icons.format_list_numbered_rtl_outlined),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.inventory_2_outlined),
          // title: ("Settings"),
          activeColorPrimary: AppColors.black,
          inactiveColorPrimary: AppColors.white,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.manage_accounts_outlined),
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
