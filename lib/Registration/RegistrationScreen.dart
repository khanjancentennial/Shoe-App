import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Login/LoginScreen.dart';
import 'package:provider/provider.dart';

import '../Widgets/button_with_progress_idicator.dart';
import '../Widgets/button_with_text.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import 'Provider/registration_provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  String emailValue = "";

  bool isFirstTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
        key: _formKey,
        child:
        SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                        child: Image.asset(
                            AppImage.appLogo,
                            height: 100,
                          width: 200,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Text("Create New Account!",
                          style: AppUtils.instance.textStyle(
                              fontSize:30,
                              color: AppColors.black
                          )
                      ),

                      const SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox(height: 20),

                          // first name
                          TextFormField(
                            onTap: () {},
                            controller: firstName,
                            focusNode: firstNameFocusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              hintText: "Enter First Name",
                              hintStyle: AppUtils.instance.textStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(left: 5,right: 11),
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
                          const SizedBox(height: 20),

                          // last name
                          TextFormField(
                            onTap: () {},
                            controller: lastName,
                            focusNode: lastNameFocusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              hintText: "Enter Last Name",
                              hintStyle: AppUtils.instance.textStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(left: 5,right: 11),
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
                          const SizedBox(height: 20),

                          //email
                          TextFormField(
                            onTap: () {},
                            controller: emailController,
                            focusNode: emailFocusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              hintText: "Enter Email Id",
                              hintStyle: AppUtils.instance.textStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
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
                                if(Provider.of<RegistrationProvider>(context,listen: false).emailStructure(value)){
                                  return null;
                                }else{
                                  return "Please enter a valid email address";
                                }

                              }
                            },
                            onChanged: (emailValue){
                              Provider.of<RegistrationProvider>(context,listen: false).emailStructure(emailValue);
                              // print(emailValue);
                            },
                          ),


                          const SizedBox(height: 20),

                          // password
                          TextFormField(
                            obscureText: true,
                            onTap: () {},
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            decoration: InputDecoration(

                              border: const OutlineInputBorder(

                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              hintText: "Enter Password",
                              hintStyle: AppUtils.instance.textStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              errorMaxLines: 3,
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(left: 11,right: 11),
                                child: Image.asset(AppImage.passwordImage,
                                  scale: 2.7,
                                  // color: AppColors.grey,
                                ),
                              ),

                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Password ";
                              } else {
                                if(Provider.of<RegistrationProvider>(context,listen: false).passwordStructure(value)){
                                  return null;
                                }else{
                                  return "Password must include at least one alphabetic character, one digit, one special character, and be at least 8 characters long.";
                                }

                              }
                            },
                            onChanged: (passwordValue){
                              Provider.of<RegistrationProvider>(context,listen: false).passwordStructure(passwordValue);
                              // print(passwordValue);
                            },
                          ),
                          const SizedBox(height: 20),

                          // phone number
                          TextFormField(
                            maxLength: 10,
                            keyboardType: const TextInputType.numberWithOptions(signed: true),
                            onTap: () {},
                            controller: phoneController,
                            focusNode: phoneFocusNode,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.textFieldColor,
                              hintText: "Enter Phone Number",
                              hintStyle: AppUtils.instance.textStyle(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(left: 11,right: 11),
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
                              else{
                                if(value.length == 10){
                                  return null;
                                }else{
                                  return "Phone number should be 10 digits";
                                }
                              }

                            },
                          ),

                          const SizedBox(height: 20),

                          // address
                          TextFormField(
                            // textAlign : TextAlign.center,
                            maxLines: 2,
                            onTap: () {},
                            controller: addressController,
                            focusNode: addressFocusNode,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                                padding: const EdgeInsets.only(left: 11,right: 11),
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
                              else{
                                  return null;
                              }

                            },
                          ),

                          const SizedBox(height: 20),
                          Text("Gender:",
                              style: AppUtils.instance.textStyle(color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                fontSize: 16
                              )),
                          const SizedBox(height: 10),

                          Consumer<RegistrationProvider>(
                            builder: (_, gender, child) => Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    gender.genderCheck("Male");
                                  },
                                  child: Row(
                                    children: [
                                      gender.isMale
                                          ? const CircleAvatar(
                                        backgroundColor:
                                        AppColors.buttonColor,
                                        radius: 11,
                                      )
                                          : const CircleAvatar(
                                        backgroundColor: AppColors.black,
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
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 16,
                                            color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    gender.genderCheck("Female");
                                  },
                                  child: Row(
                                    children: [
                                      gender.isFemale
                                          ? const CircleAvatar(
                                        backgroundColor:
                                        AppColors.buttonColor,
                                        radius: 11,
                                      )
                                          : const CircleAvatar(
                                        backgroundColor: AppColors.black,
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
                                        style: AppUtils.instance.textStyle(
                                            fontSize: 16,
                                            color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          isFirstTime?
                          Consumer<RegistrationProvider>(
                              builder: (_, gender, child) =>
                              gender.isMale == false || gender.isFemale == false ?

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 13),
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
                                padding: EdgeInsets.only(left: 150,right: 150,top: 10,bottom: 10),
                                child: SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator()),
                              ),
                              bgColor: AppColors.buttonColor,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                            )
                                :

                          buttonWithText(
                              onPress: () {
                                validations();
                              },
                              bgColor: AppColors.buttonColor,
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              text: "Registration",
                              textColor: AppColors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)
                          ),

                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Spacer(),

                              Text(
                                "Existing User ",
                                style: AppUtils.instance.textStyle(
                                  color: AppColors.black,
                                ),
                              ),
                              InkWell(
                                onDoubleTap: () => null,
                                onTap: () {
                                  clearData();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginScreen()),
                                  );
                                },
                                child: Text(
                                  "Login Here?",
                                  style: AppUtils.instance.textStyle(
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              )
                            ],
                          ),

                          const SizedBox(height: 50),

                        ],
                      ),
                    ],
                  ),
                ),
              )
    )
    );
  }
  void validations() async {

    if(Provider.of<RegistrationProvider>(context,listen: false).isMale || Provider.of<RegistrationProvider>(context,listen: false).isFemale){
      isFirstTime = false;
      setState(() {

      });
    }else{
      isFirstTime = true;
      setState(() {

      });
    }


    if(_formKey.currentState!.validate()){

        Provider.of<RegistrationProvider>(context, listen: false).addUserDetails(
          context,
          firstName.text,
          lastName.text,
          emailController.text,
          addressController.text,
          passwordController.text,
          phoneController.text,
          Provider.of<RegistrationProvider>(context,listen: false).isMale ? "Male" : "Female",
          "Customer"

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


    }
  }


  void clearData(){
    firstName.clear();
    lastName.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    addressController.clear();
    Provider.of<RegistrationProvider>(context,listen: false).isMale = false;
    Provider.of<RegistrationProvider>(context,listen: false).isFemale = false;
  }
}

