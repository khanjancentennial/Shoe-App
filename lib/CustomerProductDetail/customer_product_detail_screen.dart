import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import 'Provider/product_detail_provider.dart';

class CustomerProductDetailScreen extends StatefulWidget {

  String? id;

  CustomerProductDetailScreen({super.key, this.id});

  @override
  State<CustomerProductDetailScreen> createState() => _CustomerProductDetailScreenState();
}

class _CustomerProductDetailScreenState extends State<CustomerProductDetailScreen> {

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
                        child: ListView.builder(
                          itemCount: productDetail.productDetailModel!.product!.sizeArray!.length,
                          physics: ScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index) =>
                            Wrap(
                              children:[
                                Chip(
                                  backgroundColor: AppColors.homeScreenColor,
                                  label: Text(productDetail.productDetailModel!.product!.sizeArray![index].toString(),
                                      style: AppUtils.instance.textStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),

                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

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
                          Container(
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
}