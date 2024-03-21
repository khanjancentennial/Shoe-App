import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:provider/provider.dart';

import '../CustomerOrderHistory/Provider/checkout_provider.dart';
import '../Widgets/bottom_navigation.dart';
import '../Widgets/button_with_text.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/all_cart_items_provider.dart';
import 'Provider/delete_cart_items_provider.dart';

class CustomerCartScreen extends StatefulWidget {
  String? userId;
  CustomerCartScreen({super.key,this.userId});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  double totalPriceInLoop = 0.0;
  double totalPrice = 0.0;

  // String? productName;
  // String? productImage;
  // int? qty;
  // double? price;

  String? customerId = '';
  String? firstName = '';
  String? lastName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      print(widget.userId!);
      customerId = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserId)??"";
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";
      setState(() {});
      Provider.of<AllCartItemsProvider>(context,listen: false).getProductsByCustomerId(widget.userId != null || widget.userId!.isNotEmpty  ? widget.userId!:customerId!);

      // for(int i =0;i< Provider.of<AllCartItemsProvider>(context,listen: false).allCartItemsModel!.cartItems!.length;i++){
      //   totalPriceInLoop = Provider.of<AllCartItemsProvider>(context,listen: false).allCartItemsModel!.cartItems![i].totalPrice!;
      //   totalPrice = totalPrice + totalPriceInLoop;
      // }

      // totalPrice = price! == 0.0 && qty! == 0 ?widget.qty! * widget.price! : qty! * price!;


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,bottom: 50),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width-40,
                child: Center(
                  child: Text("Cart Items",
                      style: AppUtils.instance.textStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),

              Consumer<AllCartItemsProvider>(
              builder: (_, allCartItems, child) =>


              allCartItems.isLoading ?

              Container(child: Center(
                child: CircularProgressIndicator(),
              ),)
                  :
              allCartItems.allCartItemsModel == null || allCartItems.allCartItemsModel!.cartItems!.isEmpty ?

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/1.2,
                      child: Center(
                        child: Text("No items in Cart"),
                      ),
                    ),
                  ],
                )

                    :
                Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: allCartItems.allCartItemsModel!.cartItems!.length,
                      itemBuilder: (context,index)=>
                          Padding(
                            padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.dropDownColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                              // color: AppColors.textFieldColor,
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    allCartItems.allCartItemsModel!.cartItems![index].product!.imagesArray![0],
                                                  ),
                                                  fit: BoxFit.fill
                                              )
                                          ),

                                        ),
                                        const SizedBox(width: 20),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(allCartItems.allCartItemsModel!.cartItems![index].product!.productName!,
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 20,
                                                    color: AppColors.buttonColor,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("price: \$ ${allCartItems.allCartItemsModel!.cartItems![index].product!.price}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Qty: ${allCartItems.allCartItemsModel!.cartItems![index].quantity}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Total price: \n\$ ${allCartItems.allCartItemsModel!.cartItems![index].totalPrice}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 20,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width/7),
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
                                                          Provider.of<DeleteCaretItemsProvider>(context,listen: false).deleteCartItem(context, allCartItems.allCartItemsModel!.cartItems![index].sId!)
                                                              .then((value) {
                                                            allCartItems.deleteTotalPrice();
                                                            Navigator.pop(context);
                                                            Navigator.pushReplacement(context,
                                                                MaterialPageRoute(builder: (builder) =>
                                                                    BottomNavigation(userId: widget.userId != null || widget.userId!.isNotEmpty  ? widget.userId!:customerId!,
                                                                        firstName: firstName,lastName: lastName,initialIndex: 3)
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
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: AppColors.buttonColor,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Icon(Icons.delete),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),

                            ),
                          )
                  ),
                ),
              ),

              const SizedBox(height: 50),

            Consumer<AllCartItemsProvider>(
              builder: (_, allCartItems, child) =>
              allCartItems.totalPrice == 0.0
                  ?
             SizedBox()
              :

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Positioned(
                  bottom: 20,
                  child: buttonWithText(
                      onPress: () {
                        Provider.of<CheckOutProvider>(context,listen: false).
                        checkOut(context,
                            widget.userId != null || widget.userId!.isNotEmpty  ? widget.userId!:customerId!,
                            firstName!,
                            lastName!);
                      },
                      bgColor: AppColors.buttonColor,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      text: "Checkout  \$${allCartItems.totalPrice.toStringAsFixed(2)}",
                      textColor: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
      )
            ],
          ),
        ),
      ),
    );
  }
}
