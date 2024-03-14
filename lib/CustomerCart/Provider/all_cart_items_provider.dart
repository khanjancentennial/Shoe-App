import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/all_cart_items_model.dart';

class AllCartItemsProvider extends ChangeNotifier {
  AllCartItemsModel? allCartItemsModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;
  double totalPriceInLoop = 0.0;
  double totalPrice = 0.0;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController address = TextEditingController();

  Future<AllCartItemsModel?> getProductsByCustomerId(
      String customerId,
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.GET_ALL_CART_ITEMS}/$customerId"));
      print(response);
      if (response.statusCode == 200) {
        allCartItemsModel = AllCartItemsModel.fromJson(json.decode(response.body));
        // print("products ${allCartItemsModel}");
        if(allCartItemsModel!.success== true){


          stopLoading();
          getTotal();
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
        allCartItemsModel = AllCartItemsModel.fromJson(json.decode(response.body));

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
    return allCartItemsModel;
  }

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }

  getTotal(){
    for(int i =0;i< allCartItemsModel!.cartItems!.length;i++){
      totalPriceInLoop = allCartItemsModel!.cartItems![i].totalPrice!;
      totalPrice = totalPrice + totalPriceInLoop;
    }
  }

  deleteTotalPrice(){
    totalPrice = 0.0;
    notifyListeners();
  }

}