import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group1_mapd726_shoe_app/Registration/RegistrationScreen.dart';
import 'package:group1_mapd726_shoe_app/Widgets/button_with_progress_idicator.dart';
import 'package:provider/provider.dart';

import '../Widgets/button_with_text.dart';
import '../utils/app_color.dart';
import '../utils/app_images.dart';
import '../utils/app_utils.dart';
import 'Provider/LoginProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNodeEmail = new FocusNode();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Center(
                    child: SizedBox(
                      // color: Colors.red,
                      height: 100,
                      child: Image.asset(
                        AppImage.appLogo,
                        width: 200,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Text("Welcome Back!",
                  style: AppUtils.instance.textStyle(
                    fontSize:30,
                    color: AppColors.black
                  )
                  ),

                  const SizedBox(height: 40),
                  // Text("Email",
                  //   style: AppUtils.instance.textStyle(fontSize: 16)
                  // ),
                  // const SizedBox(height: 10),
                  TextFormField(
                    style: const TextStyle(color: AppColors.labelColor),
                    onTap: () {},
                    controller: emailController,
                    focusNode: myFocusNodeEmail,
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
                      prefixIcon: Image.asset(AppImage.emailImage,
                        scale: 3,
                        // color: AppColors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter email id";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (emailValue){
                      Provider.of<LoginProvider>(context,listen: false).emailStructure(emailValue);
                      // print(emailValue);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: const TextStyle(color: AppColors.labelColor),

                    obscureText: true,
                    onTap: () {},
                    controller: passwordController,
                    focusNode: myFocusNode,
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
                      prefixIcon: Container(
                        padding: const EdgeInsets.only(left: 11,right: 11),
                        child: Image.asset(AppImage.passwordImage,
                          scale: 2.5,
                          // color: AppColors.grey,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password ";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (passwordValue){
                      Provider.of<LoginProvider>(context,listen: false).passwordStructure(passwordValue);
                      // print(passwordValue);
                    },
                  ),


                  const SizedBox(height: 50),

              Consumer<LoginProvider>(
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
                    text: "Login",
                    textColor: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)

              ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        "New User? ",
                        style: AppUtils.instance.textStyle(
                          color: AppColors.black,
                        ),
                      ),
                      InkWell(
                        onDoubleTap: () => null,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrationScreen()),
                          );
                        },
                        child: Text(
                          "Register Here",
                          style: AppUtils.instance.textStyle(
                            color: AppColors.buttonColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
  void validations() async{
    print("login Pressed");
    String convertIntoString = emailController.text.toString();

    String finalEmail = convertIntoString.replaceAll(" ", "");

    if(_formKey.currentState!.validate()){
      Provider.of<LoginProvider>(context,listen: false).loginUser(context,finalEmail.toString(), passwordController.text.toString());

    }
    //   else{}
    // }
    // return net;
  }
}

