part of 'ongoing_request_cubit.dart';

@immutable
abstract class TodaySpacialRequestState {
  final List<SpacialRequest> spacialRequest;

  const TodaySpacialRequestState({required this.spacialRequest});
}

class TodaySpacialRequestInitial extends TodaySpacialRequestState {
  const TodaySpacialRequestInitial() : super(spacialRequest: const []);
}

class TodaySpacialRequestLoading extends TodaySpacialRequestState {
  final String? message;
  const TodaySpacialRequestLoading({
    this.message,
    required List<SpacialRequest> spacialRequest,
  }) : super(spacialRequest: spacialRequest);
}

class TodaySpacialRequestSuccess extends TodaySpacialRequestState {
  const TodaySpacialRequestSuccess(
      {required List<SpacialRequest> spacialRequest})
      : super(spacialRequest: spacialRequest);
}

class TodaySpacialRequestError extends TodaySpacialRequestState {
  final String message;
  const TodaySpacialRequestError({
    required this.message,
    required List<SpacialRequest> spacialRequest,
  }) : super(spacialRequest: spacialRequest);
}
