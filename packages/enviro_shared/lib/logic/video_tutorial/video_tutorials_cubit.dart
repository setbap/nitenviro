import 'package:bloc/bloc.dart';
import 'package:enviro_shared/logic/generic_api_state.dart';
import 'package:enviro_shared/repo/public_enviro_repo.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

class VideoTutorialsCubit extends Cubit<GenericApiState<List<PostModel>>> {
  final PublicNitEnviroApi _publicNitEnviroApi;
  VideoTutorialsCubit({required PublicNitEnviroApi publicNitEnviroApi})
      : _publicNitEnviroApi = publicNitEnviroApi,
        super(
          const GenericApiState<List<PostModel>>(
            error: "",
            isLoading: true,
          ),
        );

  getAllTutorials() async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    await _publicNitEnviroApi.getAllTutorials().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
