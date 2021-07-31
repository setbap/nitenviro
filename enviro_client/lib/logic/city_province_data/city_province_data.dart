import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/city_province_data/city_province_state.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class CityProvinceDataCubit extends Cubit<CityProvinceState> {
  final RubbishCollectorsApi _rubbishCollectorsApi;
  CityProvinceDataCubit({required RubbishCollectorsApi rubbishCollectorsApi})
      : _rubbishCollectorsApi = rubbishCollectorsApi,
        super(
          CityProvinceState(
            provinces: <ProvinceModel>[],
            cities: <String, List<CityModel>>{},
          ),
        );

  Future<List<ProvinceModel>> getProvince() async {
    if (state.provinces.isEmpty) {
      final list = await _rubbishCollectorsApi.getAllProvince();
      emit(state.copyWith(provinces: list.value));
    }
    return state.provinces;
  }

  Future<List<CityModel>> getCitiesProvince({
    required String provinceId,
  }) async {
    if (state.cities[provinceId] == null || state.cities[provinceId] == []) {
      final list = await _rubbishCollectorsApi.getCitiesOfProvince(
        provinceId: provinceId,
      );
      state.cities[provinceId] = list.value ?? [];
    }
    return state.cities[provinceId] ?? [];
  }
}
