import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerProfile/Model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../Login/LoginScreen.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';

class UserProfileProvider extends ChangeNotifier {
  late GetUserModel getUserModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController address = TextEditingController();

  Future<GetUserModel?> getUserDetails(
      String userId,
      ) async {

    startLoading();

    try {
      firstNameController.text =  "";
      lastNameController.text =  "";
      emailController.text =  "";
      phoneController.text =  "";
      address.text =  "";
      isMale = false;
      isFemale = false;
      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.USER_URL}/$userId"));
      print(response);
      if (response.statusCode == 200) {
        getUserModel = GetUserModel.fromJson(json.decode(response.body));

        if(getUserModel.success== true){

          firstNameController.text =  firstNameController.text == "" ? getUserModel.user!.firstName! : firstNameController.text;
          lastNameController.text =  lastNameController.text == "" ? getUserModel.user!.lastName! : lastNameController.text;
          emailController.text =  emailController.text == "" ? getUserModel.user!.email! : emailController.text;
          phoneController.text =  phoneController.text == "" ? getUserModel.user!.phoneNumber! : phoneController.text;
          address.text =  address.text == "" ? getUserModel.user!.address! : address.text;
          isMale = getUserModel.user!.gender == "Male" ? true: false;
          isFemale = getUserModel.user!.gender == "Female" ? true: false;
          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.green,
          //     toastMessage: getUserModel.message);
          stopLoading();
          notifyListeners();
        }else{
          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.red,
          //     toastMessage: getUserModel.message);
          stopLoading();
          notifyListeners();
        }

      } else {
        stopLoading();
        // AppUtils.instance.showToast(
        //     textColor: Colors.white,
        //     backgroundColor: AppColors.red,
        //     toastMessage: registrationModel.message);
        notifyListeners();
        getUserModel = GetUserModel.fromJson(json.decode(response.body));

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
    return getUserModel;
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