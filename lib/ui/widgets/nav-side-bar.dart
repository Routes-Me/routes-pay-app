// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/controller/lang_controller.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/controller/social_login_controller.dart';
import 'package:routes_pay/ui/profile/my_profile.dart';
import 'package:routes_pay/ui/setting/setting_screen.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SocialLoginController>(
      builder: (context, provider, _) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       // Remove padding
       children: [
         UserAccountsDrawerHeader(
           accountName: Text(provider.nameUser ?? 'Name'),
           accountEmail: Text(provider.emailUser ?? 'Email'),
           currentAccountPicture: CircleAvatar(
             child: ClipOval(
               child: Image.network(
                 provider.imageUserUrl ??'https://firebasestorage.googleapis.com/v0/b/routes-pay.appspot.com/o/routes_background.jpg?alt=media&token=c978d6d9-5f96-4c09-aa33-6159c3b2ea43',
                 fit: BoxFit.fill,
                 width: 100,
                 height: 100,
               ),
             ),
           ),
           decoration: BoxDecoration(
             color: Colors.orange[600],
             image:   DecorationImage(
                 fit: BoxFit.fill,
                 image:AssetImage('assets/images/routes_background.png') ),
           ),
         ),
         ListTile(
           leading: const Icon(Icons.share),
           title:  Text(
             'btn_share'.tr,
             style: TextStyle(fontFamily: 'Montserrat-Arabic Regular'),
           ),
           onTap: () => null,
         ),
         const Divider(),
         ListTile(
           leading: const Icon(Icons.settings),
           title:  Text('btn_Setting'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           onTap: () => Get.to(()=>Setting()),
         ),
        const Divider(),
         ListTile(
           leading: const Icon(Icons.perm_identity_rounded),
           title:  Text('btn_Profile'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           // ignore: avoid_returning_null_for_void
           onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyProfile()),),
         ),


         const Divider(),
         ListTile(
           title:  Text('btn_aboutUs'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           leading: const Icon(Icons.contact_support_outlined),
           onTap: () {
             if (provider.isSigningInGoogle ) {
               provider.logoutGoogle();
               Get.offAll(()=> Login());
             } else if (provider.facebookIsLogin!) {
               provider.logoutFacebook();
               Get.offAll(()=> Login());

             }else if (provider.appleSignedIn!) {
               provider.logoutApple();
               Get.offAll(()=> Login());

             }
           },
         ),


         const Divider(),
         ListTile(
           title:  Text('btn_contact'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           leading: const Icon(Icons.phone_in_talk_outlined),
           onTap: () {
             if (provider.isSigningInGoogle ) {
               provider.logoutGoogle();
               Get.offAll(()=> Login());
             } else if (provider.facebookIsLogin!) {
               provider.logoutFacebook();
               Get.offAll(()=> Login());

             }else if (provider.appleSignedIn!) {
               provider.logoutApple();
               Get.offAll(()=> Login());

             }
           },
         ),
         const Divider(),
         ListTile(
           title:  Text('btn_Lang'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           leading: GetBuilder<LangController>(
             init: LangController(),
             builder: (controller)=> DropdownButton(

               items: [
                 DropdownMenuItem(child: Text('EN'),value: 'en',),
                 DropdownMenuItem(child: Text('AR'),value: 'ar',),
                 DropdownMenuItem(child: Text('HI'),value: 'hi',)

               ],
               value:controller.appLocal ,
               onChanged: (val){
                 controller.changeLang(val.toString());
                 Get.updateLocale(Locale(val.toString()));
                 controller.changeDIR(val.toString());
               },
             ),
           ),
           onTap: () {
           },
         ),
         const Divider(),
         ListTile(
           title:  Text('btn_Exit'.tr,
               style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
           leading: const Icon(Icons.exit_to_app),
           onTap: () {
             if (provider.isSigningInGoogle ) {
               provider.logoutGoogle();
               Get.offAll(()=> Login());
             } else if (provider.facebookIsLogin!) {
               provider.logoutFacebook();
               Get.offAll(()=> Login());

             }else if (provider.appleSignedIn!) {
               provider.logoutApple();
               Get.offAll(()=> Login());

             }
           },
         ),

         const Divider(),
       ],
        ),
    );
  }
}
