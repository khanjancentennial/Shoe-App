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
import '../Model/top_five_products_model.dart';
import '../Model/top_values_model.dart';

class TopValuesProvider extends ChangeNotifier {
  TopValuesModel? topValuesModel ;
  bool isLoading=false;

  Future<TopValuesModel?> reportData(BuildContext context,String firstDate, String lastDate) async {

    startLoading();
    Map<String, dynamic> loginDataBody = {
      "startDate": firstDate,
      "endDate": lastDate
    };
    try {
      print(loginDataBody);
      http.Response response =
      await http.post(Uri.parse(ApiNetwork.ALL_VALUES),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(loginDataBody));
      print(response.body);
      if (response.statusCode == 200) {
        topValuesModel = TopValuesModel.fromJson(json.decode(response.body));

        if(topValuesModel!.success == true){


          stopLoading();
          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.green,
          //     toastMessage: "Login Successful");


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
    return topValuesModel;
  }

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }

}