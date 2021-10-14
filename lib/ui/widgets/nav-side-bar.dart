// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:routes_pay/ui/auth/login.dart';
import 'package:routes_pay/controller/social_login_controller.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SocialLoginController>(
      builder: (context, provider, _) => Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
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
              title: const Text(
                'Share',
                style: TextStyle(fontFamily: 'Montserrat-Arabic Regular'),
              ),
              onTap: () => null,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings',
                  style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
              onTap: () => null,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Policies',
                  style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
              // ignore: avoid_returning_null_for_void
              onTap: () => null,
            ),const Divider(),
            ListTile(
              leading: const Icon(Icons.perm_identity_rounded),
              title: const Text('Profile',
                  style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
              // ignore: avoid_returning_null_for_void
              onTap: () => null,
            ),
            const Divider(),
            ListTile(
              title: const Text('Exit',
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
      ),
    );
  }
}
