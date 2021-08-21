import 'package:dio/dio.dart';

import 'package:public_nitenviro/public_nitenviro.dart';
import 'package:public_nitenviro/src/models/post_model.dart';

class PublicNitenviroClient {
  final Dio dio;
  PublicNitenviroClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl(),
          ),
        );

  // Map<String, dynamic> _mapCleaner(Map<String, dynamic> map) {
  //   map.removeWhere((key, value) => value == null);
  //   return map;
  // }

  Future<dynamic> _genericGet({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final pingData = await dio.get(
        path,
        queryParameters: queryParameters,
      );
      print(pingData);
      if (pingData.statusCode == 200) {
        print("object - n");
        print(pingData.data);
        return pingData.data;
      } else {
        print("object - n");
        print(pingData.data);
        throw ServerException();
      }
    } catch (e) {
      print("object");
      print(e);
      throw InternetConnetionException();
    }
  }

//
  Future<List<RecyclableItems>> items() async {
    final rawItems = await _genericGet(
      path: Endpoints.items(),
      queryParameters: {"_limit": 500},
    );
    var my_item = <RecyclableItems>[];
    for (var element in rawItems) {
      final simplePrice = RecyclableItems.fromJson(element);
      my_item.add(simplePrice);
    }
    return my_item;
  }

  Future<List<PostModel>> posts() async {
    final rawItems = await _genericGet(
      path: Endpoints.posts(),
      queryParameters: {"_limit": 500},
    );
    var my_item = <PostModel>[];
    for (var element in rawItems) {
      final simplePrice = PostModel.fromJson(element);
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
