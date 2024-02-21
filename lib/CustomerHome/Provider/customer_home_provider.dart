import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/customer_home_products_model.dart';

class ProductsProvider extends ChangeNotifier {
  ProductsModel? productsModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController address = TextEditingController();

  Future<ProductsModel?> getProductsByCategory(
      String category,
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.PRODUCT_BY_CATEGORY}/$category"));
      print(response);
      if (response.statusCode == 200) {
        productsModel = ProductsModel.fromJson(json.decode(response.body));
        print("products ${productsModel}");
        if(productsModel!.success== true){


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
        productsModel = ProductsModel.fromJson(json.decode(response.body));

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
    return productsModel;
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