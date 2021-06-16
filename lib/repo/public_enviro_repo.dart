import 'package:public_nitenviro/public_nitenviro.dart';

class PublicNitEnviroApi {
  final PublicNitenviroClient _nitenviroClient;

  const PublicNitEnviroApi({required PublicNitenviroClient nitenviroClient})
      : _nitenviroClient = nitenviroClient;

  Future<List<RecyclableItems>> getAllItems() async {
    final items = await _nitenviroClient.items();
    return items;
  }

  Future<List<TutorialItem>> getAllTutorials() async {
    final items = await _nitenviroClient.items();
    final tuts = items.map((e) => TutorialItem(
          name: "آموزش بازیافت" + e.name,
          image: e.image[0].url,
          videoLink:
              "https://www.aparat.com/video/video/embed/videohash/BtvlS/vt/frame",
          description: e.description,
        ));
    return tuts.toList();
  }
}

class TutorialItem {
  final String name;
  final String image;
  final String videoLink;
  final String description;

  TutorialItem({
    required this.name,
    required this.image,
    required this.videoLink,
    required this.description,
  });
}
