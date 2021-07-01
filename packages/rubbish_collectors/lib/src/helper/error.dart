abstract class RubbishCollectorsException implements Exception {
  String get message;
}

class InternetConnetionException implements RubbishCollectorsException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}

class BadRequestException implements RubbishCollectorsException {
  final String text;

  BadRequestException(this.text);
  @override
  String get message => 'bad request,$text';
}

class ServerException implements RubbishCollectorsException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}
