import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routes_pay/ui/offers/offers.dart';

bool bottomIsVisible = true;

class BottomNavB extends StatefulWidget {
  const BottomNavB({Key? key}) : super(key: key);

  @override
  _bottomNavBState createState() => _bottomNavBState();
}
late int _currentIndex =1;

class _bottomNavBState extends State<BottomNavB> {
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (_currentIndex == 4) {
      print('home');
    } else if (_currentIndex == 1) {
      print('Offers');
      Get.to(()=>Offers());
    } else if (_currentIndex == 0) {
      print('Recharge');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BottomNavigationBar(
          unselectedIconTheme: IconThemeData(color: Colors.orange.shade400),
          selectedIconTheme: IconThemeData(color: Colors.orange.shade800),
          unselectedLabelStyle: TextStyle(
              color: Colors.grey[400],
              fontFamily: 'Montserrat-Arabic Regular'),
          selectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat-Arabic Regular'),
          fixedColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.moneyBill), label: 'Recharge'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.moneyBill), label: 'Offers'),
          ],
        ),
      ],
    );
  }
}