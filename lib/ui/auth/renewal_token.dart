import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

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

  void renewToken() {
    Map<String,String> allvalues = {
      'refreshToken' : "",
      'access_token' : ""
    };
    Future<void> renewalToken(Map<String, String> params, BuildContext context) async {
      try {
        User userItem = await userRepository.signIn(params, context);

      } catch (e) {
        print("Error Response ${e.toString()}");

      }

    }
    userRepository.renewalToken(allvalues, context);

  }
}
