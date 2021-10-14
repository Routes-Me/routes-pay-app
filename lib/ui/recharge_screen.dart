import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RechargeScreen extends StatefulWidget {
  final cardInfo;

  const RechargeScreen({Key? key, this.cardInfo}) : super(key: key);

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  var globalKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  List years = ['2021', '2022', '2023', '2024', '2025', '2026', '2027', '2028','2029', '2030'];
  List months = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12'
  ];
  String? dropdownMonthVal = '01';
  String? dropdownYearVal = '2021';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: widget.cardInfo.leftColor,
        title: Text(
          'Payment Details',
          style: TextStyle(fontSize: 20, color: widget.cardInfo.leftColor),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 0.4)),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/images/knet-1.png'),
                      image: AssetImage('assets/images/knet-1.png'),
                      height: 46,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: Get.width - 120,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Payment amount'),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                              '${widget.cardInfo.cardBalance!.toStringAsFixed(3)} KD'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width - 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Holder Name'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Invalid Value';
                              } else {
                                return null;
                              }
                            },
                            controller: cardHolderController,
                            decoration: InputDecoration(
                                //hintText: 'Card Number',

                                // prefixIcon: Icon(Icons.payment),
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Card Number'),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextFormField(
                            controller: cardNumberController,
                            minLines: 1,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Invalid Value';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 1,
                            maxLengthEnforced: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                //hintText: 'Card Number',
                                // prefixIcon: Icon(Icons.payment),
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width - 120,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Expire Date'),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButton(
                                      value: dropdownMonthVal,
                                      onChanged: (val) {
                                        setState(() {
                                          dropdownMonthVal = val.toString();
                                          print(dropdownMonthVal);
                                        });
                                      },
                                      items: months.map(
                                        (val) {
                                          return DropdownMenuItem(
                                            child: Text(val),
                                            value: val,
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    DropdownButton(
                                      value: dropdownYearVal,
                                      onChanged: (val) {
                                        setState(() {
                                          dropdownYearVal = val.toString();
                                        });
                                      },
                                      items: years.map(
                                        (val) {
                                          return DropdownMenuItem(
                                            child: Text(val),
                                            value: val,
                                          );
                                        },
                                      ).toList(),
                                    ),
                                    SizedBox(
                                      width: Get.width - 330,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                              height: 0, fontSize: 14),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.2 - 20,
                                          child: TextFormField(
                                            controller: cvvController,
                                            enabled: true,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'Invalid Value';
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            maxLengthEnforcement:
                                                MaxLengthEnforcement
                                                    .truncateAfterCompositionEnds,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 52.0),
                    child: Center(
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                print('Good Value');
                              }
                            },
                            icon: Icon(Icons.payment),
                            label: Text('Check'))),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
