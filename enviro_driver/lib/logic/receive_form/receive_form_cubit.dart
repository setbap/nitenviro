import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:meta/meta.dart';
import 'package:enviro_driver/models/models.dart';

part 'receive_form_state.dart';

class ReceiveFormCubit extends Cubit<ReceiveFormState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  ReceiveFormCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(ReceiveFormInitial());

  void changeGlass(double? glass) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(glass: glass),
      ),
    );
  }

  void submitRecord(String id) async {
    emit(ReceiveFormLoading(receiveFromModel: state.receiveFromModel));
    final info = state.receiveFromModel;
    if (info.metal == null &&
        info.glass == null &&
        info.mixed == null &&
        info.paper == null &&
        info.plastic == null) {
      emit(
        ReceiveFormError(
          receiveFromModel: state.receiveFromModel,
          message:
              "وارد کردن یکی از موارد مخلوط, شیشه, فلز, کاغذ یا پلاستیک ضروریست.",
        ),
      );
      return;
    }
    try {
      final response = await _rubbishCollectorsApi.receiveRequest(
        id: id,
        driverDescription: info.desc,
        glassWeight: info.glass,
        metalWeight: info.metal,
        mixedWeight: info.mixed,
        paperWeight: info.paper,
        plasticWeight: info.plastic,
        image: info.spectialImage,
      );
      if (response.isSuccess) {
        emit(ReceiveFormSuccess(receiveFromModel: state.receiveFromModel));
      } else {
        emit(
          ReceiveFormError(
              receiveFromModel: state.receiveFromModel,
              message: response.errors[0].message ?? ""),
        );
      }
    } catch (e) {
      emit(
        ReceiveFormError(
          receiveFromModel: state.receiveFromModel,
          message: "خطا در ارسال یا ثبت",
        ),
      );
    }
  }

  void changeMetal(double? metal) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(metal: metal),
      ),
    );
  }

  void changePaper(double? paper) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(paper: paper),
      ),
    );
  }

  void changePlastic(double? plastic) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(plastic: plastic),
      ),
    );
  }

  void changeMix(double? mixed) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(mixed: mixed),
      ),
    );
  }

  void changeImage(File? image) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(spectialImage: image),
      ),
    );
  }

  void changeDesc(String? desc) {
    emit(
      ReceiveFormChanging(
        receiveFromModel: state.receiveFromModel.copyWith(desc: desc),
      ),
    );
  }
}
