import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_tracker/main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List currencies;
  const HomePage({Key? key, required this.currencies}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies = [];
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() async {
    super.initState();
    currencies = await getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Tracker"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: widget.currencies.length,
          itemBuilder: (BuildContext context, int index) {
            final Map currency = widget.currencies[index];
            final MaterialColor color = _colors[index % _colors.length];
            return _getListItemUi(currency, color);
          },
        ),
      ),
    );
  }

  Widget _getListItemUi(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name']),
      ),
      title:
          Text(currency['name'], style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(currency['current_price'],
          currency['market_cap_change_percentage_24h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String price, String change) {
    TextSpan priceTextWidget =
        TextSpan(text: "\$$price\n", style: TextStyle(color: Colors.black));
    String changetext = "24 hour: $change%";
    TextSpan changeWidget;

    if (double.parse(change) > 0) {
      changeWidget =
          TextSpan(text: changetext, style: TextStyle(color: Colors.green));
    } else {
      changeWidget =
          TextSpan(text: changetext, style: TextStyle(color: Colors.red));
    }

    return RichText(text: TextSpan(children: [priceTextWidget, changeWidget]));
  }
}
