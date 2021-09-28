import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:routes_pay/ui/viewmodel/cards_model.dart';
import 'package:routes_pay/ui/widgets/nav-side-bar.dart';
import '../widgets/cards_slider.dart';

class Home extends StatefulWidget  {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  String qrValue = '';

  updateQR() {
    setState(() {
      qrValue = controller.text;
    });
  }

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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const SideNavBar(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Routes Pay',
            style: TextStyle(fontFamily: 'Montserrat-Arabic Regular')),
        centerTitle: true,
        backgroundColor: Colors.orange[500],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.orange.shade700,
              ),
              height: screenSize.height * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Wallet',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              'TOTAL PAYMENT',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade200),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'KD 320.500',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade200,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.4),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Colors.blue.shade700,
                      ),
                      // height: screenSize.height * 0.1 -70,
                    ),
                  ),

                ],
              ),
            ),
          ),
          Spacer(),

            CreditCards(),
        ],
      ),
    );
  }
}
