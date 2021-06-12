import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';

@freezed
class CollectingRequest with _$CollectingRequest {
  factory CollectingRequest({
    @Default("") String comment,
    @Default(0) int selectedBuilding,
    @Default(0) int selectedReminder,
    @Default("1400/04/04") String requestedTime,
    @Default("") String commentOnSpecial,
    File? spectialImage,
    @Default(false) bool isSpectial,
  }) = _CollectingRequest;
}