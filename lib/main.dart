import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  List currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies:currencies));
}

class MyApp extends StatelessWidget {
  final List currencies;
  const MyApp({Key? key, required this.currencies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: HomePage(currencies:currencies),
    );
  }
}

Future<List> getCurrencies() async {
  String url =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
  var response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}
