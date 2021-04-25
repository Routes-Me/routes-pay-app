import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/datasource/data_source.dart';
import 'package:routes_pay/encrption/aesencryption.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final validateForm = GlobalKey<FormState>();
  final encryption = AESEncryption();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
        builder: (context, provider, child) => Form(
              key: validateForm,
              child: Scaffold(
                resizeToAvoidBottomInset : false,
                body: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        colors: [
                          Colors.orange[600],
                          Colors.orange[500],
                          Colors.orange[400]
                        ]),
                  ),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome to Routes Pay",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
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
                                          contentPadding: EdgeInsets.all(10.0),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
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
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextFormField(
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
                                            borderSide: BorderSide(
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
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      provider.response.status == Status.LOADING
                                          ? CircularProgressIndicator() :
                                      Expanded(
                                              flex: 1,
                                              child: ElevatedButton(
                                                child: Text("Continue"),
                                                onPressed: () async {
                                                  if (validateForm.currentState
                                                      .validate()) {
                                                    FocusScope.of(context).requestFocus(new FocusNode());
                                                    Map<String, String> params = {
                                                      'username':
                                                          emailController.text,
                                                      'password':'%JhujMD7MGVkL2pXpiD1ADYveiTDGXg8uh5hSeB2JU3Q=='
                                                      //'password': encryption.encryptText(passwordController.text)
                                                    };
                                                    provider.setState(
                                                        ApiResponse.loading(""));
                                                    await provider.signIn(params, context);

                                                    switch (
                                                        provider.response.status) {
                                                      case Status.COMPLETED:
                                                        User userItem = provider.response.data;
                                                        SharedPreferences setLoginDetails = await SharedPreferences.getInstance();
                                                        await setLoginDetails.setBool('isLogin', true);
                                                        await setLoginDetails.setString('token', userItem.token);
                                                        Navigator.pushNamedAndRemoveUntil(
                                                              context, "/home", (Route<dynamic> route) => false);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    'Login Successfull')));
                                                        break;
                                                      case Status.ERROR:
                                                        return ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    provider
                                                                        .response
                                                                        .message)));
                                                      case Status.INITIAL:
                                                        return "";
                                                      default:
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    provider
                                                                        .response
                                                                        .message)));
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.all(16.0),
                                                  primary: Colors.white,
                                                  elevation: 0.0,
                                                  onPrimary: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(8.0),
                                                  ),
                                                ),
                                              )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextButton(
                                            child: Text("More options".toUpperCase(),
                                                style: TextStyle(fontSize: 12)),
                                            style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all<EdgeInsets>(
                                                        EdgeInsets.all(16.0)),
                                                foregroundColor:
                                                    MaterialStateProperty.all<Color>(
                                                        Colors.white),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        side: BorderSide(color: Colors.white)))),
                                            onPressed: () {}),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Don't have an account yet?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        'Having a trouble',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Recover account',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: "By signing in you accept our",
                                              style: TextStyle(
                                                  fontSize: 17, color: Colors.black),
                                            ),
                                            TextSpan(
                                              text:
                                                  " Terms of use and Privacy Policy",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                                decoration: TextDecoration.underline,
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),


                ),
              ),
            ));
  }
}
