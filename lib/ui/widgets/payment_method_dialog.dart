import 'package:flutter/material.dart';

Future<void> showD( context)async{
  return await showDialog(context: context, builder: (context){
    var globalKey =GlobalKey<FormState>();
    int? value = 1 ;


    return StatefulBuilder(builder: (context,setState){
      return Container(
        width: MediaQuery.of(context).size.width,

        child: AlertDialog(
          insetPadding: EdgeInsets.only(top: 93),
          contentPadding: EdgeInsets.all(5),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height -100,
              child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Payment'),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Please choose payment method'),
                      ),
                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300
                        ),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              value = 1 ;
                              print(value);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 1, groupValue: value, onChanged: (val){
                                setState(() {
                                  value = val as int? ;
                                  print(value);
                                });
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Image.asset('assets/images/knetl.png',
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300
                        ),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              value = 2 ;


                              print(value);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 2, groupValue: value, onChanged: ( val){
                                setState(() {
                                  value =val as int?;
                                  print(value);

                                });
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Image.asset('assets/images/mastercard-home-green-star-heating-cooling-17.png',
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      value == 2 ? Column(
                        children: [
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
                      ):Container(),
                      value==1?SizedBox(
                        width: 160,
                        child: ElevatedButton.icon(
                            onPressed: (){

                            }, icon: Icon(Icons.payment), label: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: const Text('CheckOut'),
                        )),
                      ):Container()
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  });
}