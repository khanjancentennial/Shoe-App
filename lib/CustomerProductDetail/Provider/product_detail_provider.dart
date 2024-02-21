import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/customer_product_detail_model.dart';

class ProductDetailProvider extends ChangeNotifier {
  ProductDetailModel? productDetailModel;
  bool isLoading=false;
  int items = 1;

  Future<ProductDetailModel?> getProductsById(
      String productId,
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.PRODUCT_DETAIL_BY_ID}/$productId"));
      print(response);
      if (response.statusCode == 200) {
        productDetailModel = ProductDetailModel.fromJson(json.decode(response.body));
        print("products ${productDetailModel}");

          stopLoading();
          notifyListeners();

      } else {
        stopLoading();
        // AppUtils.instance.showToast(
        //     textColor: Colors.white,
        //     backgroundColor: AppColors.red,
        //     toastMessage: registrationModel.message);
        notifyListeners();
        productDetailModel = ProductDetailModel.fromJson(json.decode(response.body));

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
    return productDetailModel;
  }

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }


  void addItems(){
    items ++;
    notifyListeners();
  }
  void removeItem(){
    items --;
    notifyListeners();
  }

}