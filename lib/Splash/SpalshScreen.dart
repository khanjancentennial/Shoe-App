import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';

import '../AdminHome/AdminHomeScreen.dart';
import '../CustomerHome/CustomerHomeScreen.dart';
import '../Login/LoginScreen.dart';
import '../Widgets/admin_bottom_navigation.dart';
import '../Widgets/bottom_navigation.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLogin = false;
  String userType = "";
  String firstName = "";
  String lastName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (mounted) {
      isLogin = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLogin)??false;
      userType = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserType) ?? "";
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    checkUserLogin();
    return Scaffold(
        body: Stack(
          children: [
            Container(
              color: AppColors.textFieldColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              // child: Image.asset(AppImage.splash,
              //   fit: BoxFit.fill,
              // ),
            ),
            Positioned.fill(child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 300,width: 300,
                  child: Image.asset(AppImage.appLogo,
                  ),
                )
            )
            )
          ],
        ));
  }
  void checkUserLogin() async{

    setState(() {});
    Future.delayed(const Duration(seconds: 3), ()
    {
      if(isLogin){

        if(userType == "Customer"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(firstName: firstName,lastName: lastName)

                    // CustomerHomeScreen(firstName: firstName,lastName: lastName)
            ),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminBottomNavigation(firstName: firstName,lastName: lastName)
            ),
          );
        }


      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
    );
  }
}

