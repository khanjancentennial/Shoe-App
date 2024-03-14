import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/AdminEditProduct/admin_edit_product_screen.dart';
import 'package:group1_mapd726_shoe_app/AdminProductDetail/Provider/admin_delete_product.dart';
import 'package:group1_mapd726_shoe_app/Widgets/admin_bottom_navigation.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/product_detail_provider.dart';

class AdminProductDetailScreen extends StatefulWidget {
  String? id;

  AdminProductDetailScreen({super.key, this.id});

  @override
  State<AdminProductDetailScreen> createState() => _AdminProductDetailScreenState();
}

class _AdminProductDetailScreenState extends State<AdminProductDetailScreen> {

  bool isSelected = false;
  String sizeToCheck = '';

  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";
      setState(() {});
      Provider.of<AdminProductDetailProvider>(context,listen: false).getProductsById(widget.id!);

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


                  Consumer<AdminProductDetailProvider>(
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
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(productDetail.productDetailModel!.product!.productName!,
                                      style: AppUtils.instance.textStyle(
                                          fontSize: 26,
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                              ),

                              Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                child: Text("\$${productDetail.productDetailModel!.product!.price}",
                                    style: AppUtils.instance.textStyle(
                                        fontSize: 24,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold

                                    )
                                ),
                              ),
                            ],
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
                            child: Text("All Available Sizes:",
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
                                              child:
                                              Chip(
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: AdminEditProductScreen(
                                          productName : productDetail.productDetailModel!.product!.productName,
                                          price: productDetail.productDetailModel!.product!.price.toString(),
                                          productId: productDetail.productDetailModel!.product!.sId,
                                          color : productDetail.productDetailModel!.product!.shoeColor,
                                          shoeSizeIn : productDetail.productDetailModel!.product!.shoeSizeText,
                                          sizeList: productDetail.productDetailModel!.product!.sizeArray!,
                                          productDetails : productDetail.productDetailModel!.product!.details,
                                          productType : productDetail.productDetailModel!.product!.shoeType,
                                          brandName : productDetail.productDetailModel!.product!.brandName

                                      ),
                                      withNavBar: false, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.buttonColor,

                                    ),
                                    height: 50,
                                      width: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: [
                                        const Icon(Icons.edit,size: 25),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("Edit",
                                            style: AppUtils.instance.textStyle(
                                                fontSize: 20,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold

                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                InkWell(
                                  onTap: (){
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Center(child: Text('Are you sure you want to delete Product?')),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment : MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                                child: Text('Cancel',
                                                    style: AppUtils.instance.textStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: AppColors.green
                                                    )
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Provider.of<AdminDeleteProductProvider>(context,listen: false).deleteProduct(context, widget.id!)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(builder: (builder) =>
                                                            AdminBottomNavigation(firstName: firstName,lastName: lastName,index: 2)
                                                        )
                                                    );
                                                  });

                                                },
                                                child:  Text('Yes',
                                                    style: AppUtils.instance.textStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18,
                                                        color: AppColors.red
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.buttonColor,

                                    ),
                                    height: 50,
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.delete,size: 25),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text("Delete",
                                            style: AppUtils.instance.textStyle(
                                                fontSize: 20,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold

                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                                )

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
