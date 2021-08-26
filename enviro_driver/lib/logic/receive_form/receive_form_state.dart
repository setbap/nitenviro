part of 'receive_form_cubit.dart';

@immutable
abstract class ReceiveFormState {
  final ReceiveFromModel receiveFromModel;

  const ReceiveFormState({required this.receiveFromModel});
}

class ReceiveFormInitial extends ReceiveFormState {
  ReceiveFormInitial() : super(receiveFromModel: ReceiveFromModel());
}

class ReceiveFormLoading extends ReceiveFormState {
  const ReceiveFormLoading({required ReceiveFromModel receiveFromModel})
      : super(receiveFromModel: receiveFromModel);
}

class ReceiveFormChanging extends ReceiveFormState {
  const ReceiveFormChanging({required ReceiveFromModel receiveFromModel})
      : super(receiveFromModel: receiveFromModel);
}

class ReceiveFormSuccess extends ReceiveFormState {
  const ReceiveFormSuccess({required ReceiveFromModel receiveFromModel})
      : super(receiveFromModel: receiveFromModel);
}

class ReceiveFormError extends ReceiveFormState {
  final String message;
  const ReceiveFormError({
    required ReceiveFromModel receiveFromModel,
    required this.message,
  }) : super(receiveFromModel: receiveFromModel);
}
