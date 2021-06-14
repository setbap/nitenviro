abstract class publicNitenviroException implements Exception {
  String get message;
}

class InternetConnetionException implements publicNitenviroException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}

class BadRequestException implements publicNitenviroException {
  final String text;

  BadRequestException(this.text);
  @override
  String get message => 'bad request,$text';
}

class ServerException implements publicNitenviroException {
  @override
  String get message => 'problem with yout connection to CoinGecko';
}
