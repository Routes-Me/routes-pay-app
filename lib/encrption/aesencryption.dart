import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:routes_pay/encrption/EncryptModel.dart';

class AESEncryption{
  final encryptModel = EncryptModel();

  String encrypt(String password){
    var iv = sha1.convert(utf8.encode(encryptModel.iv)).toString().substring(0,16);
    final key = Key.fromUtf8(encryptModel.key.toString().substring(0,16));
    final encrypter = Encrypter(AES(key,mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv:  IV.fromUtf8(iv));
    return encrypted.base64;
  }

}