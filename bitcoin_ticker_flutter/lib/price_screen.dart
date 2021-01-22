import 'package:bitcoin_ticker_flutter/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  String btcRate = '?';
  String ltcRate = '?';
  String ethRate = '?';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      dropdownItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: currency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          currency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) =>
          {currency = currenciesList[selectedIndex]},
      children: pickerItems,
    );
  }

  void getData() async {
    Map<String, String> data = await CoinData().getCoinData(currency);
    print(data);
    if (data != null) {
      setState(() {
        btcRate = data['BTC'];
        ltcRate = data['LTC'];
        ethRate = data['ETH'];
      });
    } else{
      setState(() {
        btcRate = '?';
        ltcRate = '?';
        ethRate = '?';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CoinCard(rate: btcRate, currency: currency, crypto: 'BTC'),
                CoinCard(rate: ethRate, currency: currency, crypto: 'ETH'),
                CoinCard(rate: ltcRate, currency: currency, crypto: 'LTC'),
              ],
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iosPicker() : androidDropdown()),
        ],
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  const CoinCard({
    Key key,
    @required this.rate,
    @required this.currency,
    @required this.crypto,
  }) : super(key: key);

  final String rate;
  final String currency;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $rate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
