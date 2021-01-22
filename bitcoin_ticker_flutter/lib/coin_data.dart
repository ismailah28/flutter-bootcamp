import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

String apiKey = env['apiKey']; //'AAFA526F-9493-4FBD-9EAC-48AB4B7E16BA';
// AAFA526F-9493-4FBD-9EAC-48AB4B7E16BA
class CoinData {
    Future<Map<String, String>> getCoinData(String currency) async {
    Map<String, String> cryptoCurrency = {};

    for(String crypto in cryptoList) {
      String url = 'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey';
      print(url);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        double rate = convert.jsonDecode(response.body)['rate'];
        cryptoCurrency[crypto] = rate.toStringAsFixed(2);
      } else {
        print('Request failed with status: ${response.statusCode}.');
        throw 'Something went wrong';
      }
    }
    print(cryptoCurrency);
    return cryptoCurrency;
  }
}
