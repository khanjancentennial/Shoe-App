import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerOrderHistory/Provider/customer_delete_order_by_id_provider.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:group1_mapd726_shoe_app/utils/app_utils.dart';
import 'package:horizontal_stepper_flutter/horizontal_stepper_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/preference_key.dart';
import 'Provider/all_order_by_customer_id_provider.dart';

class CustomerOrderHistory extends StatefulWidget {
  const CustomerOrderHistory({super.key});

  @override
  State<CustomerOrderHistory> createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory> {

  String customerId = '';
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
      customerId = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserId)??"";
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";

      setState(() {});
      Provider.of<AllOrdersByCustomerIdProvider>(context,listen: false).allOrders(context,customerId);

      // for(int i =0;i< Provider.of<AllCartItemsProvider>(context,listen: false).allCartItemsModel!.cartItems!.length;i++){
      //   totalPriceInLoop = Provider.of<AllCartItemsProvider>(context,listen: false).allCartItemsModel!.cartItems![i].totalPrice!;
      //   totalPrice = totalPrice + totalPriceInLoop;
      // }

      // totalPrice = price! == 0.0 && qty! == 0 ?widget.qty! * widget.price! : qty! * price!;


    }
  }


  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.white,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Current Orders"),
                Tab(text: "Previous Orders"),

              ],
            ),
            title: Text('My Orders',
             style: AppUtils.instance.textStyle(
               fontSize: 30,
               fontWeight: FontWeight.bold
             ),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Consumer<AllOrdersByCustomerIdProvider>(
                  builder: (_, allOrders, child) =>


                  allOrders.isLoading ?

                  Container(child: Center(
                    child: CircularProgressIndicator(),
                  ),)
                      :
                  allOrders.pendingOrders == null || allOrders.pendingOrders.isEmpty ?

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.2,
                        child: Center(
                          child: Text("No Orders in process"),
                        ),
                      ),
                    ],
                  )

                      :
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    // padding: EdgeInsets.only(bottom: 200),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: allOrders.pendingOrders.length,
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
                                                        allOrders.pendingOrders[index].product!.imagesArray![0],
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
                                                  Text(allOrders.pendingOrders[index].product!.productName!,
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 20,
                                                        color: AppColors.buttonColor,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("price: \$ ${allOrders.pendingOrders[index].product!.price}",
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 16,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("Qty: ${allOrders.pendingOrders[index].quantity}",
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 16,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("Total price: \n \$ ${allOrders.pendingOrders[index].totalPrice}",
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
                                                    title: const Center(child: Text('Are you sure you want to cancel order?')),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment : MainAxisAlignment.center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                                            child: Text('No',
                                                                style: AppUtils.instance.textStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 18,
                                                                    color: AppColors.green
                                                                )
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Provider.of<CustomerDeleteOrderByIdProvider>(context,listen: false).delete(
                                                                  context,
                                                                  customerId,
                                                                  allOrders.allOrdersByCustomerIdModel!.orders![index].sId!,
                                                              firstName,
                                                              lastName);

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
                                                    color: AppColors.red,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Icon(Icons.cancel_rounded,color: AppColors.white,),
                                              ),
                                            )

                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: FlutterHorizontalStepper(
                                            currentStepColor: AppColors.buttonColor,
                                            inActiveStepColor: AppColors.grey,
                                            steps: const ["Order Placed", "Order in Process", "Packaging", "Delivered"],
                                            radius: 45,
                                            currentStep: allOrders.pendingOrders[index].status == "Not Delivered" ? 2 : allOrders.pendingOrders[index].status == "Order In Process"? 3 : 4,
                                            child: const [Text("1"), Text("2"), Text("3"), Text("4")],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              )
                      ),
                    ),
                  ),

                ),
              ),

              // tab 2
              SingleChildScrollView(
                child: Consumer<AllOrdersByCustomerIdProvider>(
                  builder: (_, allOrders, child) =>


                  allOrders.isLoading ?

                  Container(child: Center(
                    child: CircularProgressIndicator(),
                  ),)
                      :
                  allOrders.deliveredOrders == null || allOrders.deliveredOrders.isEmpty ?

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.2,
                        child: Center(
                          child: Text("No Orders in process"),
                        ),
                      ),
                    ],
                  )

                      :
                  Container(
                    // height: MediaQuery.of(context).size.height,
                    // padding: EdgeInsets.only(bottom: 100),
                    child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: allOrders.deliveredOrders.length,
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
                                                        allOrders.deliveredOrders[index].product!.imagesArray![0],
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
                                                  Text(allOrders.deliveredOrders[index].product!.productName!,
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 20,
                                                        color: AppColors.buttonColor,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("price: \$ ${allOrders.deliveredOrders[index].product!.price}",
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 16,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("Qty: ${allOrders.deliveredOrders[index].quantity}",
                                                    style: AppUtils.instance.textStyle(
                                                        fontSize: 16,
                                                        color: AppColors.black,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Text("Total price: \$ ${allOrders.deliveredOrders[index].totalPrice}",
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

                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Center(
                                          child: FlutterHorizontalStepper(
                                            currentStepColor: AppColors.buttonColor,
                                            inActiveStepColor: AppColors.grey,
                                            steps: const ["Order Placed", "Order in Process", "Packaging", "Delivered"],
                                            radius: 45,
                                            currentStep: allOrders.deliveredOrders[index].status == "Not Delivered" ? 1 : 5,
                                            child: const [Text("1"), Text("2"), Text("3"), Text("4")],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ),
                              )
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );



  }
}
