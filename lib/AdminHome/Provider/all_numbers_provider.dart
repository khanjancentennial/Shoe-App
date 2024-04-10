import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerProfile/Model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/all_numbers_model.dart';

class AllNumbersProvider extends ChangeNotifier {
  late AllNumbersReport allNumbersReport;
  bool isLoading=false;
  bool isFemale = false;
  bool isMale = false;



  Future<AllNumbersReport?> getAllNumbersDetails(
      ) async {

    startLoading();

    try {

      http.Response response =
      await http.get(Uri.parse("${ApiNetwork.ALL_NUMBERS}"));
      print(response);
      if (response.statusCode == 200) {
        allNumbersReport = AllNumbersReport.fromJson(json.decode(response.body));

        if(allNumbersReport.success== true){


          // AppUtils.instance.showToast(
          //     textColor: Colors.white,
          //     backgroundColor: AppColors.green,
          //     toastMessage: getUserModel.message);
          stopLoading();
          notifyListeners();
        }else{

          stopLoading();
          notifyListeners();
        }

      } else {
        stopLoading();

        notifyListeners();
        allNumbersReport = AllNumbersReport.fromJson(json.decode(response.body));

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
    return allNumbersReport;
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