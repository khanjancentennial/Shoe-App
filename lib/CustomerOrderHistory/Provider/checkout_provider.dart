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
import '../Model/checout_model.dart';

class CheckOutProvider extends ChangeNotifier {
  CheckOutModel? checkOutModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;

  Future<CheckOutModel?> checkOut(
      BuildContext context,
      String customerId,
      String firstName,
      String lastName
      ) async {

    startLoading();

    try {
      http.Response response =
      await http.post(Uri.parse("${ApiNetwork.CHECKOUT}/$customerId"),
          );


      print(response.statusCode);

      if (response.statusCode == 200) {

        checkOutModel = CheckOutModel.fromJson(json.decode(response.body));

        // print(adminAddProductModel);
        // adminAddProductModel = AdminAddProductModel.fromJson(jsonDecode(await response.stream.bytesToString()));

        if(checkOutModel!.success== true){

          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: BottomNavigation(initialIndex: 1,firstName: firstName,lastName: lastName,userId: customerId),
            withNavBar: false, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => BottomNavigation(initialIndex: 2,firstName: firstName,lastName: lastName,userId: customerId)),
          // );
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: checkOutModel!.message);
          stopLoading();
          notifyListeners();
        }else{
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.red,
              toastMessage: checkOutModel!.message);
          stopLoading();
          notifyListeners();
        }

      } else {

        checkOutModel = CheckOutModel.fromJson(json.decode(response.body));
        stopLoading();
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.red,
            toastMessage: checkOutModel!.message);
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
    return checkOutModel;
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