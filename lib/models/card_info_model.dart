import 'dart:ui';

class CardInfo {
  String? cardId;
  Color? leftColor;
  Color? rightColor;
  String? userName;
  String? cardName;
  double? cardBalance;
  String? busesNames;
  String? durationCard;
  String? expireDate ;

  CardInfo(
      {
        this.cardId,
        this.expireDate,
        this.busesNames,
        this.durationCard,
        this.cardBalance,
        this.userName,
        this.cardName,
        this.rightColor,
        this.leftColor});
}
