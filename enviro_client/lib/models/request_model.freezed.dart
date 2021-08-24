// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CollectingRequestTearOff {
  const _$CollectingRequestTearOff();

  _CollectingRequest call(
      {String specialDescription = "",
      String? selectedBuildingId,
      int specialWeekDay = 0,
      bool isLoading = false,
      File? spectialImage}) {
    return _CollectingRequest(
      specialDescription: specialDescription,
      selectedBuildingId: selectedBuildingId,
      specialWeekDay: specialWeekDay,
      isLoading: isLoading,
      spectialImage: spectialImage,
    );
  }
}

/// @nodoc
const $CollectingRequest = _$CollectingRequestTearOff();

/// @nodoc
mixin _$CollectingRequest {
  String get specialDescription => throw _privateConstructorUsedError;
  String? get selectedBuildingId => throw _privateConstructorUsedError;
  int get specialWeekDay => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  File? get spectialImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectingRequestCopyWith<CollectingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectingRequestCopyWith<$Res> {
  factory $CollectingRequestCopyWith(
          CollectingRequest value, $Res Function(CollectingRequest) then) =
      _$CollectingRequestCopyWithImpl<$Res>;
  $Res call(
      {String specialDescription,
      String? selectedBuildingId,
      int specialWeekDay,
      bool isLoading,
      File? spectialImage});
}

/// @nodoc
class _$CollectingRequestCopyWithImpl<$Res>
    implements $CollectingRequestCopyWith<$Res> {
  _$CollectingRequestCopyWithImpl(this._value, this._then);

  final CollectingRequest _value;
  // ignore: unused_field
  final $Res Function(CollectingRequest) _then;

  @override
  $Res call({
    Object? specialDescription = freezed,
    Object? selectedBuildingId = freezed,
    Object? specialWeekDay = freezed,
    Object? isLoading = freezed,
    Object? spectialImage = freezed,
  }) {
    return _then(_value.copyWith(
      specialDescription: specialDescription == freezed
          ? _value.specialDescription
          : specialDescription // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBuildingId: selectedBuildingId == freezed
          ? _value.selectedBuildingId
          : selectedBuildingId // ignore: cast_nullable_to_non_nullable
              as String?,
      specialWeekDay: specialWeekDay == freezed
          ? _value.specialWeekDay
          : specialWeekDay // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      spectialImage: spectialImage == freezed
          ? _value.spectialImage
          : spectialImage // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc
abstract class _$CollectingRequestCopyWith<$Res>
    implements $CollectingRequestCopyWith<$Res> {
  factory _$CollectingRequestCopyWith(
          _CollectingRequest value, $Res Function(_CollectingRequest) then) =
      __$CollectingRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String specialDescription,
      String? selectedBuildingId,
      int specialWeekDay,
      bool isLoading,
      File? spectialImage});
}

/// @nodoc
class __$CollectingRequestCopyWithImpl<$Res>
    extends _$CollectingRequestCopyWithImpl<$Res>
    implements _$CollectingRequestCopyWith<$Res> {
  __$CollectingRequestCopyWithImpl(
      _CollectingRequest _value, $Res Function(_CollectingRequest) _then)
      : super(_value, (v) => _then(v as _CollectingRequest));

  @override
  _CollectingRequest get _value => super._value as _CollectingRequest;

  @override
  $Res call({
    Object? specialDescription = freezed,
    Object? selectedBuildingId = freezed,
    Object? specialWeekDay = freezed,
    Object? isLoading = freezed,
    Object? spectialImage = freezed,
  }) {
    return _then(_CollectingRequest(
      specialDescription: specialDescription == freezed
          ? _value.specialDescription
          : specialDescription // ignore: cast_nullable_to_non_nullable
              as String,
      selectedBuildingId: selectedBuildingId == freezed
          ? _value.selectedBuildingId
          : selectedBuildingId // ignore: cast_nullable_to_non_nullable
              as String?,
      specialWeekDay: specialWeekDay == freezed
          ? _value.specialWeekDay
          : specialWeekDay // ignore: cast_nullable_to_non_nullable
              as int,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      spectialImage: spectialImage == freezed
          ? _value.spectialImage
          : spectialImage // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$_CollectingRequest implements _CollectingRequest {
  _$_CollectingRequest(
      {this.specialDescription = "",
      this.selectedBuildingId,
      this.specialWeekDay = 0,
      this.isLoading = false,
      this.spectialImage});

  @JsonKey(defaultValue: "")
  @override
  final String specialDescription;
  @override
  final String? selectedBuildingId;
  @JsonKey(defaultValue: 0)
  @override
  final int specialWeekDay;
  @JsonKey(defaultValue: false)
  @override
  final bool isLoading;
  @override
  final File? spectialImage;

  @override
  String toString() {
    return 'CollectingRequest(specialDescription: $specialDescription, selectedBuildingId: $selectedBuildingId, specialWeekDay: $specialWeekDay, isLoading: $isLoading, spectialImage: $spectialImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CollectingRequest &&
            (identical(other.specialDescription, specialDescription) ||
                const DeepCollectionEquality()
                    .equals(other.specialDescription, specialDescription)) &&
            (identical(other.selectedBuildingId, selectedBuildingId) ||
                const DeepCollectionEquality()
                    .equals(other.selectedBuildingId, selectedBuildingId)) &&
            (identical(other.specialWeekDay, specialWeekDay) ||
                const DeepCollectionEquality()
                    .equals(other.specialWeekDay, specialWeekDay)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.spectialImage, spectialImage) ||
                const DeepCollectionEquality()
                    .equals(other.spectialImage, spectialImage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(specialDescription) ^
      const DeepCollectionEquality().hash(selectedBuildingId) ^
      const DeepCollectionEquality().hash(specialWeekDay) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(spectialImage);

  @JsonKey(ignore: true)
  @override
  _$CollectingRequestCopyWith<_CollectingRequest> get copyWith =>
      __$CollectingRequestCopyWithImpl<_CollectingRequest>(this, _$identity);
}

abstract class _CollectingRequest implements CollectingRequest {
  factory _CollectingRequest(
      {String specialDescription,
      String? selectedBuildingId,
      int specialWeekDay,
      bool isLoading,
      File? spectialImage}) = _$_CollectingRequest;

  @override
  String get specialDescription => throw _privateConstructorUsedError;
  @override
  String? get selectedBuildingId => throw _privateConstructorUsedError;
  @override
  int get specialWeekDay => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  File? get spectialImage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CollectingRequestCopyWith<_CollectingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
