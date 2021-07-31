import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:nitenviro/models/request_model.dart';

class NewRequestCubit extends Cubit<CollectingRequest> {
  NewRequestCubit() : super(CollectingRequest());

  void changeComment(String comment) {
    emit(state.copyWith(comment: comment));
  }

  void changeBuilding(int selectedBuilding) {
    emit(state.copyWith(selectedBuilding: selectedBuilding));
  }

  void changeTime(String requestedTime) {
    emit(state.copyWith(requestedTime: requestedTime));
  }

  void changeReminer(int selectedReminder) {
    emit(state.copyWith(selectedReminder: selectedReminder));
  }

  void changeIsSpectial() {
    emit(state.copyWith(isSpectial: !state.isSpectial));
  }

  void changeSpectialComment(String comment) {
    emit(state.copyWith(commentOnSpecial: comment));
  }

  void changeImage(File image) {
    emit(state.copyWith(spectialImage: image));
  }
}
