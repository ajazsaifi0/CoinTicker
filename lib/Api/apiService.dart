import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'apikey.dart';
import 'package:currency_convertor/coin_data.dart';
class CryptoPrice {

 Future<List<dynamic>> getBitcoinPrice( String currency) async
  {
    List<dynamic> responseList=[];
    for(String crypto in cryptoList) {
      var url = "https://rest.coinapi.io/v1/exchangerate/$crypto/$currency";
      var response = await http.get(url, headers: {"X-CoinAPI-Key": apikey});
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        print(jsonResponse);
        responseList.add(jsonResponse);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    print(responseList);
    return responseList;

  }
}