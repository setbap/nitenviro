import 'package:bloc/bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

class RecyclableDetectorCubit
    extends Cubit<GenericApiState<List<RecyclableItems>>> {
  final PublicNitEnviroApi _publicNitEnviroApi;
  RecyclableDetectorCubit({required PublicNitEnviroApi publicNitEnviroApi})
      : _publicNitEnviroApi = publicNitEnviroApi,
        super(
          const GenericApiState<List<RecyclableItems>>(
            error: "",
            isLoading: true,
          ),
        );

  getAllItems() async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _publicNitEnviroApi.getAllItems().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
