import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/CustomerProfile/Model/update_profile_model.dart';
import 'package:group1_mapd726_shoe_app/CustomerProfile/Provider/update_profile_provider.dart';
import 'package:provider/provider.dart';

import '../Login/LoginScreen.dart';
import '../Registration/Provider/registration_provider.dart';
import '../Widgets/button_with_progress_idicator.dart';
import '../Widgets/button_with_text.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import '../utils/preference_key.dart';
import 'Provider/user_profile_provider.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {

  // TextEditingController firstName = TextEditingController();
  // TextEditingController lastName = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String emailValue = "";

  bool isFirstTime = false;

  String userId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getDetails());
  }

  Future<void>? getDetails() async {
    if (this.mounted) {
      userId = await AppUtils.instance.getPreferenceValueViaKey(PreferenceKey.prefUserId);
      setState(() {});
      Provider.of<UserProfileProvider>(context, listen: false).getUserDetails(userId);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:
        Consumer<UserProfileProvider>(
            builder: (_, getUserDetails, child) =>
              getUserDetails.isLoading  == false ?
              Form(
                    key: _formKey,
                    child:
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, left: 20),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),

                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Center(
                                child: Text("Profile",
                                    style: AppUtils.instance.textStyle(
                                        fontSize: 30,
                                        color: AppColors.black

                                    )
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                const SizedBox(height: 20),

                                const Text("First Name"),
                                const SizedBox(height: 5),
                                // first name
                                Consumer<UserProfileProvider>(
                                    builder: (_, getUserDetails, child) =>
                                        TextFormField(
                                          onTap: () {},
                                          controller: getUserDetails.firstNameController,
                                          // focusNode: firstNameFocusNode,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: AppColors.textFieldColor,

                                            prefixIcon: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 11),
                                              child: Image.asset(AppImage.user,
                                                scale: 20,
                                                // color: AppColors.grey,
                                              ),
                                            ),

                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter first name";
                                            } else {
                                              return null;
                                            }
                                          },

                                        ),
                                ),
                                const SizedBox(height: 20),

                                const Text("Last Name"),
                                const SizedBox(height: 5),

                                // last name
                                Consumer<UserProfileProvider>(
                                    builder: (_, getUserDetails, child) =>
                                        TextFormField(
                                          onTap: () {},
                                          controller: getUserDetails.lastNameController,
                                          focusNode: lastNameFocusNode,
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: AppColors.textFieldColor,
                                            prefixIcon: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 5, right: 11),
                                              child: Image.asset(AppImage.user,
                                                scale: 20,
                                                // color: AppColors.grey,
                                              ),
                                            ),

                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "please enter last name";
                                            } else {
                                              return null;
                                            }
                                          },

                                        ),
                                ),
                                const SizedBox(height: 20),

                                const Text("Email Id"),
                                const SizedBox(height: 5),
                                //email
                                Consumer<UserProfileProvider>(
                                  builder: (_, getUserDetails, child) =>
                                TextFormField(
                                  enabled: false,
                                  onTap: () {},
                                  controller: getUserDetails.emailController,
                                  focusNode: emailFocusNode,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.textFieldColor,
                                    prefixIcon: Container(
                                      child: Image.asset(AppImage.emailImage,
                                        scale: 3,
                                        // color: AppColors.grey,
                                      ),
                                    ),

                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter email";
                                    } else {
                                      if (Provider.of<RegistrationProvider>(
                                          context, listen: false)
                                          .emailStructure(value)) {
                                        return null;
                                      } else {
                                        return "Please enter a valid email address";
                                      }
                                    }
                                  },
                                  onChanged: (emailValue) {
                                    Provider.of<RegistrationProvider>(
                                        context, listen: false).emailStructure(
                                        emailValue);
                                    // print(emailValue);
                                  },
                                ),
                                ),

                                const SizedBox(height: 20),

                                const Text("Phone Number"),
                                const SizedBox(height: 5),
                                // phone number
                                Consumer<UserProfileProvider>(
                                  builder: (_, getUserDetails, child) =>
                                TextFormField(
                                  maxLength: 10,
                                  keyboardType: const TextInputType
                                      .numberWithOptions(signed: true),
                                  onTap: () {},
                                  controller: getUserDetails.phoneController,
                                  focusNode: phoneFocusNode,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.textFieldColor,

                                    prefixIcon: Container(
                                      padding: const EdgeInsets.only(
                                          left: 11, right: 11),
                                      child: Image.asset(AppImage.phoneImage,
                                        scale: 17,
                                        // color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter phone number";
                                    }
                                    else {
                                      if (value.length == 10) {
                                        return null;
                                      } else {
                                        return "Phone number should be 10 digits";
                                      }
                                    }
                                  },
                                ),
                                ),

                                const SizedBox(height: 20),

                                const Text("Address"),
                                const SizedBox(height: 5),

                                // address
                                Consumer<UserProfileProvider>(
                                  builder: (_, getUserDetails, child) =>
                                TextFormField(
                                  // textAlign : TextAlign.center,
                                  maxLines: 2,
                                  onTap: () {},
                                  controller: getUserDetails.address,
                                  focusNode: addressFocusNode,
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.textFieldColor,
                                    hintText: "Enter Address",

                                    hintStyle: AppUtils.instance.textStyle(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Container(
                                      padding: const EdgeInsets.only(
                                          left: 11, right: 11),
                                      child: Image.asset(AppImage.locationImage,
                                        scale: 13,
                                        // color: AppColors.grey,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter address";
                                    }
                                    else {
                                      return null;
                                    }
                                  },
                                ),
                                ),

                                const SizedBox(height: 20),
                                const Text("Gender:"),
                                const SizedBox(height: 10),

                        Consumer<UserProfileProvider>(
                            builder: (_, getUserDetails, child) =>
                                Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              getUserDetails.genderCheck("Male");
                                            },
                                            child: Row(
                                              children: [
                                                getUserDetails.isMale
                                                    ? const CircleAvatar(
                                                  backgroundColor:
                                                  AppColors.buttonColor,
                                                  radius: 11,
                                                )
                                                    : const CircleAvatar(
                                                  backgroundColor: AppColors
                                                      .black,
                                                  radius: 11,
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                    AppColors.homeScreenColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  "Male",
                                                  style: AppUtils.instance
                                                      .textStyle(
                                                      fontSize: 16,
                                                      color: AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          InkWell(
                                            onTap: () {
                                              getUserDetails.genderCheck("Female");
                                            },
                                            child: Row(
                                              children: [
                                                getUserDetails.isFemale
                                                    ? const CircleAvatar(
                                                  backgroundColor:
                                                  AppColors.buttonColor,
                                                  radius: 11,
                                                )
                                                    : const CircleAvatar(
                                                  backgroundColor: AppColors
                                                      .black,
                                                  radius: 11,
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                    AppColors.homeScreenColor,
                                                  ),
                                                ),

                                                const SizedBox(width: 10),
                                                Text(
                                                  "Female",
                                                  style: AppUtils.instance
                                                      .textStyle(
                                                      fontSize: 16,
                                                      color: AppColors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                        ),

                                isFirstTime ?
                                Consumer<UpdateProfileProvider>(
                                    builder: (_, gender, child) =>
                                    gender.isMale == false ||
                                        gender.isFemale == false ?

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 13),
                                      child: Text("Please select gender",
                                        style: AppUtils.instance.textStyle(
                                            color: AppColors.darkRed
                                        ),
                                      ),
                                    )
                                        :
                                    const SizedBox()
                                )
                                    :
                                const SizedBox(),

                                const SizedBox(height: 30),

                                Consumer<RegistrationProvider>(
                                    builder: (_, isLoading, child) =>
                                    isLoading.isLoading

                                        ?
                                    buttonWithProgressIndicator(
                                      widget: const Padding(
                                        padding: EdgeInsets.only(left: 150,
                                            right: 150,
                                            top: 10,
                                            bottom: 10),
                                        child: SizedBox(
                                            height: 10,
                                            width: 10,
                                            child: CircularProgressIndicator()),
                                      ),
                                      bgColor: AppColors.buttonColor,
                                      height: 60,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                    )
                                        :

                                    buttonWithText(
                                        onPress: () {
                                          validations();
                                        },
                                        bgColor: AppColors.buttonColor,
                                        height: 60,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        text: "Update",
                                        textColor: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)
                                ),

                                const SizedBox(height: 50),


                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ) :
                const Center(child: CircularProgressIndicator()
                )
        )
        );
  }
  void validations() async {

    if(Provider.of<UpdateProfileProvider>(context,listen: false).isMale
        || Provider.of<UpdateProfileProvider>(context,listen: false).isFemale
        || Provider.of<UserProfileProvider>(context,listen: false).isFemale
        || Provider.of<UserProfileProvider>(context,listen: false).isMale
    ){
      isFirstTime = false;
      setState(() {

      });
    }else{
      isFirstTime = true;
      setState(() {

      });
    }


    if(_formKey.currentState!.validate()){

      Provider.of<UpdateProfileProvider>(context, listen: false).addUserDetails(
          context,
          Provider.of<UserProfileProvider>(context,listen: false).getUserModel.user!.sId.toString(),
          Provider.of<UserProfileProvider>(context,listen: false).firstNameController.text,
          Provider.of<UserProfileProvider>(context,listen: false).lastNameController.text,
          Provider.of<UserProfileProvider>(context,listen: false).emailController.text,
          Provider.of<UserProfileProvider>(context,listen: false).address.text,
          Provider.of<UserProfileProvider>(context,listen: false).phoneController.text,

        Provider.of<UserProfileProvider>(context,listen: false).getUserModel.user!.gender!.isNotEmpty?
        Provider.of<UserProfileProvider>(context,listen: false).isMale == true ? "Male": "Female" :
        Provider.of<UpdateProfileProvider>(context,listen: false).isMale ? "Male" : "Female",
        Provider.of<UserProfileProvider>(context,listen: false).getUserModel.user!.userType.toString()


      );
      //     .then((value) {
      //
      //   if (value!.success == true){
      //
      //     AppUtils.instance.showToast(
      //         textColor: Colors.white,
      //         backgroundColor: Colors.green,
      //         toastMessage: "${value.message}");
      //     Navigator.pop(context);
      //
      //   } else {
      //     AppUtils.instance.showToast(
      //         textColor: Colors.white,
      //         backgroundColor: AppColors.red,
      //         toastMessage: "${value.message}");
      //   }
      // });


    // }
  }
  }
}
