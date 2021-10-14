
import 'package:flutter/material.dart';

class CardsModel extends ChangeNotifier {
  String? cardName = 'google.com' ;

  changeCardName(String name) {
    cardName = name ;

    notifyListeners();
  }

}