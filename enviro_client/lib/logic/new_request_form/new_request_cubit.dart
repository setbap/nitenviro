import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nitenviro/models/request_model.dart';

class NewRequestCubit extends Cubit<CollectingRequest> {
  NewRequestCubit() : super(CollectingRequest());

  void changeBuilding(String selectedBuildingId) {
    emit(state.copyWith(selectedBuildingId: null));
    Future.delayed(
      const Duration(milliseconds: 300),
    ).then((value) {
      emit(state.copyWith(selectedBuildingId: selectedBuildingId));
    });
  }

  void clearIfSelected(String selectedBuildingId) {
    if (state.selectedBuildingId == selectedBuildingId) {
      emit(state.copyWith(selectedBuildingId: null));
    }
  }

  void sendData(VoidCallback onSubmited) {
    emit(state.copyWith(isLoading: true));
    Future.delayed(
      const Duration(milliseconds: 300),
    ).then((value) {
      emit(state.copyWith(isLoading: false));
    });
  }

  void changeDay(int specialWeekDay) {
    emit(state.copyWith(specialWeekDay: specialWeekDay));
  }

  void changeSpectialDescription(String specialDescription) {
    emit(state.copyWith(specialDescription: specialDescription));
  }

  void changeImage(File image) {
    emit(state.copyWith(spectialImage: image));
  }
}
