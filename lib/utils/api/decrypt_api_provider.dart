import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderAPI extends ChangeNotifier {
  bool? isLoaded;
  bool? isAuthenticated;

  Map<String, String?>? body;

  Future<bool> decryptAndAuthenticate(
      String orderId, String cipher, String key) async {
    isLoaded = false;
    isAuthenticated = false;
    body = {'orderID': orderId, 'encryptedData': cipher, 'key': key};
    var response = await http.post(
        Uri.parse("https://qrcryption.onrender.com/api/verify"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      isAuthenticated = true;
      isLoaded = true;
      notifyListeners();
      return true;
    } else {
      isLoaded = true;
      isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }
}
