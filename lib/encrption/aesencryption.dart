import 'dart:math';
import 'dart:typed_data';
import 'package:aes_crypt/aes_crypt.dart';
import 'package:routes_pay/encrption/EncryptModel.dart';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart' as Crypt;
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
    final encryptStr = encrypt(password);
    final prefix = saltIndexChars + saltExcluded;
    var formatCipher =  formatEncryptText(prefix,encryptStr,fullSalt,saltBeginIndex);
    var positionToInsert = getRandomPosition();
    var encryptedTextForDashBoardPart1 = formatCipher.substring(0, positionToInsert);
    var encryptedTextForDashBoardPart2 = formatCipher.substring(positionToInsert);
    final cipherTextForDashBoard = encryptedTextForDashBoardPart1 + '%' + encryptedTextForDashBoardPart2;
    return cipherTextForDashBoard;
  }

  String formatEncryptText(String prefix,String encryptText,String salt,int positionIndex) {
    var saltPart1 = salt.substring(0,10);
    var saltPart2 = salt.substring(10);
    var encryptPart1 ='', encryptPart2='',encryptPart3='';
    if(positionIndex>0)
    {
      encryptPart1 = encryptText.substring(0,positionIndex);
      encryptPart2 = encryptText.substring(positionIndex,positionIndex+1);
      encryptPart3 = encryptText.substring(positionIndex+1);
      return prefix + encryptPart1 + saltPart1 + encryptPart2 + saltPart2 + encryptPart3;
    }
    encryptPart1 = encryptText.substring(0,1);
    encryptPart2 = encryptText.substring(1);
    return prefix + saltPart1 + encryptPart1 + saltPart2 + encryptPart2;
  }

  /*String encrypt(String salt,String password){
    var iv = sha1.convert(utf8.encode(encryptModel.iv)).toString().substring(0,16);
    final key = Key.fromUtf8(encryptModel.key.toString().substring(0,16));
    final encrypter = Encrypter(AES(key,mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(password, iv:  IV.fromUtf8(iv));
    return encrypted.base64;
  }*/


  String encrypt(String password){
    var iv = utf8.encode(encryptModel.iv).toString().substring(0, 16);// Consider the first 16 bytes of all 64 bytes
    var key = utf8.encode(encryptModel.key).toString().substring(0, 16);// Consider the first 32 bytes of all 64 bytes
    IV ivObj = IV.fromUtf8(iv);
    Key keyObj = Key.fromUtf8(key);
    final encrypter = Encrypter(AES(keyObj, mode: AESMode.cbc));        // Apply CBC mode
    final encrypt = encrypter.encrypt(password, iv: ivObj);
    print("Encyrpt ${encrypt.base64}");
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypt.base64), iv: ivObj);
    print("decrypted ${decrypted}");
    return encrypt.base64;

  }

  int getRandomPosition(){
    Random random = new Random();
    int randomNumber = random.nextInt(5);
    return randomNumber;

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