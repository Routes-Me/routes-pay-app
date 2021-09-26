import 'package:flutter/material.dart';

class TransactionModel {
  String? name;
  String? avatar;
  String? currentBalance;
  String? month;
  String? changePercentageIndicator;
  String? transactionType;
  Color? color;

  TransactionModel({
    this.avatar,
    this.transactionType,
    this.changePercentageIndicator,
    this.currentBalance,
    this.month,
    this.name,
    this.color,
  });
}

List<TransactionModel> myTransactions = [
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    transactionType: "Pay",
    changePercentageIndicator: "up",
    month: "Jan",
    name: "Supreme Leader",
    color: Colors.green[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 5.000",
    changePercentageIndicator: "down",
    transactionType: "ReCharge",
    month: "Mar",
    name: "Supreme Leader",
    color: Colors.orange[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    transactionType: "Pay",
    changePercentageIndicator: "down",
    month: "Mar",
    name: "Supreme Leader",
    color: Colors.red[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    changePercentageIndicator: "up",
    transactionType: "Pay",
    month: "Mar",
    name: "Supreme Leader",
    color: Colors.deepPurple[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    transactionType: "Pay",
    changePercentageIndicator: "up",
    month: "Jan",
    name: "Supreme Leader",
    color: Colors.green[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    changePercentageIndicator: "down",
    transactionType: "Pay",
    month: "Mar",
    name: "Supreme Leader",
    color: Colors.orange[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    changePercentageIndicator: "up",
    transactionType: "Pay",
    month: "Mar",
    name: "Supreme Leader",
    color: Colors.deepPurple[100],
  ),
  TransactionModel(
    avatar: "assets/icons/avatar2.png",
    currentBalance: "kd 0.300",
    transactionType: "Pay",
    changePercentageIndicator: "up",
    month: "Jan",
    name: "Supreme Leader",
    color: Colors.green[100],
  ),
];
