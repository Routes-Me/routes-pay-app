import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/data/pojo/message.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/encrption/aesencryption.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:routes_pay/ui/viewmodel/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp_verification.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final validateForm = GlobalKey<FormState>();
  final encryption = AESEncryption();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final focus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
        builder: (context, provider, child) => Form(
          key: validateForm,
          child: WillPopScope(
            onWillPop: null,
            child: Scaffold(
              resizeToAvoidBottomInset : false,
              appBar: AppBar(
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color:  Colors.white,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black, size: 20,),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 0,
                backgroundColor: Colors.orange[400],
                brightness: Brightness.light,
              ),
              body:Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [
                        Colors.orange.shade700,
                        Colors.orange.shade500,
                        Colors.orange.shade300
                      ]),
                ),
                child: ListView(
                  children:[ Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        constraints: const BoxConstraints(minWidth: 240, maxWidth: 480),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Register to Routes Pay",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              controller: nameController,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "* Required"),
                              ]),
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  filled: true,
                                  fillColor: Colors.orange[50],
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500]),
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "* Required"),
                                EmailValidator(
                                    errorText: "Enter valid email id"),
                              ]),
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: Colors.orange[50],
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500]),
                                  contentPadding: const EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: MultiValidator([
                                RequiredValidator(errorText: "* Required"),
                                /*EmailValidator(
                              errorText: "Enter valid mobile no"),*/
                              ]),
                              decoration: InputDecoration(
                                  hintText: 'Mobile no',
                                  filled: true,
                                  fillColor: Colors.orange[50],
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500]),
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "* Required"),
                                MinLengthValidator(4,
                                    errorText:
                                    "Password should be atleast 6 characters"),
                                MaxLengthValidator(15,
                                    errorText:
                                    "Password should not be greater than 15 characters")
                              ]),
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.orange[50],
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500]),
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              focusNode: focus,
                              controller: confirmPasswordController,
                              validator: (confirmation){
                                return confirmation!.isEmpty
                                    ? '* Required'
                                    : validationEqual(confirmation, passwordController.text) ? null : 'Password not match';
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Confirm Passsword',
                                  filled: true,
                                  fillColor: Colors.orange[50],
                                  hintStyle:
                                  TextStyle(color: Colors.grey[500]),
                                  contentPadding: EdgeInsets.all(10.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        constraints: const BoxConstraints(minWidth: 240, maxWidth: 320),
                        child:Expanded(
                          child: ElevatedButton(
                            child: const Text("Sign Up"),
                            onPressed: () async {
                              if (validateForm.currentState!
                                  .validate()) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                Map<String, String> params = {
                                  'Email': emailController.text,
                                  'Password': encryption.encryptText(passwordController.text),
                                  'PhoneNumber' : phoneController.text,
                                  'Name' : nameController.text,
                                };
                                /*Navigator.push(context, MaterialPageRoute(
                                      builder: (_) => OTPVerification(myObject : params)
                                    ));*/
                                provider.setState(ApiResponse.loading(""));
                                await provider.register(params, context);
                                switch (provider.response.status) {
                                  case Status.COMPLETED:
                                    String message = provider.response.data;
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, "/login", (Route<dynamic> route) => false);
                                    ScaffoldMessenger.of(
                                        context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            message)));
                                    break;
                                  case Status.ERROR:
                                    // was snack bar here
                                    return ;
                                  case Status.INITIAL:
                                    return ;
                                  default:
                                    ScaffoldMessenger.of(
                                        context)
                                        .showSnackBar( SnackBar(
                                        content: Text(provider.response.message!)));
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              elevation: 0.0,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),]
                ),
              ) ,
            ),
          ),
        ));
  }

  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }
}
