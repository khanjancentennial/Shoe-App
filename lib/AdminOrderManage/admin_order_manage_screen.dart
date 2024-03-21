import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/AdminOrderManage/Provider/admin_change_order_status_provider.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_text.dart';
import 'package:provider/provider.dart';

import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/admin_all_orders_manage_provider.dart';

class AdminOrderManageScreen extends StatefulWidget {
  const AdminOrderManageScreen({super.key});

  @override
  State<AdminOrderManageScreen> createState() => _AdminOrderManageScreenState();
}

class _AdminOrderManageScreenState extends State<AdminOrderManageScreen> {
  // String dropdownValue = "";
  // String dropdownValue1 = "";
  // String dropdownValue2 = "";

  List<String> dropdownValues = [];
  List<String> dropdownValues1 = [];
  List<String> dropdownValues2 = [];
  String firstName = '';
  String lastName = '';

  List<String> statusList = <String>['Order In Process', 'Packaging', 'Delivered'];
  List<String> statusList1 = <String>['Packaging', 'Delivered'];
  List<String> statusList2 = <String>['Delivered'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      // print(widget.userId!);
      // customerId = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserId)??"";
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";
      setState(() {});
      Provider.of<AdminAllOrdersManageProvider>(context,listen: false).allOrders(context).then((value) {
        for(int i =0; i<Provider.of<AdminAllOrdersManageProvider>(context,listen: false).pendingOrders.length; i++){
          if(Provider.of<AdminAllOrdersManageProvider>(context,listen: false).pendingOrders[i].status == "Not Delivered"){
            dropdownValues = List.generate(
              Provider.of<AdminAllOrdersManageProvider>(context, listen: false).pendingOrders.length,
                  (index) => statusList.first,
            );
          }else if(Provider.of<AdminAllOrdersManageProvider>(context,listen: false).pendingOrders[i].status == "Order In Process"){
            dropdownValues1 = List.generate(
              Provider.of<AdminAllOrdersManageProvider>(context, listen: false).pendingOrders.length,
                  (index) => statusList1.first,
            );
          }else if(Provider.of<AdminAllOrdersManageProvider>(context,listen: false).pendingOrders[i].status == "Packaging"){
            dropdownValues2 = List.generate(
              Provider.of<AdminAllOrdersManageProvider>(context, listen: false).pendingOrders.length,
                  (index) => statusList2.first,
            );
          }
        }
      });




      // dropdownValue = statusList.first;
      // dropdownValue1 = statusList1.first;
      // dropdownValue2 = statusList2.first;


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
                  Tab(text: "Pending Orders"),
                  Tab(text: "Delivered Orders"),

                ],
              ),
              title: Text('All Orders',
                style: AppUtils.instance.textStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              centerTitle: true,
            ),
            body: TabBarView(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,bottom: 50),
                  child: Column(
                    children: [
                      // Container(
                      //   width: MediaQuery.of(context).size.width-40,
                      //   child: Center(
                      //     child: Text("All Orders",
                      //         style: AppUtils.instance.textStyle(
                      //             fontSize: 26,
                      //             fontWeight: FontWeight.bold
                      //         )
                      //     ),
                      //   ),
                      // ),

                      Consumer<AdminAllOrdersManageProvider>(
                        builder: (_, allOrders, child) =>

                        allOrders.isLoading ?

                        Container(child: Center(
                          child: CircularProgressIndicator(),
                        ),)
                            :
                        allOrders.adminOrdersManageModel == null || allOrders.adminOrdersManageModel!.orders!.isEmpty || allOrders.pendingOrders.isEmpty?

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/1.2,
                              child: const Center(
                                child: Text("No Orders"),
                              ),
                            ),
                          ],
                        )

                            :
                        Container(
                          // height: MediaQuery.of(context).size.height,
                          // padding: EdgeInsets.only(bottom: 200),
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
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Qty: ${allOrders.pendingOrders[index].quantity}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Total price: \$ ${allOrders.pendingOrders[index].totalPrice}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Order Status: ${allOrders.pendingOrders[index].status}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),

                                            const SizedBox(height: 20),
                                            Text("Customer Name: ${allOrders.pendingOrders[index].user!.firstName} ${allOrders.pendingOrders[index].user!.lastName}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Address: ${allOrders.pendingOrders[index].user!.address}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Email: ${allOrders.pendingOrders[index].user!.email}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Phone Number: ${allOrders.pendingOrders[index].user!.phoneNumber}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),


                                            allOrders.pendingOrders[index].status == "Not Delivered" ?

                                            Padding(
                                              padding: const EdgeInsets.only(left: 20,right: 20),
                                              child: Column(
                                                children: [

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      DropdownButton<String>(
                                                        value: dropdownValues[index],
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
                                                            dropdownValues[index] = value!;
                                                          });
                                                        },
                                                        items:

                                                        statusList.map<DropdownMenuItem<String>>((String value) {
                                                          return DropdownMenuItem<String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList()
                                                        ,
                                                      ),
                                                      Spacer(),
                                                      InkWell(
                                                        onTap: (){
                                                          Provider.of<AdminChangeOrderStatusProvider>(context,listen: false)
                                                              .changeOrderStatus(context,
                                                              allOrders.pendingOrders[index].sId!,
                                                              dropdownValues[index],
                                                              firstName,
                                                              lastName
                                                          );
                                                        },

                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                              color: AppColors.buttonColor,
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: const Icon(Icons.published_with_changes_rounded,color: AppColors.black,),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )

                                                :

                                            allOrders.pendingOrders[index].status == "Order In Process" ?

                                            Padding(
                                              padding: const EdgeInsets.only(left: 20,right: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  DropdownButton<String>(
                                                    value: dropdownValues1[index],
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
                                                        dropdownValues1[index] = value!;
                                                      });
                                                    },
                                                    items:

                                                    statusList1.map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                    ,
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: (){
                                                      Provider.of<AdminChangeOrderStatusProvider>(context,listen: false)
                                                          .changeOrderStatus(context,
                                                          allOrders.pendingOrders[index].sId!,
                                                          dropdownValues1[index],
                                                          firstName,
                                                          lastName
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.buttonColor,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: const Icon(Icons.published_with_changes_rounded,color: AppColors.black,),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )

                                                :
                                            allOrders.pendingOrders[index].status == "Packaging" ?

                                            Padding(
                                              padding: const EdgeInsets.only(left: 20,right: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  DropdownButton<String>(
                                                    value: dropdownValues2[index],
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
                                                        dropdownValues2[index] = value!;
                                                      });
                                                    },
                                                    items:

                                                    statusList2.map<DropdownMenuItem<String>>((String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList()
                                                    ,
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: (){
                                                      Provider.of<AdminChangeOrderStatusProvider>(context,listen: false)
                                                          .changeOrderStatus(context,
                                                          allOrders.pendingOrders[index].sId!,
                                                          dropdownValues2[index],
                                                          firstName,
                                                          lastName
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.buttonColor,
                                                          borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      child: const Icon(Icons.published_with_changes_rounded,color: AppColors.black,),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )

                                                :
                                            const SizedBox()

                                            ,
                                          ],
                                        ),
                                      ),

                                    ),
                                  )
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),


                    ],
                  ),
                ),
              ),


              // delivered orders

              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,bottom: 50),
                  child: Column(
                    children: [
                      // Container(
                      //   width: MediaQuery.of(context).size.width-40,
                      //   child: Center(
                      //     child: Text("All Orders",
                      //         style: AppUtils.instance.textStyle(
                      //             fontSize: 26,
                      //             fontWeight: FontWeight.bold
                      //         )
                      //     ),
                      //   ),
                      // ),

                      Consumer<AdminAllOrdersManageProvider>(
                        builder: (_, allOrders, child) =>

                        allOrders.isLoading ?

                        Container(child: Center(
                          child: CircularProgressIndicator(),
                        ),)
                            :
                        allOrders.adminOrdersManageModel == null || allOrders.adminOrdersManageModel!.orders!.isEmpty || allOrders.deliveredOrders.isEmpty ?

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height/1.2,
                              child: const Center(
                                child: Text("No Orders"),
                              ),
                            ),
                          ],
                        )

                            :
                        Container(
                          // height: MediaQuery.of(context).size.height,
                          // padding: EdgeInsets.only(bottom: 200),
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
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Qty: ${allOrders.deliveredOrders[index].quantity}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Total price: \$ ${allOrders.deliveredOrders[index].totalPrice}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      Text("Order Status: ${allOrders.deliveredOrders[index].status}",
                                                        style: AppUtils.instance.textStyle(
                                                            fontSize: 14,
                                                            color: AppColors.black,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),

                                            const SizedBox(height: 20),
                                            Text("Customer Name: ${allOrders.deliveredOrders[index].user!.firstName} ${allOrders.deliveredOrders[index].user!.lastName}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Address: ${allOrders.deliveredOrders[index].user!.address}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Email: ${allOrders.deliveredOrders[index].user!.email}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                            Text("Customer Phone Number: ${allOrders.deliveredOrders[index].user!.phoneNumber}",
                                              style: AppUtils.instance.textStyle(
                                                  fontSize: 16,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 10),

                                          ],
                                        ),
                                      ),

                                    ),
                                  )
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),


                    ],
                  ),
                ),
              )

            ],)
        )
      );

  }
}
