import 'package:bloc/bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/repo/public_enviro_repo.dart';

class VideoTutorialsCubit extends Cubit<GenericApiState<List<TutorialItem>>> {
  final PublicNitEnviroApi _publicNitEnviroApi;
  VideoTutorialsCubit({required PublicNitEnviroApi publicNitEnviroApi})
      : _publicNitEnviroApi = publicNitEnviroApi,
        super(
          const GenericApiState<List<TutorialItem>>(
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
    _publicNitEnviroApi.getAllTutorials().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
