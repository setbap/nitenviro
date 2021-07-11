import 'package:bloc/bloc.dart';
import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/repo/repo.dart';
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
    await _publicNitEnviroApi.getAllItems().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
