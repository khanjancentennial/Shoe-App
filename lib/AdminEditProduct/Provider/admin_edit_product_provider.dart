import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Widgets/admin_bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';

import '../../Widgets/bottom_navigation.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/admin_edit_product_model.dart';

class AdminEditProductProvider extends ChangeNotifier {
  late AdminEditProductModel adminEditProductModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  Future<AdminEditProductModel?> editProduct(
      BuildContext context,
      String productName,
      String brandName,
      String shoeType,
      String price,
      String details,
      String sizeArray,
      String shoeSizeText,
      String shoeColor,
      String productId,
      String firstName,
      String lastName
      ) async {

    startLoading();
    Map<String, dynamic> updateUserBody = {
      "productName" : productName,
      "brandName" : brandName,
      "shoeType": shoeType,
      "price" : price,
      "details" : details,
      "sizeArray" : sizeArray,
      "shoeSizeText" : shoeSizeText,
      "shoeColor" : shoeColor
    };
    try {
      http.Response response =
      await http.put(Uri.parse("${ApiNetwork.ADD_PRODUCT}/$productId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(updateUserBody));
      print(response);
      if (response.statusCode == 200) {
        adminEditProductModel = AdminEditProductModel.fromJson(json.decode(response.body));

        if(adminEditProductModel.success== true){

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminBottomNavigation(
              firstName: firstName,lastName: lastName,index: 0,)),
          );

          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: adminEditProductModel.message);
          stopLoading();
          notifyListeners();
        }else{
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.red,
              toastMessage: adminEditProductModel.message);
          stopLoading();
          notifyListeners();
        }

      } else {
        stopLoading();
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.red,
            toastMessage: adminEditProductModel.message);
        notifyListeners();
        adminEditProductModel = AdminEditProductModel.fromJson(json.decode(response.body));

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
    return adminEditProductModel;
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