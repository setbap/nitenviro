import 'dart:convert';
import 'dart:developer';

typedef ConverterToJson<T> = T Function(dynamic data);

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
  static get convert => <T>(dynamic value) {
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

class GenericResult<T> {
  GenericResult({
    this.value,
    required this.isFailed,
    required this.isSuccess,
    required this.errors,
    required this.successes,
  });

  factory GenericResult.fromJson(
      Map<String, dynamic> jsonRes, ConverterToJson<T> converterToJson) {
    final List<Errors>? errors = jsonRes['errors'] is List ? <Errors>[] : null;
    if (errors != null) {
      for (final dynamic item in jsonRes['errors']!) {
        if (item != null) {
          tryCatch(() {
            errors.add(Errors.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    final List<Successes>? successes =
        jsonRes['successes'] is List ? <Successes>[] : null;
    if (successes != null) {
      for (final dynamic item in jsonRes['successes']!) {
        if (item != null) {
          tryCatch(() {
            successes.add(Successes.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }

    return GenericResult(
      value: jsonRes['value'] == null
          ? null
          : converterToJson(
              asT<Map<String, dynamic>>(jsonRes['value'])!,
            ),
      isFailed: asT<bool>(jsonRes['isFailed'])!,
      isSuccess: asT<bool>(jsonRes['isSuccess'])!,
      errors: errors!,
      successes: successes!,
    );
  }

  final T? value;
  final bool isFailed;
  final bool isSuccess;
  final List<Errors> errors;
  final List<Successes> successes;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'value': value,
        'isFailed': isFailed,
        'isSuccess': isSuccess,
        'errors': errors,
        'successes': successes,
      };
}

class Errors {
  Errors({
    this.message,
  });

  factory Errors.fromJson(Map<String, dynamic> jsonRes) => Errors(
        message: asT<String?>(jsonRes['message']),
      );

  final String? message;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
      };

  Errors clone() =>
      Errors.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Successes {
  Successes({
    this.message,
  });

  factory Successes.fromJson(Map<String, dynamic> jsonRes) => Successes(
        message: asT<String?>(jsonRes['message']),
      );

  final String? message;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
      };

  // Successes clone() => Successes.fromJson(
  //     asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
