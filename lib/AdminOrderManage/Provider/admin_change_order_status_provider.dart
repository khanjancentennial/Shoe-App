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
import '../Model/admin_change_order_status_model.dart';

class AdminChangeOrderStatusProvider extends ChangeNotifier {
  AdminChangeOrderStatusModel? adminChangeOrderStatusModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  Future<AdminChangeOrderStatusModel?> changeOrderStatus(
      BuildContext context,
      String orderId,
      String orderStatus,
      String firstName,
      String lastName,
      ) async {

    Map<String, dynamic> statusChange = {
      "status": orderStatus,
    };
    startLoading();

    try {
      http.Response response =
      await http.put(Uri.parse("${ApiNetwork.ADMIN_ALL_ORDERS_STATUS_CHANGE}/$orderId"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        body: jsonEncode(statusChange)
      );


      print(response.statusCode);

      if (response.statusCode == 200) {

        adminChangeOrderStatusModel = AdminChangeOrderStatusModel.fromJson(json.decode(response.body));

        // print(adminAddProductModel);
        // adminAddProductModel = AdminAddProductModel.fromJson(jsonDecode(await response.stream.bytesToString()));

        if(adminChangeOrderStatusModel!.success== true){
          // Navigator.pop(context);
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: AdminBottomNavigation(index: 1,firstName: firstName,lastName: lastName),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );

          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: adminChangeOrderStatusModel!.message);

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

        adminChangeOrderStatusModel = AdminChangeOrderStatusModel.fromJson(json.decode(response.body));
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
    return adminChangeOrderStatusModel;
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