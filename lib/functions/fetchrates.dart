
import 'package:http/http.dart' as http;
import '../models/allcurrencies.dart';
import '../models/ratesmodel.dart';
import '../utils/key.dart';


Future<RatesModel> fetchrates() async{
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id='+key
  ));
  final result = rateModelFormJson(response.body);
  return result;
}



Future<Map> fetchcurrencis() async{
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id='+key
  ));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}



















String convertusd( Map exchanheRates , String usd , String currency){
  String output =
  ((exchanheRates[currency] * double.parse(usd)).toStringAsFixed(2)).toString();
  return output;
}

String convertany(Map exchangeRates , String  amount , String currnecybase,String currencyfinal){
  String output= (double.parse(amount) /
              exchangeRates[currnecybase]*
              exchangeRates[currencyfinal])
    .toStringAsFixed(2)
    .toString();
  return output;
}


















