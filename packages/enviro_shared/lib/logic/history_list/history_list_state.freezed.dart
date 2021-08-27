// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'history_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HistoryListStateTearOff {
  const _$HistoryListStateTearOff();

  _HistoryListState call(
      {List<SpacialRequest> historyItems = const [],
      bool isLoading = true,
      String? error,
      bool hasError = false,
      int day = 1}) {
    return _HistoryListState(
      historyItems: historyItems,
      isLoading: isLoading,
      error: error,
      hasError: hasError,
      day: day,
    );
  }
}

/// @nodoc
const $HistoryListState = _$HistoryListStateTearOff();

/// @nodoc
mixin _$HistoryListState {
  List<SpacialRequest> get historyItems => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HistoryListStateCopyWith<HistoryListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryListStateCopyWith<$Res> {
  factory $HistoryListStateCopyWith(
          HistoryListState value, $Res Function(HistoryListState) then) =
      _$HistoryListStateCopyWithImpl<$Res>;
  $Res call(
      {List<SpacialRequest> historyItems,
      bool isLoading,
      String? error,
      bool hasError,
      int day});
}

/// @nodoc
class _$HistoryListStateCopyWithImpl<$Res>
    implements $HistoryListStateCopyWith<$Res> {
  _$HistoryListStateCopyWithImpl(this._value, this._then);

  final HistoryListState _value;
  // ignore: unused_field
  final $Res Function(HistoryListState) _then;

  @override
  $Res call({
    Object? historyItems = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? hasError = freezed,
    Object? day = freezed,
  }) {
    return _then(_value.copyWith(
      historyItems: historyItems == freezed
          ? _value.historyItems
          : historyItems // ignore: cast_nullable_to_non_nullable
              as List<SpacialRequest>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$HistoryListStateCopyWith<$Res>
    implements $HistoryListStateCopyWith<$Res> {
  factory _$HistoryListStateCopyWith(
          _HistoryListState value, $Res Function(_HistoryListState) then) =
      __$HistoryListStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<SpacialRequest> historyItems,
      bool isLoading,
      String? error,
      bool hasError,
      int day});
}

/// @nodoc
class __$HistoryListStateCopyWithImpl<$Res>
    extends _$HistoryListStateCopyWithImpl<$Res>
    implements _$HistoryListStateCopyWith<$Res> {
  __$HistoryListStateCopyWithImpl(
      _HistoryListState _value, $Res Function(_HistoryListState) _then)
      : super(_value, (v) => _then(v as _HistoryListState));

  @override
  _HistoryListState get _value => super._value as _HistoryListState;

  @override
  $Res call({
    Object? historyItems = freezed,
    Object? isLoading = freezed,
    Object? error = freezed,
    Object? hasError = freezed,
    Object? day = freezed,
  }) {
    return _then(_HistoryListState(
      historyItems: historyItems == freezed
          ? _value.historyItems
          : historyItems // ignore: cast_nullable_to_non_nullable
              as List<SpacialRequest>,
      isLoading: isLoading == freezed
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      hasError: hasError == freezed
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_HistoryListState implements _HistoryListState {
  _$_HistoryListState(
      {this.historyItems = const [],
      this.isLoading = true,
      this.error,
      this.hasError = false,
      this.day = 1});

  @JsonKey(defaultValue: const [])
  @override
  final List<SpacialRequest> historyItems;
  @JsonKey(defaultValue: true)
  @override
  final bool isLoading;
  @override
  final String? error;
  @JsonKey(defaultValue: false)
  @override
  final bool hasError;
  @JsonKey(defaultValue: 1)
  @override
  final int day;

  @override
  String toString() {
    return 'HistoryListState(historyItems: $historyItems, isLoading: $isLoading, error: $error, hasError: $hasError, day: $day)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _HistoryListState &&
            (identical(other.historyItems, historyItems) ||
                const DeepCollectionEquality()
                    .equals(other.historyItems, historyItems)) &&
            (identical(other.isLoading, isLoading) ||
                const DeepCollectionEquality()
                    .equals(other.isLoading, isLoading)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.hasError, hasError) ||
                const DeepCollectionEquality()
                    .equals(other.hasError, hasError)) &&
            (identical(other.day, day) ||
                const DeepCollectionEquality().equals(other.day, day)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(historyItems) ^
      const DeepCollectionEquality().hash(isLoading) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(hasError) ^
      const DeepCollectionEquality().hash(day);

  @JsonKey(ignore: true)
  @override
  _$HistoryListStateCopyWith<_HistoryListState> get copyWith =>
      __$HistoryListStateCopyWithImpl<_HistoryListState>(this, _$identity);
}

abstract class _HistoryListState implements HistoryListState {
  factory _HistoryListState(
      {List<SpacialRequest> historyItems,
      bool isLoading,
      String? error,
      bool hasError,
      int day}) = _$_HistoryListState;

  @override
  List<SpacialRequest> get historyItems => throw _privateConstructorUsedError;
  @override
  bool get isLoading => throw _privateConstructorUsedError;
  @override
  String? get error => throw _privateConstructorUsedError;
  @override
  bool get hasError => throw _privateConstructorUsedError;
  @override
  int get day => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$HistoryListStateCopyWith<_HistoryListState> get copyWith =>
      throw _privateConstructorUsedError;
}
