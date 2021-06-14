import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:public_nitenviro/public_nitenviro.dart';

class PublicNitenviroClient {
  final _client = http.Client();
  final _host = 'geonitenviro.nit.ac.ir';
  Uri _uri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) =>
      Uri(
        scheme: 'https',
        host: _host,
        path: '/api$path',
        queryParameters: queryParameters,
      );

  // Map<String, dynamic> _mapCleaner(Map<String, dynamic> map) {
  //   map.removeWhere((key, value) => value == null);
  //   return map;
  // }

  Future<dynamic> _genericGet({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    print(_uri(
      path: path,
      queryParameters: queryParameters,
    ).toString());
    try {
      final pingData = await _client.get(_uri(
        path: path,
        queryParameters: queryParameters,
      ));
      if (pingData.statusCode == 200) {
        return jsonDecode(pingData.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e);
      throw InternetConnetionException();
    }
  }

//
  Future<List<RecyclableItems>> items() async {
    final rawItems = await _genericGet(path: Endpoints.items());
    var my_item = <RecyclableItems>[];
    for (var element in rawItems) {
      final simplePrice = RecyclableItems.fromJson(element);
      my_item.add(simplePrice);
    }
    return my_item;
  }

  // Future<Map<String, SimplePrice>> simpleMultiCoinPrice({
  //   required String currency,
  //   required List<String> tokensId,
  //   bool? includeMarketCap,
  //   bool? include24hrVol,
  //   bool? include24hrChange,
  // }) async {
  //   final qs = _mapCleaner({
  //     'ids': tokensId.join(','),
  //     'vs_currencies': currency,
  //     'include_market_cap': includeMarketCap.toString(),
  //     'include_24hr_vol': include24hrVol.toString(),
  //     'include_24hr_change': include24hrChange.toString(),
  //     'include_last_updated_at': 'true',
  //   });
  //   final simplePriceMap = await _genericGet(
  //     path: Endpoints.simplePrice(),
  //     queryParameters: qs,
  //   );

  //   var prices = <String, SimplePrice>{};
  //   for (var element in tokensId) {
  //     if (simplePriceMap.containsKey(element)) {
  //       simplePriceMap[element]['currency'] = currency;
  //       final simplePrice = SimplePrice.fromMap(simplePriceMap[element]);
  //       prices[element] = simplePrice;
  //     }
  //   }
  //   return prices;
  // }

}
