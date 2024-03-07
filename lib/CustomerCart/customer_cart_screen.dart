import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';

import '../Widgets/button_with_text.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';

class CustomerCartScreen extends StatefulWidget {
  String? productName;
  String? image;
  int? qty;
  double? price;
  CustomerCartScreen({super.key,this.productName,this.image,this.qty,this.price});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  double totalPrice = 0.0;

  String? productName;
  String? productImage;
  int? qty;
  double? price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      setState(() {});

      productName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefProductName) ?? "";
      productImage = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefProductImage) ?? "";
      qty = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefQty) ?? 0;
      price = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefPrice) ?? 0.0;
      totalPrice = price! == 0.0 && qty! == 0 ?widget.qty! * widget.price! : qty! * price!;


    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,right: 20,left: 20,bottom: 50),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width-40,
                    child: Center(
                      child: Text("Cart Items",
                          style: AppUtils.instance.textStyle(
                            fontSize: 26,
                          )
                      ),
                    ),
                  ),
                ],
              ),


              Container(
                height: MediaQuery.of(context).size.height/1.7,
                child: ListView.builder(
                  shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (context,index)=>
                    Container(
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
                                  width: 70,
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
                                            productImage!.isEmpty? widget.image! : productImage!,
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
                                      Text(productName!.isEmpty? widget.productName! : productImage!,
                                        style: AppUtils.instance.textStyle(
                                          fontSize: 20,
                                          color: AppColors.buttonColor,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("price: ${price! == 0.0? widget.price! : price!}",
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("Qty: ${qty!! == 0 ?widget.qty : qty!}",
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Text("Total price: ${totalPrice}",
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 20,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
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
                                                onPressed: () => Navigator.pop(context, 'OK'),
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

                    )
                ),
              ),
              const SizedBox(height: 50),
              const SizedBox(height: 50),
              Positioned(
                bottom: 20,
                child: buttonWithText(
                    onPress: () {
                    },
                    bgColor: AppColors.buttonColor,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    text: "Checkout  \$${totalPrice}",
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
