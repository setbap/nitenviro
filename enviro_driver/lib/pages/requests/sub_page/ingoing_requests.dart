// import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngoinRequest extends StatefulWidget {
  const IngoinRequest({Key? key}) : super(key: key);

  @override
  State<IngoinRequest> createState() => _IngoinRequestState();
}

class _IngoinRequestState extends State<IngoinRequest>
    with AutomaticKeepAliveClientMixin<IngoinRequest> {
  @override
  void initState() {
    super.initState();
    context.read<TodayBuildingCubit>().getTodayBuilding();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<TodayBuildingCubit>().getTodayBuilding();
      },
      child: BlocConsumer<TodayBuildingCubit, TodayBuildingState>(
        listener: (context, state) {
          if (state.buildings.isNotEmpty) {
            if (state is TodayBuildingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          }

          if (state is TodayBuildingLoading && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          // when first request goes wrong or loading state
          if (state.buildings.isEmpty && state is! TodayBuildingSuccess) {
            if (state is TodayBuildingLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 32,
                    ),
                    Text("درحال دریافت اطلاعات مکان و ساختمان های امروز")
                  ],
                ),
              );
            }
            if (state is TodayBuildingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "خطا در دریافت",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              );
            }
          }
          // in this state today building fetched successfully

          return ListView.builder(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
            // physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final building = state.buildings[index];
              return RequestItemCard(
                detailBTNText: "جزییات",
                acceptBTNText: "تایید دریافت",
                time: timeOfDayDataTuple[building.timeOfDay % 3].item1,
                phoneNumber: building.user?.phone,
                address: building.address,
                lat: building.latitude,
                lng: building.longitude,
                onDetailPress: () {
                  showAvatarModalBottomSheet(
                    builder: (context) {
                      return RequestCardDetailModal(
                        lat: building.latitude,
                        lng: building.longitude,
                        plak: building.plaque,
                        postalCode: building.postalCode,
                        address: building.address,
                        desc: building.description ?? "",
                        time: "building.timeOfDay",
                      );
                    },
                    name: building.user?.name,
                    avatarUrl: building.user?.avatar,
                    context: context,
                  );
                },
                onAcceptPress: () {
                  showAvatarModalBottomSheet(
                    builder: (context) {
                      return const RequestCollectModal();
                    },
                    name: "سینا ابراهیمی",
                    context: context,
                  );
                },
                isSpectial: index % 2 == 0,
              );
            },
            itemCount: state.buildings.length,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
