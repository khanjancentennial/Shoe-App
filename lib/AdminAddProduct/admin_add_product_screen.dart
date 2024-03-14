import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/AdminAddProduct/Model/select_size_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Widgets/button_with_text.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import 'Provider/admin_add_product_provider.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({super.key});

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {

  TextEditingController productName = TextEditingController();
  TextEditingController productType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController shoeSizeIn = TextEditingController();
  TextEditingController color = TextEditingController();
  FocusNode productNameFocusNode = FocusNode();
  FocusNode productTypeFocusNode = FocusNode();
  FocusNode priceFocusNode = FocusNode();
  FocusNode productDetailsFocusNode = FocusNode();
  FocusNode shoeSizeInFocusNode = FocusNode();
  FocusNode colorFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool isFirstTime = true;

  List<double> sizeArray = [];
  List<SelectSize> sizeList = [
    SelectSize(7.0, false),
    SelectSize(7.5, false),
    SelectSize(8.0, false),
    SelectSize(8.5, false),
    SelectSize(9.0, false),
    SelectSize(9.5, false),
    SelectSize(10.0, false),
    SelectSize(10.5, false),
    SelectSize(11.0, false),
    SelectSize(11.5, false),
    SelectSize(12.0, false),
    SelectSize(12.5, false),

  ];


  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  List<String> brandList = <String>['Nike', 'Adidas', 'Puma'];
  String dropdownValue = "";
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      setState(() {});
      dropdownValue = brandList.first;

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50,top: 10),
            child: Column(
              children: [
                const SizedBox(height: 50),

                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,

                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width -100,
                      child: Center(
                        child: Text("Add New Product",
                            style: AppUtils.instance.textStyle(
                              fontSize: 26,
                            )
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // first name
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    onTap: () {},
                    controller: productName,
                    focusNode: productNameFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Product Name",
                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 5,right: 11),
                      //   child: Image.asset(AppImage.user,
                      //     scale: 20,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter product name";
                      } else {
                        return null;
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    onTap: () {},
                    controller: productType,
                    focusNode: productTypeFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Shoe Type",
                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 5,right: 11),
                      //   child: Image.asset(AppImage.user,
                      //     scale: 20,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter shoe type";
                      } else {
                        return null;
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    onTap: () {},
                    controller: price,
                    focusNode: priceFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Price",
                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 5,right: 11),
                      //   child: Image.asset(AppImage.user,
                      //     scale: 20,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter price";
                      } else {
                        return null;
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    // textAlign : TextAlign.center,
                    maxLines: 2,
                    onTap: () {},
                    controller: productDetails,
                    focusNode: productDetailsFocusNode,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Product Details",

                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 11,right: 11),
                      //   child: Image.asset(AppImage.locationImage,
                      //     scale: 13,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter product details";
                      }
                      else{
                        return null;
                      }

                    },
                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    onTap: () {},
                    controller: shoeSizeIn,
                    focusNode: shoeSizeInFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Shoe Size in (US or UK)",
                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 5,right: 11),
                      //   child: Image.asset(AppImage.user,
                      //     scale: 20,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter shoe size";
                      } else {
                        return null;
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                    onTap: () {},
                    controller: color,
                    focusNode: colorFocusNode,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.textFieldColor,
                      hintText: "Enter Shoe Color",
                      hintStyle: AppUtils.instance.textStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      // prefixIcon: Container(
                      //   padding: const EdgeInsets.only(left: 5,right: 11),
                      //   child: Image.asset(AppImage.user,
                      //     scale: 20,
                      //     // color: AppColors.grey,
                      //   ),
                      // ),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Shoe color";
                      } else {
                        return null;
                      }
                    },

                  ),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 25,right: 20),
                  child: Row(
                    children: [

                      Text("Select Brand: ",
                          style: AppUtils.instance.textStyle(
                              color: AppColors.black,
                              fontSize: 18
                          )
                      ),
                      const SizedBox(width: 20),

                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: AppUtils.instance.textStyle(
                            color: AppColors.black,
                            fontSize: 18
                        ),
                        underline: Container(
                          height: 2,
                          color: AppColors.buttonColor,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: brandList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                    children: [
                      Text("Please Select Available Sizes:",
                          style: AppUtils.instance.textStyle(
                              fontSize: 20,
                              color: AppColors.black,
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: sizeList.length,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index) =>
                            Wrap(
                                spacing: 20.0, // Horizontal space.
                                runSpacing: 10.0,
                                children:[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5),
                                    child: InkWell(
                                      onTap: (){
                                        sizeList[index].isSelected = !sizeList[index].isSelected;
                                        setState(() {

                                        });
                                        if(sizeList[index].isSelected){
                                          sizeArray.add(sizeList[index].size);
                                          setState(() {
                                          });
                                        }else{
                                          sizeArray.remove(sizeList[index].size);
                                          setState(() {

                                          });
                                        }
                                      },
                                      child: Chip(
                                        backgroundColor: sizeList[index].isSelected? AppColors.buttonColor:AppColors.homeScreenColor,
                                        label: Text("${sizeList[index].size}",
                                          style: AppUtils.instance.textStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),

                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

                                      ),
                                    ),
                                  ),
                                ]

                            )

                    ),
                  ),
                ),

                const SizedBox(height: 2),

                isFirstTime == false ?
                sizeArray.isEmpty ?

                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 13),
                  child: Text("Please select show size",
                    style: AppUtils.instance.textStyle(
                        color: AppColors.darkRed
                    ),
                  ),
                )
                    :
                const SizedBox()
                :const SizedBox(),

                const SizedBox(height: 20),


                ElevatedButton(
                  onPressed: () {
                    selectImages();
                  },
                  child: const Text('Select Images'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(

                    shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: imageFileList!.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,crossAxisSpacing: 8, mainAxisSpacing: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 100,
                          child: Image.file(File(imageFileList![index].path),
                            fit: BoxFit.fill,
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 2),
                isFirstTime == false ?
                imageFileList!.isEmpty ?

                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 13),
                  child: Text("Please select images",
                    style: AppUtils.instance.textStyle(
                        color: AppColors.darkRed
                    ),
                  ),
                )
                    :
                const SizedBox()
                    :const SizedBox(),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: buttonWithText(
                      onPress: () {
                        validations();
                      },
                      bgColor: AppColors.buttonColor,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      text: "Add Product",
                      textColor: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  void selectImages() async {
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length: ${imageFileList!.length}");
    setState((){});
  }

  void validations() async {
    isFirstTime = false;
    setState(() {
    });

    if(_formKey.currentState!.validate()){

      if(sizeArray.isNotEmpty && imageFileList!.isNotEmpty){
        Provider.of<AdminAddProductProvider>(context, listen: false).addProducts(
          context,
          productName.text.toString(),
          dropdownValue.toString(),
          productType.text.toString(),
          price.text.toString(),
          productDetails.text.toString(),
          sizeArray,
          shoeSizeIn.text.toString(),
          color.text.toString(),
          imageFileList!
        );
      }


      //     .then((value) {
      //
      //   if (value!.success == true){
      //
      //     AppUtils.instance.showToast(
      //         textColor: Colors.white,
      //         backgroundColor: Colors.green,
      //         toastMessage: "${value.message}");
      //     Navigator.pop(context);
      //
      //   } else {
      //     AppUtils.instance.showToast(
      //         textColor: Colors.white,
      //         backgroundColor: AppColors.red,
      //         toastMessage: "${value.message}");
      //   }
      // });


    }
  }



}
