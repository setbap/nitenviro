import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'receive_from_model.freezed.dart';

@freezed
class ReceiveFromModel with _$ReceiveFromModel {
  factory ReceiveFromModel({
    double? glass,
    double? metal,
    double? paper,
    double? mixed,
    double? plastic,
    File? spectialImage,
    String? desc,
  }) = _ReceiveFromModel;
}
