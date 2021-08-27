import 'package:bloc/bloc.dart';
import 'package:enviro_shared/enviro_shared.dart';
import './history_list_state.dart';
export './history_list_state.dart';

class HistoryListCubit extends Cubit<HistoryListState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  final bool isDriver;

  HistoryListCubit({
    required RubbishCollectorsApi rubbishCollectorsApi,
    required this.isDriver,
  })  : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(HistoryListState(isLoading: true, day: 1));

  Future<void> showHistoryList({int? days}) async {
    emit(HistoryListState(
        isLoading: true, hasError: false, day: days ?? state.day));

    try {
      final acceptedRequest = await _rubbishCollectorsApi.getHistoryWithDay(
        days: state.day,
        isDriver: isDriver,
      );
      if (acceptedRequest.isSuccess) {
        emit(
          state.copyWith(
            isLoading: false,
            historyItems: acceptedRequest.value!,
          ),
        );
      } else {
        // agar error dar dataye bargashti bashad
        emit(
          state.copyWith(
            hasError: true,
            error: acceptedRequest.errors[0].message,
          ),
        );
      }
    } catch (e) {
      // agar error dar hengam ijad darkhast etefaq bioftad
      emit(
        state.copyWith(
          hasError: false,
          error: "مشکل در برقراری ارتباط با سرور",
        ),
      );
    }
  }
}
