import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routes_pay/ui/model/user_details.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SocialLoginController extends ChangeNotifier {
  String? _token;

  bool get isAuth {
    return _token != null;
  }

  final googleSignIn = GoogleSignIn();
  bool? _isSigningIn = false ;
  bool? appleSignedIn =false ;
  bool signedIn = false;

  googleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn!;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future loginWithGoogle([context]) async {

    //save type of login
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('type_of_last_login', 1);
    isSigningIn = true;

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      signedIn =true;
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value)async {

        _token = googleAuth.idToken;
        uid = googleUser.id;
        nameUser = googleUser.displayName;
        emailUser = googleUser.email;
        imageUserUrl = googleUser.photoUrl;
        print("Uid : $uid");
        print("name : $nameUser");
        print("email : $emailUser");
        print("image : $imageUserUrl");
        print(signedIn);
        print("access token : ${googleAuth.accessToken}");


        //post api login

        Map<String, String> params = {
          'username':nameUser!,
          'token':credential.token.toString(),
          'email':emailUser!,
        };
        try {
          final userRepository = UserRepository();
           await userRepository.signIn(
              params,context);
          /////
        } catch (e) {
          print("Error Response ${e.toString()}");
          /////
        }
        notifyListeners() ;

      });

      //isSigningIn = false;
    }
  }

  void logoutGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    isSigningIn =false;
    Get.back();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    notifyListeners() ;


  }

  GoogleSignInAccount? _user;
  String? imageUserUrl;
  String? emailUser;
  String? nameUser;
  String? uid;

  //login with facebook

  Map? userData;
  UserDetails? userDetails;
  bool? facebookIsLogin = false;

  Future loginWithFacebook() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    // check the status of our login
    if (result.status == LoginStatus.success) {
      isSigningIn = true;
      signedIn =true;
      //save type of login
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('type_of_last_login', 2);
      notifyListeners();
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );
      facebookIsLogin = true;

      userData = requestData;
      userDetails = UserDetails(
        displayName: requestData["name"],
        email: requestData["email"],
        photoURL: requestData["picture"]["data"]["url"] ?? "",
      );
      print("facebook name is  ${userDetails!.displayName}");
      signedIn =true;
      imageUserUrl = userDetails!.photoURL;
      nameUser = userDetails!.displayName;
      emailUser = userDetails!.email;
      notifyListeners();
    } else {
      print(result.message);

      print(result.status);
    }
    notifyListeners() ;

  }

  // logout
  logoutFacebook() async {
    await FacebookAuth.i.logOut();
    userData = null;
    Get.back();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

//login with apple
  Future<void> signInWithApple() async {
    final appleIdCredential =
    await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ]);
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode);
   try{
     await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
       _token = appleIdCredential.identityToken;
       // _userId = appleIdCredential.userIdentifier;
       nameUser = appleIdCredential.familyName;
       emailUser = appleIdCredential.email;
       isAuth;
       imageUserUrl = appleIdCredential.state;
       signedIn=true;
       appleSignedIn =true ;
       print('email apple = $emailUser');
       notifyListeners();
     });
   }catch(err){
     print('err apple login $err');
   }
  }
  logoutApple() async {
    userData = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  final _firebaseAuth = FirebaseAuth.instance;

  //tryToLogin
  Future tryLogin()async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final type =  (preferences.getInt('type_of_last_login') !=null) ?  preferences.getInt('type_of_last_login'):null;
  if(type ==1){
    loginWithGoogle();
  }else if(type ==2){
    //loginWithFacebook();
  }else if (type ==3){
    print('it 3');
  }
  notifyListeners() ;

}
}
