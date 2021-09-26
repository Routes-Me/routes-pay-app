
import 'package:flutter/material.dart';

class CardsModel extends ChangeNotifier {
  String? cardName = '' ;

  changeCardName(String name) {
    cardName = name ;

    notifyListeners();
  }



}