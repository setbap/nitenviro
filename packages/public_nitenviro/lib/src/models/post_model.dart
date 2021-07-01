import 'dart:convert';
import 'models.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.poster,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonRes) {
    return PostModel(
      id: asT<int>(jsonRes['id'])!,
      title: asT<String>(jsonRes['Title'])!,
      description: asT<String>(jsonRes['Description'])!,
      videoUrl: asT<String>(jsonRes['Video']['url'])!,
      poster: ApiImage.fromJson(asT<Map<String, dynamic>>(jsonRes['Poster'])!),
    );
  }

  final int id;
  final String title;

  final String description;
  final String videoUrl;
  final ApiImage poster;

  @override
  String toString() {
    return jsonEncode(this);
  }

  PostModel clone() => PostModel.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
