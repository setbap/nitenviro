import 'dart:convert';
import 'dart:developer';


void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();
  static T? Function<T extends Object?>(dynamic value) convert =
      <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class RecyclableItems {
  RecyclableItems({
    required this.id,
    required this.name,
    required this.recyclable,
    required this.description,
    required this.publishedAt,
    required this.category,
    required this.dry,
    this.useCases,
    this.waterFootprint,
    this.carbonFootprint,
    this.carbonFootprintUnit,
    this.waterFootprintUnit,
    required this.image,
  });

  factory RecyclableItems.fromJson(Map<String, dynamic> jsonRes) {
    final List<ApiImage>? image = jsonRes['Image'] is List ? <ApiImage>[] : null;
    if (image != null) {
      for (final dynamic item in jsonRes['Image']!) {
        if (item != null) {
          tryCatch(() {
            image.add(ApiImage.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return RecyclableItems(
      id: asT<int>(jsonRes['id'])!,
      name: asT<String>(jsonRes['Name'])!,
      recyclable: asT<String>(jsonRes['Recyclable'])!,
      description: asT<String>(jsonRes['Description'])!,
      publishedAt: asT<String>(jsonRes['published_at'])!,
      category: asT<String>(jsonRes['Category'])!,
      dry: asT<bool>(jsonRes['Dry'])!,
      useCases: asT<String?>(jsonRes['UseCases']),
      waterFootprint: asT<double?>(jsonRes['WaterFootprint']),
      carbonFootprint: asT<double?>(jsonRes['CarbonFootprint']),
      carbonFootprintUnit: asT<String?>(jsonRes['CarbonFootprintUnit']),
      waterFootprintUnit: asT<String?>(jsonRes['WaterFootprintUnit']),
      image: image!,
    );
  }

  final int id;
  final String name;
  final String recyclable;
  final String description;
  final String publishedAt;
  final String category;

  final bool dry;
  final String? useCases;
  final double? waterFootprint;
  final double? carbonFootprint;
  final String? carbonFootprintUnit;
  final String? waterFootprintUnit;
  final List<ApiImage> image;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'Name': name,
        'Recyclable': recyclable,
        'Description': description,
        'category': category,
        'published_at': publishedAt,
        'Category': category,
        'Dry': dry,
        'UseCases': useCases,
        'WaterFootprint': waterFootprint,
        'CarbonFootprint': carbonFootprint,
        'CarbonFootprintUnit': carbonFootprintUnit,
        'WaterFootprintUnit': waterFootprintUnit,
        'Image': image,
      };

  RecyclableItems clone() => RecyclableItems.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ApiImage {
  ApiImage({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.url,
    this.previewUrl,
  });

  factory ApiImage.fromJson(Map<String, dynamic> jsonRes) => ApiImage(
        id: asT<int>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        width: asT<int>(jsonRes['width'])!,
        height: asT<int>(jsonRes['height'])!,
        formats:
            Formats.fromJson(asT<Map<String, dynamic>>(jsonRes['formats'])!),
        hash: asT<String>(jsonRes['hash'])!,
        url: asT<String>(jsonRes['url'])!,
        previewUrl: asT<Object?>(jsonRes['previewUrl']),
      );

  final int id;
  final String name;
  final int width;
  final int height;
  final Formats formats;
  final String hash;

  final String url;
  final Object? previewUrl;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'width': width,
        'height': height,
        'formats': formats,
        'hash': hash,
        'url': url,
        'previewUrl': previewUrl,
      };

  ApiImage clone() =>
      ApiImage.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Formats {
  Formats({
    this.small,
    this.medium,
    required this.thumbnail,
  });

  factory Formats.fromJson(Map<String, dynamic> jsonRes) => Formats(
        small: jsonRes['small'] != null
            ? ImageResault.fromJson(
                asT<Map<String, dynamic>>(jsonRes['small'])!)
            : null,
        medium: jsonRes['medium'] != null
            ? ImageResault.fromJson(
                asT<Map<String, dynamic>>(jsonRes['medium'])!)
            : null,
        thumbnail: ImageResault.fromJson(
            asT<Map<String, dynamic>>(jsonRes['thumbnail'])!),
      );

  final ImageResault? small;
  final ImageResault? medium;
  final ImageResault thumbnail;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'small': small,
        'medium': medium,
        'thumbnail': thumbnail,
      };

  Formats clone() => Formats.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class ImageResault {
  ImageResault({
    required this.url,
    required this.hash,
    required this.name,
  });

  factory ImageResault.fromJson(Map<String, dynamic> jsonRes) => ImageResault(
        url: asT<String>(jsonRes['url'])!,
        hash: asT<String>(jsonRes['hash'])!,
        name: asT<String>(jsonRes['name'])!,
      );

  final String url;
  final String hash;
  final String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'url': url,
        'hash': hash,
        'name': name,
      };

  ImageResault clone() => ImageResault.fromJson(
      asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
