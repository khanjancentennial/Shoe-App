import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group1_mapd726_shoe_app/Registration/Provider/registration_provider.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:provider/provider.dart';

import 'CustomerHome/Provider/customer_home_provider.dart';
import 'CustomerProductDetail/Provider/product_detail_provider.dart';
import 'CustomerProfile/Provider/update_profile_provider.dart';
import 'CustomerProfile/Provider/user_profile_provider.dart';
import 'Login/Provider/LoginProvider.dart';
import 'Splash/SpalshScreen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
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
