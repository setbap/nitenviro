import 'package:dio/dio.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

void main() async {
  var client = RubbishCollectorsClient(
    interceptor: CustomInterceptors(
      getAccessToken: () async => "aasdasd",
      getRefreshToken: () async => "aasdasd",
      setAccessToken: (String token) async => null,
      setRefreshToken: (String token) async => null,
      onAuthError: () async => print("onAuthError"),
    ),
    options: BaseOptions(
      baseUrl: "http://217.219.165.22:5005",
    ),
  );

  try {
    await client.authSendCode(phone: "09112223344");
  } catch (e) {
    // print(e);
  }
}
