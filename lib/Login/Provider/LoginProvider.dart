import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/CustomerHomeScreen.dart';
import 'package:http/http.dart' as http;

import 'dart:async';


import '../../AdminHome/AdminHomeScreen.dart';
import '../../Widgets/admin_bottom_navigation.dart';
import '../../Widgets/bottom_navigation.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../../utils/preference_key.dart';
import '../Model/login_model.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel? loginData;
  bool isLoading=false;

  Future<LoginModel?> loginUser(BuildContext context,String emailId, String getPassword) async {

    startLoading();
    Map<String, dynamic> loginDataBody = {
      "email": emailId,
      "password": getPassword
    };
    try {
          http.Response response =
          await http.post(Uri.parse(ApiNetwork.LOGIN_URL), body: loginDataBody);
          if (response.statusCode == 200) {
            loginData = LoginModel.fromJson(json.decode(response.body));

            if(loginData!.success == true){
              if(loginData!.user!.userType == "Customer"){
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                        builder: (context) =>

                            BottomNavigation(firstName: loginData!.user!.firstName,
                                lastName: loginData!.user!.lastName)

                            // CustomerHomeScreen(firstName: loginData!.user!.firstName,
                            // lastName: loginData!.user!.lastName)

                    ),
                        (Route<dynamic> route) => false);
                AppUtils.instance.addPref(PreferenceKey.boolKey, PreferenceKey.prefLogin,true);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefFirstName,loginData!.user!.firstName);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefLastName,loginData!.user!.lastName);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserType,loginData!.user!.userType);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserId,loginData!.user!.sId);
              }else{
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(
                        builder: (context) =>

                            AdminBottomNavigation(firstName: loginData!.user!.firstName,
                                lastName: loginData!.user!.lastName)

                      // CustomerHomeScreen(firstName: loginData!.user!.firstName,
                      // lastName: loginData!.user!.lastName)

                    ),
                        (Route<dynamic> route) => false);
                AppUtils.instance.addPref(PreferenceKey.boolKey, PreferenceKey.prefLogin,true);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefFirstName,loginData!.user!.firstName);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefLastName,loginData!.user!.lastName);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserType,loginData!.user!.userType);
                AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserId,loginData!.user!.sId);

              }

              stopLoading();
              AppUtils.instance.showToast(
                  textColor: Colors.white,
                  backgroundColor: AppColors.green,
                  toastMessage: "Login Successful");


              notifyListeners();
            }else{
              stopLoading();
              // loginData = LoginModel.fromJson(json.decode(response.body));
              AppUtils.instance.showToast(
                  textColor: Colors.white,
                  backgroundColor: AppColors.darkRed,
                  toastMessage: "Invalid email or password");
              notifyListeners();
            }

          }
          else {
            stopLoading();
            // loginData = LoginModel.fromJson(json.decode(response.body));
            AppUtils.instance.showToast(
                textColor: Colors.white,
                backgroundColor: AppColors.darkRed,
                toastMessage: "Invalid email or password");
            notifyListeners();
          }
          notifyListeners();


    }
    on TimeoutException catch (e) {
      throw TimeOutException(e.message!);
    } on SocketException catch (e) {

    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } on IOException catch (e) {
      throw IOException(e.message);
    }
    on Exception catch (e) {
      stopLoading();
      print(e.toString());
    }
    notifyListeners();
    return loginData;
  }

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }

  bool emailStructure(String emailValueCheck){
    bool emailIsValid=false;
    String  emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp emailRegExp = new RegExp(emailPattern);
    emailIsValid= emailRegExp.hasMatch(emailValueCheck);
    // notifyListeners();
    return emailIsValid;
  }

  bool passwordStructure(String value){
    bool passwordIsValid=false;
    String  passwordPattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d][A-Za-z\d!@#$%^&*()_+]{7,}$';
    RegExp passwordRegExp = new RegExp(passwordPattern);
    passwordIsValid= passwordRegExp.hasMatch(value);
    // notifyListeners();
    return passwordIsValid;

  }
}