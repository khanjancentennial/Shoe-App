import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/get_all_users_model.dart';

class GetAllUsersProvider extends ChangeNotifier {
  GetAllCustomersModel? getAllCustomersModel;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;


  Future<GetAllCustomersModel?> getAllUsers() async {

    startLoading();

    try {
      http.Response response =
      await http.get(Uri.parse(ApiNetwork.ALL_USERS));
      print(response);
      if (response.statusCode == 200) {
        getAllCustomersModel = GetAllCustomersModel.fromJson(json.decode(response.body));
        print("usaers ${getAllCustomersModel}");
        if(getAllCustomersModel!.success== true){


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
        getAllCustomersModel = GetAllCustomersModel.fromJson(json.decode(response.body));
        // AppUtils.instance.showToast(
        //     textColor: Colors.white,
        //     backgroundColor: AppColors.red,
        //     toastMessage: registrationModel.message);
        notifyListeners();


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
    return getAllCustomersModel;
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