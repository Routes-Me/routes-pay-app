import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routes_pay/constants/app_textstyle.dart';
import 'package:routes_pay/data/transaction_data.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel? transaction;
  const TransactionCard({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(5, 6)
            )
          ],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey[900]!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: transaction!.color,
                ),
                child: Image.asset(transaction!.avatar!),
              ),
              SizedBox(
                width: 10,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 142,
                    child: Text(
                      transaction!.name!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ApptextStyle.LISTTILE_TITLE,
                    ),
                  ),
                  Text(
                    transaction!.month!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ApptextStyle.LISTTILE_SUB_TITLE,
                  ),
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    transaction!.currentBalance!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ApptextStyle.LISTTILE_TITLE,
                  ),

                  Row(
                    children: [
                      transaction!.changePercentageIndicator == "up"
                          ? const Icon(
                              FontAwesomeIcons.levelUpAlt,
                              size: 14,
                              color: Colors.red,
                            )
                          : const Icon(
                              FontAwesomeIcons.levelDownAlt,
                              size: 14,
                              color: Colors.green,
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        transaction!.transactionType!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ApptextStyle.LISTTILE_SUB_TITLE,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
