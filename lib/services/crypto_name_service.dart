import 'dart:math';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';

class CryptoNameService {
  String encryptName(String input, String inputExtension, String userId) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HHmmss').format(now);
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    final cryptoName = digest.toString();
    final name = cryptoName.substring(0, 16);
    final random = Random();
    final randomNumber = random.nextInt(10000);
    String result = '$userId-$name-$randomNumber-$formattedTime$inputExtension';
    return result;
  }
}
