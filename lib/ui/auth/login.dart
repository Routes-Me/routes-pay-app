import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/encrption/aesencryption.dart';
import 'package:routes_pay/main.dart';
import 'package:routes_pay/services/notifications.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final validateForm = GlobalKey<FormState>();
  final encryption = AESEncryption();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: android.smallIcon,
              ),
            ));
      }
    });
    getToken();
  }
  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
      token = token;
    print('Token : $token');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notificationService = NotificationServiceD();

    return Consumer<LoginViewModel>(
        builder: (context, provider, child) => Form(
              key: validateForm,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        constraints:
                            const BoxConstraints(minWidth: 240, maxWidth: 420),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome to Routes Pay",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  autofocus: true,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(focus);
                                  },
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
                                              const BorderSide(color: Colors.red))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  //autofocus: true,
                                  focusNode: focus,
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
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                provider.response!.status == Status.LOADING
                                    ? CircularProgressIndicator()
                                    : Expanded(
                                        flex: 1,
                                        child: ElevatedButton(
                                          child: const Text("Continue"),
                                          onPressed: () async {
                                            if (validateForm.currentState!
                                                .validate()) {
                                              FocusScope.of(context)
                                                  .requestFocus(
                                                      new FocusNode());
                                              Map<String, String> params = {
                                                'username':
                                                    emailController.text,
                                                'password':
                                                    encryption.encryptText(
                                                        passwordController.text)
                                              };
                                              /////
                                               provider.setState(
                                                  ApiResponse.loading(""));
                                              await provider.signIn(
                                                  params, context);
                                              switch (
                                                  provider.response!.status) {
                                                case Status.COMPLETED:
                                                  UserI userItem =
                                                      provider.response!.data;
                                                  SharedPreferences
                                                      setLoginDetails =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await setLoginDetails.setBool(
                                                      'isLogin', true);
                                                  await setLoginDetails
                                                      .setString('token',
                                                          userItem.token!);
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          "/home",
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              'Login Successful')));
                                                  break;
                                                case Status.ERROR:
                                                  return  ;
                                                case Status.INITIAL:
                                                  return ;
                                                default:
                                                  ScaffoldMessenger.of(context)
                                                  /////
                                                      .showSnackBar(const SnackBar(
                                                          content: Text("provider.response!.message")));
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                      child: Text("More options".toUpperCase(),
                                          style: const TextStyle(fontSize: 12)),
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(EdgeInsets.all(16.0)),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  side: const BorderSide(color: Colors.white)))),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed('/login-with-social');
                                      }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Don't have an account yet?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed("/signup");
                                        },
                                        child: const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      const Text(
                                        'Having a trouble',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      const TextSpan(
                                        text: "By signing in you accept our",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: "Terms of use and Privacy Policy",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Single tapped.
                                          },
                                        style: const TextStyle(
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
