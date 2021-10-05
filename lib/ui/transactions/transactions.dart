import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routes_pay/constants/app_textstyle.dart';
import 'package:routes_pay/constants/color_constants.dart';
import 'package:routes_pay/data/transaction_data.dart';
import 'package:routes_pay/ui/home/home.dart';
import 'package:routes_pay/ui/transactions/transaction_card.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          Get.arguments['name'],
          style: const TextStyle(
              fontFamily: "Poppins",
              color: kPrimaryColor,
              fontSize: 28
          ),
        ),
        leading: IconButton(onPressed: ()=>Get.off(()=>Home()), icon:Icon(Icons.arrow_back,color: Colors.black,)),

        // actions: [
        //   IconButton(
        //       icon: const Icon(
        //         Icons.notifications_active_outlined,
        //         color: Colors.deepOrange,
        //         size: 27,
        //       ),
        //       onPressed: () {})
        // ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Recent Transactions",
                style: ApptextStyle.BODY_TEXT,
              ),
              const SizedBox(
                height: 15,
              ),
              ListView.separated(
                  itemCount: myTransactions.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    return TransactionCard(transaction: myTransactions[index]);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
