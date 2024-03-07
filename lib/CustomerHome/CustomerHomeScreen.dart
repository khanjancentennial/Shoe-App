import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/Model/brand_names_model.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_text.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:group1_mapd726_shoe_app/utils/app_images.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../CustomerProductDetail/customer_product_detail_screen.dart';
import '../Login/LoginScreen.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/customer_home_provider.dart';

class CustomerHomeScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  CustomerHomeScreen({super.key, this.firstName,this.lastName});


  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
List<BrandNames> brands = [
  BrandNames("Nike", true,AppImage.shoe1),
  BrandNames("Adidas", false,AppImage.shoe1),
  BrandNames("Puma", false,AppImage.shoe1)

];


@override
void initState() {
  // TODO: implement initState
  super.initState();
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
}

Future<void>? getDetails() async {
  if (this.mounted) {
    setState(() {});
    Provider.of<ProductsProvider>(context,listen: false).getProductsByCategory("Nike");

  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 50
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Hello, ",
                      style: AppUtils.instance.textStyle(
                        fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("${widget.lastName}",
                      style: AppUtils.instance.textStyle(
                          fontSize: 25,
                        color: AppColors.buttonColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap:(){
                        AppUtils.instance.addPref(PreferenceKey.boolKey, PreferenceKey.prefLogin,false);
                        AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefFirstName,"");
                        AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefLastName,"");
                        AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserType,"");
                        AppUtils.instance.addPref(PreferenceKey.stringKey, PreferenceKey.prefUserId,"");

                        setState(() {});

                        // Navigator.pop(context);

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: LoginScreen(),
                          withNavBar: false, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );

                      } ,
                        child: const Icon(
                            Icons.logout,
                            size: 35,
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text("Enjoy New Products",
                  style: AppUtils.instance.textStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  child: ListView.separated(
                    shrinkWrap: true,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                    scrollDirection: Axis.horizontal,

                    itemCount: brands.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            setState(() {
                              for(int i= 0; i < brands.length; i++){
                                brands[i].isSelected = false;
                              }
                              brands[index].isSelected = true;
                              Provider.of<ProductsProvider>(context,listen: false).getProductsByCategory(brands[index].brandName);
                            });

                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: brands[index].isSelected ? AppColors.buttonColor : AppColors.textFieldColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: Center(
                                child: Text(brands[index].brandName,
                                  style: AppUtils.instance.textStyle(
                                    fontSize: 20,
                                    fontWeight: brands[index].isSelected? FontWeight.bold : FontWeight.w400
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 10),

          Consumer<ProductsProvider>(
              builder: (_, allProducts, child) =>
                allProducts.isLoading ?

                    Container(child: Center(
                      child: CircularProgressIndicator(),
                    ),)
                    :

                    allProducts.productsModel!.products!.isEmpty ||  allProducts.productsModel!.products == []?

                    const Center(child: Text("No Products Available"))
                        :
                    GridView.builder(
                        itemCount: allProducts.productsModel!.products!.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          // crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                          childAspectRatio: 0.56,
                          crossAxisCount: MediaQuery.of(context).size.width >= 600? 4: 2,

                        ),
                        itemBuilder: (context,index){
                          return InkWell(
                            onTap: (){

                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: CustomerProductDetailScreen(id: allProducts.productsModel!.products![index].sId,firstName: widget.firstName,lastName: widget.lastName,),
                                withNavBar: false, // OPTIONAL VALUE. True by default.
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );

                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      // color: AppColors.textFieldColor,
                                      borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          allProducts.productsModel!.products![index].imagesArray![0],
                                      ),
                                      fit: BoxFit.fill
                                    )
                                  ),
                                  height: 180,
                                ),
                                const SizedBox(height: 15),
                                Text(allProducts.productsModel!.products![index].productName!,
                                  style: AppUtils.instance.textStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 5),
                                Text("\$ ${allProducts.productsModel!.products![index].price!}",
                                  style: AppUtils.instance.textStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    )
          ),
                const Padding(padding: EdgeInsets.only(bottom: 50)
                )


              ],
            ),
          ),
        ),
      ),

    );
  }
}
