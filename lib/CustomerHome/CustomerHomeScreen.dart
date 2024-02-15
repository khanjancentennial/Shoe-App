import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerHome/Model/brand_names_model.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_text.dart';
import 'package:group1_mapd726_shoe_app/utils/app_color.dart';
import 'package:group1_mapd726_shoe_app/utils/app_images.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../Login/LoginScreen.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';

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

                GridView.builder(
                  itemCount: brands.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                      childAspectRatio: 0.58,
                      crossAxisCount: MediaQuery.of(context).size.width >= 600? 4: 2,

                    ),
                    itemBuilder: (context,index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.textFieldColor,
                              borderRadius: BorderRadius.circular(20)
                            ),
                            height: 180,
                            child: Image.asset(brands[index].image),
                          ),
                          const SizedBox(height: 10),
                          Text(brands[index].brandName,
                            style: AppUtils.instance.textStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 5),
                          Text("\$ 200",
                          style: AppUtils.instance.textStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        ],
                      );
                    }
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
