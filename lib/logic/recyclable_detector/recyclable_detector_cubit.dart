import 'package:bloc/bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/repo/public_enviro_repo.dart';
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
    print("start");
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _publicNitEnviroApi.getAllItems().then((value) {
      print("downloaded");
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      print("show");
      emit(state.copyWith(isLoading: false));
    });
  }
}
