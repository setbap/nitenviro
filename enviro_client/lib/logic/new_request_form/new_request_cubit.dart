import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nitenviro/models/request_model.dart';
import 'package:nitenviro/repo/repo.dart';

class NewRequestCubit extends Cubit<CollectingRequest> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  NewRequestCubit({
    required RubbishCollectorsApi rubbishCollectorsApi,
  })  : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(CollectingRequest());

  void changeBuilding(String selectedBuildingId) {
    emit(state.copyWith(selectedBuildingId: null));
    Future.delayed(
      const Duration(milliseconds: 300),
    ).then((value) {
      emit(state.copyWith(selectedBuildingId: selectedBuildingId));
    });
  }

  void resetBuildings() {
    emit(CollectingRequest());
  }

  void clearIfSelected(String selectedBuildingId) {
    if (state.selectedBuildingId == selectedBuildingId) {
      emit(state.copyWith(selectedBuildingId: null));
    }
  }

  void sendData({
    required VoidCallback onSuccess,
    required FnWithOneParam<String?> onError,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await _rubbishCollectorsApi.createPickUpSpecial(
        buildingId: state.selectedBuildingId!,
        specialWeekDay: state.specialWeekDay,
        specialDescription: state.specialDescription,
        specialImageUrl: state.spectialImage,
      );
      if (response.isSuccess) {
        emit(state.copyWith(isLoading: false));
        onSuccess();
      } else {
        onError(response.errors[0].message ?? "خطا در ایجاد درخواست");
      }
    } catch (e) {
      onError("خطا در ایجاد درخواست");
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void changeDay(int specialWeekDay) {
    emit(state.copyWith(specialWeekDay: specialWeekDay));
  }

  void changeSpectialDescription(String specialDescription) {
    emit(state.copyWith(specialDescription: specialDescription));
  }

  void changeImage(File image) {
    log("set image");
    emit(state.copyWith(spectialImage: image));
    log("set image");
  }
}
