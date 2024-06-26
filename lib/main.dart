import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:group1_mapd726_shoe_app/Registration/Provider/registration_provider.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:provider/provider.dart';

import 'AdminAddProduct/Provider/admin_add_product_provider.dart';
import 'AdminEditProduct/Provider/admin_edit_product_provider.dart';
import 'AdminHome/Provider/all_numbers_provider.dart';
import 'AdminHome/Provider/top_five_products_provider.dart';
import 'AdminHome/Provider/top_values_provider.dart';
import 'AdminOrderManage/Provider/admin_all_orders_manage_provider.dart';
import 'AdminOrderManage/Provider/admin_change_order_status_provider.dart';
import 'AdminProductDetail/Provider/admin_delete_product.dart';
import 'AdminProductDetail/Provider/product_detail_provider.dart';
import 'AdminUsersManage/Provider/delete_user_provider.dart';
import 'AdminUsersManage/Provider/get_all_users_provider.dart';
import 'AdminUsersManage/Provider/update_profile_provider.dart';
import 'CustomerCart/Provider/add_items_in_cart_provider.dart';
import 'CustomerCart/Provider/all_cart_items_provider.dart';
import 'CustomerCart/Provider/delete_cart_items_provider.dart';
import 'CustomerHome/Provider/customer_home_provider.dart';
import 'CustomerOrderHistory/Provider/all_order_by_customer_id_provider.dart';
import 'CustomerOrderHistory/Provider/checkout_provider.dart';
import 'CustomerOrderHistory/Provider/customer_delete_order_by_id_provider.dart';
import 'CustomerProductDetail/Provider/product_detail_provider.dart';
import 'CustomerProfile/Provider/update_profile_provider.dart';
import 'CustomerProfile/Provider/user_profile_provider.dart';
import 'Login/Provider/LoginProvider.dart';
import 'Splash/SpalshScreen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // await dotenv.Load; fileName: "assets/env");
  Stripe.publishableKey = "pk_test_51Oy4n800d1dMf41hrQHTcvcjU7z4XICAvZys4dXBDVFWEWgsROnrelmmQosMIT04ojpFRxyU8OBw4cjiJWJgMffH00NhkiSZvR";
  // await Stripe.instance.applySettings();
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<LoginProvider>(create: (context) => LoginProvider()),
        ChangeNotifierProvider<RegistrationProvider>(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider<UserProfileProvider>(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider<UpdateProfileProvider>(create: (context) => UpdateProfileProvider()),
        ChangeNotifierProvider<ProductsProvider>(create: (context) => ProductsProvider()),
        ChangeNotifierProvider<ProductDetailProvider>(create: (context) => ProductDetailProvider()),

        ChangeNotifierProvider<AdminProductDetailProvider>(create: (context) => AdminProductDetailProvider()),
        ChangeNotifierProvider<AdminAddProductProvider>(create: (context) => AdminAddProductProvider()),
        ChangeNotifierProvider<AdminDeleteProductProvider>(create: (context) => AdminDeleteProductProvider()),
        ChangeNotifierProvider<AdminEditProductProvider>(create: (context) => AdminEditProductProvider()),

        ChangeNotifierProvider<AddItemsInCartProvider>(create: (context) => AddItemsInCartProvider()),
        ChangeNotifierProvider<AllCartItemsProvider>(create: (context) => AllCartItemsProvider()),
        ChangeNotifierProvider<DeleteCaretItemsProvider>(create: (context) => DeleteCaretItemsProvider()),

        ChangeNotifierProvider<CheckOutProvider>(create: (context) => CheckOutProvider()),
        ChangeNotifierProvider<AllOrdersByCustomerIdProvider>(create: (context) => AllOrdersByCustomerIdProvider()),
        ChangeNotifierProvider<CustomerDeleteOrderByIdProvider>(create: (context) => CustomerDeleteOrderByIdProvider()),

        ChangeNotifierProvider<AdminAllOrdersManageProvider>(create: (context) => AdminAllOrdersManageProvider()),
        ChangeNotifierProvider<AdminChangeOrderStatusProvider>(create: (context) => AdminChangeOrderStatusProvider()),

        ChangeNotifierProvider<GetAllUsersProvider>(create: (context) => GetAllUsersProvider()),
        ChangeNotifierProvider<DeleteUserProvider>(create: (context) => DeleteUserProvider()),
        ChangeNotifierProvider<UpdateUserProfileProvider>(create: (context) => UpdateUserProfileProvider()),

        ChangeNotifierProvider<AllNumbersProvider>(create: (context) => AllNumbersProvider()),
        ChangeNotifierProvider<TopFiveProductsProvider>(create: (context) => TopFiveProductsProvider()),
        ChangeNotifierProvider<TopValuesProvider>(create: (context) => TopValuesProvider()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
              backgroundColor: AppColors.homeScreenColor,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black
              ),
              centerTitle: false,
              iconTheme: IconThemeData(color: AppColors.black)
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
