import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:group1_mapd726_shoe_app/CustomerCart/customer_cart_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../Widgets/bottom_navigation.dart';
import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/product_detail_provider.dart';

class CustomerProductDetailScreen extends StatefulWidget {

  String? id;
  String? firstName;
  String? lastName;

  CustomerProductDetailScreen({super.key, this.id,this.firstName,this.lastName});

  @override
  State<CustomerProductDetailScreen> createState() => _CustomerProductDetailScreenState();
}

class _CustomerProductDetailScreenState extends State<CustomerProductDetailScreen> {

  bool isSelected = false;
  String sizeToCheck = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      setState(() {});
      Provider.of<ProductDetailProvider>(context,listen: false).getProductsById(widget.id!);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:
        Container(
          color: AppColors.white,
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const SizedBox(height: 30),

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
                  child: Text("Details",
                      style: AppUtils.instance.textStyle(
                        fontSize: 26,
                      )
                  ),
                ),
              ),
            ],
          ),


          Consumer<ProductDetailProvider>(
            builder: (_, productDetail, child) =>

            productDetail.isLoading ?

            Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()))
                :

            productDetail.productDetailModel!.success! ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    CarouselSlider.builder(
                        itemCount: productDetail.productDetailModel!.product!.imagesArray!.length,
                        itemBuilder: (BuildContext context, itemIndex, pageViewIndex) =>
                            Container(
                              // color: AppColors.textFieldColor,
                              child: Image.network(productDetail.productDetailModel!.product!.imagesArray![itemIndex],
                                scale: 1.0,
                              ),
                            ),
                        options: CarouselOptions(
                          height: 200,
                          // aspectRatio: 16/9,
                          // viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 1.0,
                          scrollDirection: Axis.horizontal,

                        )
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text(productDetail.productDetailModel!.product!.productName!,
                          style: AppUtils.instance.textStyle(
                              fontSize: 26,
                              color: AppColors.buttonColor,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),

                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text(productDetail.productDetailModel!.product!.shoeType!,
                          style: AppUtils.instance.textStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          child: Text("Brand :",
                              style: AppUtils.instance.textStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),

                        Text(productDetail.productDetailModel!.product!.brandName!,
                            style: AppUtils.instance.textStyle(
                                fontSize: 18,
                                color: AppColors.black
                            )
                        ),

                      ],
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text("Details:",
                          style: AppUtils.instance.textStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),

                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text(productDetail.productDetailModel!.product!.details!,
                          style: AppUtils.instance.textStyle(
                              fontSize: 18,
                              color: AppColors.black,
                          )
                      ),
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Text("Select Size:",
                          style: AppUtils.instance.textStyle(
                              fontSize: 20,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: productDetail.productDetailModel!.product!.sizeArray!.length,
                          physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index) =>
                            Wrap(
                                spacing: 20.0, // Horizontal space.
                                runSpacing: 30.0,
                                children:[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5),
                                  child: InkWell(
                                    onTap: (){
                                      sizeToCheck = "${productDetail.productDetailModel!.product!.sizeArray![index]}";
                                      if (isSizeSelected(sizeToCheck)) {
                                        print("$sizeToCheck is selected.");
                                        isSelected = true;
                                        setState(() {});
                                      } else {
                                        print("$sizeToCheck is not selected.");
                                        isSelected = false;
                                        setState(() {});
                                      }
                                    },
                                    child: Chip(
                                      backgroundColor: isSelected && sizeToCheck == productDetail.productDetailModel!.product!.sizeArray![index]? AppColors.buttonColor:AppColors.homeScreenColor,
                                      label: Text(productDetail.productDetailModel!.product!.sizeArray![index].toString(),
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          child: Text("Shoe Size in :",
                              style: AppUtils.instance.textStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),

                        Text(productDetail.productDetailModel!.product!.shoeSizeText!,
                            style: AppUtils.instance.textStyle(
                                fontSize: 18,
                                color: AppColors.black
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 10),
                          child: Text("Color :",
                              style: AppUtils.instance.textStyle(
                                  fontSize: 20,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        ),

                        Text(productDetail.productDetailModel!.product!.shoeColor!,
                            style: AppUtils.instance.textStyle(
                                fontSize: 18,
                                color: AppColors.black
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  productDetail.items <= 1 ?
                                  null
                                      :
                                  productDetail.removeItem();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: productDetail.items <= 1 ?
                                  AppColors.homeScreenColor :AppColors.buttonColor,

                                  ),
                                    height: 40,
                                    width: 40,
                                  child: Center(
                                    child: Text("-",
                                      style: AppUtils.instance.textStyle(
                                          fontSize: 26,
                                          color: AppColors.black,
                                        fontWeight: FontWeight.bold

                                      )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: AppColors.white,
                                height: 40,
                                width: 50,
                                child: Center(
                                  child: Text(productDetail.items.toString(),
                                      style: AppUtils.instance.textStyle(
                                          fontSize: 26,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold

                                      )
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  productDetail.items >= 5 ?
                                      null
                                      :
                                      productDetail.addItems();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: productDetail.items >= 5 ?
                                    AppColors.homeScreenColor :AppColors.buttonColor,

                                  ),
                                  height: 40,
                                  width: 40,
                                  child: Center(
                                    child: Text("+",
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 26,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold

                                        )
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),

                          Spacer(),
                          InkWell(
                            onTap: (){

                              AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefProductName,productDetail.productDetailModel!.product!.productName);
                              AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefProductImage,productDetail.productDetailModel!.product!.imagesArray![0]);
                              AppUtils.instance.addPref(PreferenceKey.intKey, PreferenceKey.prefQty,productDetail.items);
                              AppUtils.instance.addPref(PreferenceKey.doubleKey, PreferenceKey.prefPrice,productDetail.productDetailModel!.product!.price);

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation(firstName: widget.firstName,
                                      lastName: widget.lastName,initialIndex: 3,
                                      productName: productDetail.productDetailModel!.product!.productName,
                                      price: productDetail.productDetailModel!.product!.price,
                                      qty: productDetail.items,
                                      image: productDetail.productDetailModel!.product!.imagesArray![0],)

                                  // CustomerHomeScreen(firstName: firstName,lastName: lastName)
                                ),
                              );

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.buttonColor,

                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width/2.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.shopping_bag_outlined,size: 28),
                                  const SizedBox(width: 20),
                                  Text("\$${productDetail.productDetailModel!.product!.price}",
                                      style: AppUtils.instance.textStyle(
                                          fontSize: 24,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold

                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    const SizedBox(height: 100)
                  ],
                )

              :
          const Center(
          child: Text(
          "No Details Found"
          )
          )
          )

          ]
        )

        ),

      ),
    );



  }
  bool isSizeSelected(String size) {
    return Provider.of<ProductDetailProvider>(context,listen: false).productDetailModel!.product!.sizeArray!.contains(size);
  }
}