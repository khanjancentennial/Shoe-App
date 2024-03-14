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
import '../Model/delete_cart_items_model.dart';

class DeleteCaretItemsProvider extends ChangeNotifier {
  DeleteCartItems? deleteCartItems;
  bool isLoading=false;

  Future<DeleteCartItems?> deleteCartItem(BuildContext context,String cartItemId) async {

    startLoading();

    try {

      http.Response response =
      await http.delete(Uri.parse("${ApiNetwork.ADD_ITEMS_IN_CART}/$cartItemId"),
      );


      if (response.statusCode == 200) {
        deleteCartItems = DeleteCartItems.fromJson(json.decode(response.body));

        if(deleteCartItems!.success == true){

          stopLoading();
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: deleteCartItems!.message);


          notifyListeners();
        }else{
          stopLoading();
          // loginData = LoginModel.fromJson(json.decode(response.body));
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.darkRed,
              toastMessage: deleteCartItems!.message);
          notifyListeners();
        }

      }
      else {
        stopLoading();
        // loginData = LoginModel.fromJson(json.decode(response.body));
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.darkRed,
            toastMessage: deleteCartItems!.message);
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
    return deleteCartItems;
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