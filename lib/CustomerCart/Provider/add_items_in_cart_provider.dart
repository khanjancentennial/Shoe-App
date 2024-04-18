import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerCart/Model/add_items_in_cart_model.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/CustomerHomeScreen.dart';
import 'package:http/http.dart' as http;

import 'dart:async';


import '../../Widgets/bottom_navigation.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';

class AddItemsInCartProvider extends ChangeNotifier {
  AddItemsInCartModel? addItemsInCartModel;
  bool isLoading=false;

  Future<AddItemsInCartModel?> addItemsInCart(BuildContext context,
      String productId,
      String userId,
      int qty,
      double totalPrice,
      String firstName,
      String lastName) async {

    startLoading();
    Map<String, dynamic> cartItemDetails = {
      "productId": productId,
      "userId": userId,
      "quantity": qty,
      "totalPrice":totalPrice
    };
    try {
      http.Response response =
      await http.post(Uri.parse(ApiNetwork.ADD_ITEMS_IN_CART),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(cartItemDetails));
      print(response.body);
      if (response.statusCode == 200) {
        addItemsInCartModel = AddItemsInCartModel.fromJson(json.decode(response.body));

        if(addItemsInCartModel!.success == true){

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation(userId:userId,firstName: firstName,lastName: lastName,initialIndex: 2)

              // CustomerHomeScreen(firstName: firstName,lastName: lastName)
            ),
          );
          stopLoading();
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: addItemsInCartModel!.message);


          notifyListeners();
        }else{
          stopLoading();
          // loginData = LoginModel.fromJson(json.decode(response.body));
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.darkRed,
              toastMessage: addItemsInCartModel!.message);
          notifyListeners();
        }

      }
      else {
        stopLoading();
        // loginData = LoginModel.fromJson(json.decode(response.body));
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.darkRed,
            toastMessage: "Server Error");
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
    return addItemsInCartModel;
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