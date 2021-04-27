import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/data/pojo/user_token.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RenewalToken extends StatefulWidget {
  @override
  _RenewalTokenState createState() => _RenewalTokenState();
}

class _RenewalTokenState extends State<RenewalToken> {
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    renewToken();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Center(
          child:Column(
            children: [
              SizedBox(height: 300,),
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text('Please wait')
            ],
          )
        ),
      ),
    );
  }

  void renewToken() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
    String refreshToken = prefs.getString('refreshToken');
    if(refreshToken !=null){
      Map<String,String> allvalues = {
        'refreshToken' : refreshToken,
      };
      try{
        UserToken userToken =  await userRepository.renewalToken(allvalues, context);
        prefs.setString('refreshToken', userToken.refreshToken);
        prefs.setString('token', userToken.accessToken);
        Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> route) => false);
      }catch(e){
        Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
      }
    }
  }
}
