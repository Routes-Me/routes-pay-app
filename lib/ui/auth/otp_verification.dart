import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/viewmodel/register_viewmodel.dart';

class OTPVerification extends StatefulWidget{
  Map<String, String> myObject;
  OTPVerification({this.myObject});
  @override
  _OTPState createState() => _OTPState(params: myObject);
}
class _OTPState extends State<OTPVerification> {
  final validateForm = GlobalKey<FormState>();
  Map<String, String> params ;
  _OTPState({this.params});

  @override
  void initState() {
    super.initState();
    ///showOtp('123456',context);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<RegisterViewModel>(
      builder: (context, provider, child) =>Form(
          key: validateForm,
          child: WillPopScope(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color:  Colors.white,
                    ),
                    child: Icon(Icons.arrow_back, color: Colors.black, size: 20,),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 0,
                backgroundColor: Colors.orange[400],
                brightness: Brightness.light,
              ),
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
                    Padding(padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Verify your number!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "We have sent an OTP on your email id.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                           // controller: passwordController,
                            decoration: InputDecoration(
                                hintText: 'Enter OTP Code here',
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

                    )
                  ],

                ),
              ),
            ),
          )),
    );
  }

  void showOtp(otp, BuildContext context) {
    ScaffoldMessenger.of(
        context)
        .showSnackBar(SnackBar(
        content: Text(otp)));
  }
  
}