import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app_color.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/get_all_users_provider.dart';

class AdminUserManageScreen extends StatefulWidget {
  String? userId;
  AdminUserManageScreen({super.key,this.userId});

  @override
  State<AdminUserManageScreen> createState() => _AdminUserManageScreenState();
}

class _AdminUserManageScreenState extends State<AdminUserManageScreen> {

  String? customerId = '';
  String? firstName = '';
  String? lastName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      customerId = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserId)??"";
      firstName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefFirstName)??"";
      lastName = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefLastName)??"";
      setState(() {});
      Provider.of<GetAllUsersProvider>(context,listen: false).getAllUsers();

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
                  child: Text("All Customers",
                      style: AppUtils.instance.textStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),

              Consumer<GetAllUsersProvider>(
                builder: (_, getAllUsers, child) =>


                getAllUsers.isLoading ?

                Container(child: Center(
                  child: CircularProgressIndicator(),
                ),)
                    :
                getAllUsers.getAllCustomersModel == null || getAllUsers.getAllCustomersModel!.users!.isEmpty ?

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height/1.2,
                      child: const Center(
                        child: Text("No Users Found"),
                      ),
                    ),
                  ],
                )

                    :
                Container(
                  // height: MediaQuery.of(context).size.height/1.5,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: getAllUsers.getAllCustomersModel!.users!.length,
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

                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${getAllUsers.getAllCustomersModel!.users![index].firstName!} ${getAllUsers.getAllCustomersModel!.users![index].lastName!}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 20,
                                                    color: AppColors.buttonColor,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Email:  ${getAllUsers.getAllCustomersModel!.users![index].email!}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Phone Number: ${getAllUsers.getAllCustomersModel!.users![index].phoneNumber!}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Address:  ${getAllUsers.getAllCustomersModel!.users![index].address!}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text("Gender:  ${getAllUsers.getAllCustomersModel!.users![index].gender!}",
                                                style: AppUtils.instance.textStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: MediaQuery.of(context).size.width/7),
                                        // Column(
                                        //   children: [
                                        //     InkWell(
                                        //       onTap: (){
                                        //         PersistentNavBarNavigator.pushNewScreen(
                                        //           context,
                                        //           screen: CustomerProfileScreen(userId: getAllUsers.getAllCustomersModel!.users![index].sId!,),
                                        //           withNavBar: false, // OPTIONAL VALUE. True by default.
                                        //           pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                        //         );
                                        //       },
                                        //       child: Container(
                                        //         height: 40,
                                        //         width: 40,
                                        //         decoration: BoxDecoration(
                                        //             color: AppColors.buttonColor,
                                        //             borderRadius: BorderRadius.circular(10)
                                        //         ),
                                        //         child: Icon(Icons.edit),
                                        //       ),
                                        //     ),
                                        //
                                        //     SizedBox(height: 20),
                                        //     InkWell(
                                        //       onTap: (){
                                        //         showDialog<String>(
                                        //           context: context,
                                        //           builder: (BuildContext context) => AlertDialog(
                                        //             title: const Center(child: Text('Are you sure you want to delete user?')),
                                        //             actions: <Widget>[
                                        //               Row(
                                        //                 mainAxisAlignment : MainAxisAlignment.center,
                                        //                 children: [
                                        //                   TextButton(
                                        //                     onPressed: () => Navigator.pop(context, 'Cancel'),
                                        //                     child: Text('Cancel',
                                        //                         style: AppUtils.instance.textStyle(
                                        //                             fontWeight: FontWeight.bold,
                                        //                             fontSize: 18,
                                        //                             color: AppColors.green
                                        //                         )
                                        //                     ),
                                        //                   ),
                                        //                   TextButton(
                                        //                     onPressed: () {
                                        //                       Provider.of<DeleteUserProvider>(context,listen: false).deleteCartItem(context, getAllUsers.getAllCustomersModel!.users![index].sId!)
                                        //                           .then((value) {
                                        //                         Navigator.pop(context);
                                        //                         Navigator.pushReplacement(context,
                                        //                             MaterialPageRoute(builder: (builder) =>
                                        //                                 AdminBottomNavigation(index: 3,firstName: firstName,lastName: lastName)
                                        //                             )
                                        //                         );
                                        //                       });
                                        //                     },
                                        //                     child:  Text('Yes',
                                        //                         style: AppUtils.instance.textStyle(
                                        //                             fontWeight: FontWeight.bold,
                                        //                             fontSize: 18,
                                        //                             color: AppColors.red
                                        //                         )
                                        //                     ),
                                        //                   ),
                                        //                 ],
                                        //               ),
                                        //
                                        //             ],
                                        //           ),
                                        //         );
                                        //       },
                                        //       child: Container(
                                        //         height: 40,
                                        //         width: 40,
                                        //         decoration: BoxDecoration(
                                        //             color: AppColors.red,
                                        //             borderRadius: BorderRadius.circular(10)
                                        //         ),
                                        //         child: Icon(Icons.delete),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // )
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

            ],
          ),
        ),
      ),
    );
  }
}
