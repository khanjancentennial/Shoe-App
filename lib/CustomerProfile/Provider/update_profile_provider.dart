import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/CustomerHomeScreen.dart';
import 'package:group1_mapd726_shoe_app/Widgets/admin_bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';

import '../../Login/LoginScreen.dart';
import '../../Widgets/bottom_navigation.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/update_profile_model.dart';

class UpdateProfileProvider extends ChangeNotifier {
  late UpdateProfileModel updateProfileModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  Future<UpdateProfileModel?> addUserDetails(
      BuildContext context,
      String userId,
      String firstName,
      String lastName,
      String emailId,
      String address,
      String phoneNumber,
      String gender,
      String userType
      ) async {

    startLoading();
    Map<String, dynamic> updateUserBody = {
      "_id" : userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": emailId,
      "gender":gender,
      "phoneNumber": phoneNumber,
      "address": address,
      "userType": userType,
    };
    try {
      http.Response response =
      await http.put(Uri.parse("${ApiNetwork.USER_URL}/${userId}"),
          body: updateUserBody);
      print(response);
      if (response.statusCode == 200) {
        updateProfileModel = UpdateProfileModel.fromJson(json.decode(response.body));

        if(updateProfileModel.success== true){
          if(userType == "Customer"){
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: BottomNavigation(firstName: firstName, lastName: lastName),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }else{
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: AdminBottomNavigation(firstName: firstName, lastName: lastName),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }

          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: updateProfileModel.message);
          stopLoading();
          notifyListeners();
        }else{
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.red,
              toastMessage: updateProfileModel.message);
          stopLoading();
          notifyListeners();
        }

      } else {
        stopLoading();
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.red,
            toastMessage: updateProfileModel.message);
        notifyListeners();
        updateProfileModel = UpdateProfileModel.fromJson(json.decode(response.body));

      }
      notifyListeners();
    }
    on TimeoutException catch (e) {
      throw TimeOutException(e.message!);
    } on SocketException catch (e) {
      AppUtils.instance.showToast(
          textColor: Colors.white,
          backgroundColor: AppColors.red,
          toastMessage: "Your internet is off");
    }
    on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } on IOException catch (e) {
      throw IOException(e.message);
    }
    on Exception catch (e) {
      stopLoading();
      print(e.toString());

    }
    notifyListeners();
    return updateProfileModel;
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
    String  emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9_-]+\.[a-zA-Z]+";
    RegExp emailRegExp = new RegExp(emailPattern);
    emailIsValid= emailRegExp.hasMatch(emailValueCheck);
    notifyListeners();
    return emailIsValid;
  }

  bool passwordStructure(String value){
    bool passwordIsValid=false;
    String  passwordPattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d][A-Za-z\d!@#$%^&*()_+]{7,}$';
    RegExp passwordRegExp = RegExp(passwordPattern);
    passwordIsValid= passwordRegExp.hasMatch(value);
    print("password $passwordIsValid");
    notifyListeners();
    return passwordIsValid;

  }

  void genderCheck(String gender){
    if(gender == "Male"){
      isMale = !isMale;
      isFemale = false;
      notifyListeners();
    }else{
      isFemale = !isFemale;
      isMale = false;
      notifyListeners();
    }
  }
}