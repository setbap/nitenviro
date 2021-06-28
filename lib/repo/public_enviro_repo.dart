import 'package:public_nitenviro/public_nitenviro.dart';

class PublicNitEnviroApi {
  final PublicNitenviroClient _nitenviroClient;

  const PublicNitEnviroApi({required PublicNitenviroClient nitenviroClient})
      : _nitenviroClient = nitenviroClient;

  Future<List<RecyclableItems>> getAllItems() async {
    final items = await _nitenviroClient.items();
    return items;
  }

  Future<List<PostModel>> getAllTutorials() async {
    final posts = await _nitenviroClient.posts();
    return posts;
  }
}
