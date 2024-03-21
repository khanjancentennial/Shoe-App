import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Widgets/admin_bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import '../../Login/LoginScreen.dart';
import '../../utils/api_network.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/exceptions.dart';
import '../Model/admin_add_product_model.dart';

class AdminAddProductProvider extends ChangeNotifier {
  AdminAddProductModel? adminAddProductModel;
  bool isLoading=false;
  bool isUK = false;
  bool isUS = false;

  Future<AdminAddProductModel?> addProducts(
      BuildContext context,
      String productName,
      String brandName,
      String shoeType,
      String price,
      String details,
      List<double> sizeArray,
      String shoeSizeText,
      String shoeColor,
      List<XFile> images
      ) async {

    startLoading();
    // Map<String, dynamic> registrationBody = {
    // "productName": productName,
    // "brandName": brandName,
    // "shoeType": shoeType,
    // "price": price,
    // "details": details,
    // "sizeArray": sizeArray,
    // "shoeSizeText": shoeSizeText,
    // "shoeColor":shoeColor
    // };
    final uri = Uri.parse('https://mapd726-api-2.onrender.com/products');

    try {
      var request =
      // await http.post(Uri.parse(ApiNetwork.REGISTER_URL),
      //     body: registrationBody);

      http.MultipartRequest('POST', uri);
      request.headers['Content-Type'] = 'multipart/form-data; boundary=<calculated when request is sent>';
      request.fields['productName'] = productName;
      request.fields['brandName'] = brandName;
      request.fields['shoeType'] = shoeType;
      request.fields['price'] = price;
      request.fields['details'] = details;
      request.fields['sizeArray'] = jsonEncode(sizeArray);
      request.fields['shoeSizeText'] = shoeSizeText;
      request.fields['shoeColor'] = shoeColor;

      // Add each image file to the request
      for (var imageFile in images) {
        var image = await http.MultipartFile.fromPath('imageList', imageFile.path);
        request.files.add(image);
      }
      // var image = await http.MultipartFile.fromPath('image', images[].path);
      // request.files.add(image);
      var response = await request.send().then((value) {
        print(value);
        return value;
      });

      print(response.statusCode);

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        adminAddProductModel = AdminAddProductModel.fromJson(jsonResponse);

        // print(adminAddProductModel);
        // adminAddProductModel = AdminAddProductModel.fromJson(jsonDecode(await response.stream.bytesToString()));

        if(adminAddProductModel!.success== true){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminBottomNavigation(index: 2)),
          );
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.green,
              toastMessage: adminAddProductModel!.message);
          stopLoading();
          notifyListeners();
        }else{
          AppUtils.instance.showToast(
              textColor: Colors.white,
              backgroundColor: AppColors.red,
              toastMessage: adminAddProductModel!.message);
          stopLoading();
          notifyListeners();
        }

      } else {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        adminAddProductModel = AdminAddProductModel.fromJson(jsonResponse);
        stopLoading();
        AppUtils.instance.showToast(
            textColor: Colors.white,
            backgroundColor: AppColors.red,
            toastMessage: adminAddProductModel!.message);
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
    return adminAddProductModel;
  }

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading=false;
    notifyListeners();
  }

  void showSizeInCheck(String showSizeIn){
    if(showSizeIn == "US"){
      isUS = !isUS;
      isUK = false;
      notifyListeners();
    }else{
      isUK = !isUK;
      isUS = false;
      notifyListeners();
    }
  }

}