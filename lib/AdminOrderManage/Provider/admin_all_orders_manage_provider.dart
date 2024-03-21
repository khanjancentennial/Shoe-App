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
import '../Model/admin_all_order_manage_model.dart';

class AdminAllOrdersManageProvider extends ChangeNotifier {
  AdminOrdersManageModel? adminOrdersManageModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  List<Orders> pendingOrders = [];
  List<Orders> deliveredOrders = [];

  Future<AdminOrdersManageModel?> allOrders(
      BuildContext context,
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse(ApiNetwork.ADMIN_ALL_ORDERS),
      );


      print(response.statusCode);

      if (response.statusCode == 200) {

        adminOrdersManageModel = AdminOrdersManageModel.fromJson(json.decode(response.body));

        // print(adminAddProductModel);
        // adminAddProductModel = AdminAddProductModel.fromJson(jsonDecode(await response.stream.bytesToString()));

        if(adminOrdersManageModel!.success== true){
          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.green,
          //     toastMessage: allOrdersByCustomerIdModel!.message);
          pendingOrders = [];
          deliveredOrders = [];

          for(int i = 0; i< adminOrdersManageModel!.orders!.length; i++){
            if(adminOrdersManageModel!.orders![i].status == "Delivered"){
              deliveredOrders.add(adminOrdersManageModel!.orders![i]);
              notifyListeners();
            }else{
              pendingOrders.add(adminOrdersManageModel!.orders![i]);
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

        adminOrdersManageModel = AdminOrdersManageModel.fromJson(json.decode(response.body));
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
    return adminOrdersManageModel;
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