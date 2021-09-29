import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:routes_pay/ui/widgets/nav-side-bar.dart';
import '../widgets/cards_slider.dart';

class Home extends StatefulWidget  {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    getToken();
  }
  String? token;
  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = token;
    });
    print('Token : $token');
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const SideNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Routes Pay',
            style: TextStyle(fontFamily: 'Montserrat-Arabic Regular',fontSize: 32)),
        centerTitle: true,

        backgroundColor: Color.fromRGBO(36,68,148 ,1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

            Spacer(),
          CreditCards()
        ],
      ),
    );
  }
}
