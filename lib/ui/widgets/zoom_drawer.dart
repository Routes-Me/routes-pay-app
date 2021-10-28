import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:routes_pay/controller/lang_controller.dart';
import 'package:routes_pay/ui/home/home.dart';

import 'nav-side-bar.dart';


class MyHomePage extends StatefulWidget {
 final bool? dir ;
MyHomePage(this.dir);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final drawerController = ZoomDrawerController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<LangController>(
        builder: (controller)=> ZoomDrawer(
          controller: drawerController,
          style: DrawerStyle.Style1,
            clipMainScreen: false,
            menuScreen: SideNavBar(), mainScreen: Home(drawerController),
          borderRadius: 14.0,
          angle: 0.0,

          backgroundColor: Colors.grey.shade100,
          slideWidth: MediaQuery.of(context).size.width *0.50,
          showShadow: false,
          duration: Duration(milliseconds: 150),
          openCurve: Curves.fastOutSlowIn,
          isRtl:controller.isRTL,
          closeCurve: Curves.fastLinearToSlowEaseIn,

        ),
      )
    );
  }
}
