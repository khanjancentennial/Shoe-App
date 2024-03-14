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
import '../Model/admin_delete_product_model.dart';

class AdminDeleteProductProvider extends ChangeNotifier {
  AdminDeleteProductModel? adminDeleteProductModel;
  bool isLoading=false;

  Future<AdminDeleteProductModel?> deleteProduct(BuildContext context,String productId) async {

    startLoading();

    try {

      http.Response response =
      await http.delete(Uri.parse("${ApiNetwork.ADD_PRODUCT}/$productId"),
          );


      if (response.statusCode == 200) {
        adminDeleteProductModel = AdminDeleteProductModel.fromJson(json.decode(response.body));

        if(adminDeleteProductModel!.success == true){

          stopLoading();
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: adminDeleteProductModel!.message);


          notifyListeners();
        }else{
          stopLoading();
          // loginData = LoginModel.fromJson(json.decode(response.body));
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.darkRed,
              toastMessage: adminDeleteProductModel!.message);
          notifyListeners();
        }

      }
      else {
        stopLoading();
        // loginData = LoginModel.fromJson(json.decode(response.body));
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.darkRed,
            toastMessage: adminDeleteProductModel!.message);
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
    return adminDeleteProductModel;
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