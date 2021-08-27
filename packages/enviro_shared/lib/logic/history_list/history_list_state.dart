import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
part 'history_list_state.freezed.dart';

@freezed
class HistoryListState with _$HistoryListState {
  factory HistoryListState({
    @Default([]) List<SpacialRequest> historyItems,
    @Default(true) bool isLoading,
    String? error,
    @Default(false) bool hasError,
    @Default(1) int day,
  }) = _HistoryListState;
}
