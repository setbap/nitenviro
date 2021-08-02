part of 'today_building_cubit.dart';

@immutable
abstract class TodayBuildingState {
  final List<Building> buildings;

  const TodayBuildingState({required this.buildings});
}

class TodayBuildingInitial extends TodayBuildingState {
  const TodayBuildingInitial() : super(buildings: const []);
}

class TodayBuildingLoading extends TodayBuildingState {
  final String? message;
  const TodayBuildingLoading({
    this.message,
    required List<Building> buildings,
  }) : super(buildings: buildings);
}

class TodayBuildingSuccess extends TodayBuildingState {
  const TodayBuildingSuccess({required List<Building> buildings})
      : super(buildings: buildings);
}

class TodayBuildingError extends TodayBuildingState {
  final String message;
  const TodayBuildingError({
    required this.message,
    required List<Building> buildings,
  }) : super(buildings: buildings);
}
