import 'package:flutter/material.dart';

class VisaMasterMethod extends StatefulWidget {
  final String? paymentMethod;
  const VisaMasterMethod({Key? key,this.paymentMethod}) : super(key: key);

  @override
  _VisaMasterMethodState createState() => _VisaMasterMethodState();
}

class _VisaMasterMethodState extends State<VisaMasterMethod> {
  var globalKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: TextButton(child: Text('Cancel',style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade900
        ),), onPressed: () { Navigator.of(context).pop(); },

        ),
        title: Text('The Card',style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade900
        ),),
        centerTitle: true,
      ),
      body: Form(
        key: globalKey,
        child: Container(child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid Value';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Card Number',

                            // prefixIcon: Icon(Icons.payment),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid Value';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Month',

                            // prefixIcon: Icon(Icons.payment),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid Value';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Year',
                            // prefixIcon: Icon(Icons.payment),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid Value';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'CVV',

                            // prefixIcon: Icon(Icons.payment),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      SizedBox(
                        width: 260,
                        child: TextFormField(
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Invalid Value';
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Card Holder Name',

                            // prefixIcon: Icon(Icons.payment),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28.0,right: 12.0,left: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton.icon(onPressed: (){

                    if(globalKey.currentState!.validate()){
                      print('ok');
                    }else{
                      print('bad value');
                    }
                  }, icon: Icon(Icons.account_balance_wallet_outlined), label: Text('Submit')),
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
