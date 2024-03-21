import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Widgets/admin_bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:async';

import '../../Login/LoginScreen.dart';
import '../../Widgets/bottom_navigation.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/all_order_by_customer_id_model.dart';

class AllOrdersByCustomerIdProvider extends ChangeNotifier {
  AllOrdersByCustomerIdModel? allOrdersByCustomerIdModel;
  List<Orders> pendingOrders = [];
  List<Orders> deliveredOrders = [];
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  Future<AllOrdersByCustomerIdModel?> allOrders(
      BuildContext context,
      String customerId,
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.CUSTOMER_ORDER_LIST}/$customerId"),
      );


      print(response.statusCode);

      if (response.statusCode == 200) {

        allOrdersByCustomerIdModel = AllOrdersByCustomerIdModel.fromJson(json.decode(response.body));

        // print(adminAddProductModel);
        // adminAddProductModel = AdminAddProductModel.fromJson(jsonDecode(await response.stream.bytesToString()));

        if(allOrdersByCustomerIdModel!.success== true){
          deliveredOrders = [];
          pendingOrders = [];
          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.green,
          //     toastMessage: allOrdersByCustomerIdModel!.message);
          for(int i = 0; i< allOrdersByCustomerIdModel!.orders!.length; i++){
            if(allOrdersByCustomerIdModel!.orders![i].status == "Delivered"){
              deliveredOrders.add(allOrdersByCustomerIdModel!.orders![i]);
              notifyListeners();
            }else{
              pendingOrders.add(allOrdersByCustomerIdModel!.orders![i]);
              notifyListeners();
            }
          }
          stopLoading();
          notifyListeners();
        }else{
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.red,
              toastMessage: "No data");
          stopLoading();
          notifyListeners();
        }

      } else {

        allOrdersByCustomerIdModel = AllOrdersByCustomerIdModel.fromJson(json.decode(response.body));
        stopLoading();
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.red,
            toastMessage: "No data");
        notifyListeners();
        // adminAddProductModel = AdminAddProductModel.fromJson(json.decode(response.body));

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
    return allOrdersByCustomerIdModel;
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