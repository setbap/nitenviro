import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_model.freezed.dart';

@freezed
class CollectingRequest with _$CollectingRequest {
  factory CollectingRequest({
    @Default("") String specialDescription,
    String? selectedBuildingId,
    @Default(0) int specialWeekDay,
    @Default(false) bool isLoading,
    File? spectialImage,
  }) = _CollectingRequest;
}
