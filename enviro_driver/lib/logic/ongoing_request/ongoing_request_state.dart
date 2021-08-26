part of 'ongoing_request_cubit.dart';

@immutable
abstract class AcceptedRequestState {
  final List<SpacialRequest> acceptedRequest;

  const AcceptedRequestState({required this.acceptedRequest});
}

class AcceptedRequestInitial extends AcceptedRequestState {
  const AcceptedRequestInitial() : super(acceptedRequest: const []);
}

class AcceptedRequestLoading extends AcceptedRequestState {
  final String? message;
  const AcceptedRequestLoading({
    this.message,
    required List<SpacialRequest> acceptedRequest,
  }) : super(acceptedRequest: acceptedRequest);
}

class AcceptedRequestSuccess extends AcceptedRequestState {
  const AcceptedRequestSuccess({required List<SpacialRequest> acceptedRequest})
      : super(acceptedRequest: acceptedRequest);
}

class AcceptedRequestError extends AcceptedRequestState {
  final String message;
  const AcceptedRequestError({
    required this.message,
    required List<SpacialRequest> acceptedRequest,
  }) : super(acceptedRequest: acceptedRequest);
}
