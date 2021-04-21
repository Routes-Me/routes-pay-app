import 'dart:math';
import 'dart:typed_data';
import 'package:routes_pay/encrption/EncryptModel.dart';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AESEncryption{
  final encryptModel = EncryptModel();
  List<String> charPool = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  String encryptText(String password){
    final saltIndexChars = getSalt(2);
    var saltIndexNumber = 0;
    for(var i=0;i<saltIndexChars.length;i++){
      saltIndexNumber += saltIndexChars.codeUnitAt(i);
      print('$saltIndexNumber');
    }
    final saltBeginIndex = saltIndexNumber % 3;
    final saltExcluded = getSalt(3);
    final fullSalt = getSalt(16);
    final realSalt = fullSalt.replaceAll(RegExp("${saltExcluded.split('')}"),'');
    final encryptStr = encrypt(realSalt,password);
    final saltPart1 = fullSalt.substring(0,10);
    final saltPart2 = fullSalt.substring(10);
    final encryptTextFormat1 = encryptStr.substring(0,saltBeginIndex+1) + saltPart1+encryptStr.substring(saltBeginIndex + 1);
    final index = saltPart1.length+1+saltBeginIndex;
    final encryptTextFormat2 = encryptTextFormat1.substring(0,index+1)+saltPart2+encryptTextFormat1.substring(index + 1);
    final result = saltIndexChars+saltExcluded+encryptTextFormat2;
    return result;
  }
  String encrypt(String salt,String password){
    var iv = sha1.convert(utf8.encode(encryptModel.iv)).toString().substring(0,16);
    final key = Key.fromUtf8(encryptModel.key.toString().substring(0,16));
    final encrypter = Encrypter(AES(key,mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv:  IV.fromUtf8(iv));
    return encrypted.base64;
  }

  String getSalt(int i){
    var element ="";
    for(final i in range(0, i)) {
      element += charPool[Random().nextInt(charPool.length)];
    }
    return element;
  }

  Iterable<int> range(int low, int high) sync* {
    for (int i = low; i < high; ++i) {
      yield i;
    }
  }

}