// import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllReuqest extends StatefulWidget {
  const AllReuqest({Key? key}) : super(key: key);

  @override
  State<AllReuqest> createState() => _AllReuqestState();
}

class _AllReuqestState extends State<AllReuqest>
    with AutomaticKeepAliveClientMixin<AllReuqest> {
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
                    const SizedBox(height: 32),
                    OutlinedButton(
                      onPressed: () {
                        context.read<TodayBuildingCubit>().getTodayBuilding();
                      },
                      child: Text(
                        "تلاش دوباره",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
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
                detailBTNText: "مشاهده جزییات",
                acceptBTNText: "آغاز فرآیند دریافت",
                time: timeOfDayDataTuple[building.timeOfDay % 3].item1,
                address: building.address,
                onDetailPress: () {
                  showAvatarModalBottomSheet(
                    builder: (context) {
                      return RequestCardDetailModal(
                        lat: building.latitude,
                        plak: building.plaque,
                        postalCode: building.postalCode,
                        lng: building.longitude,
                        address: building.address,
                        time: timeOfDayDataTuple[building.timeOfDay].item1,
                      );
                    },
                    name: building.user?.name ?? "",
                    context: context,
                    avatarUrl: building.user?.avatar,
                  );
                },
                onAcceptPress: (state is TodayBuildingLoading)
                    ? null
                    : () async {
                        final isSuccess = await context
                            .read<TodayBuildingCubit>()
                            .setRequestToOngoing(
                              id: building.id,
                              driverMessage: "",
                            );
                        if (isSuccess != null && isSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("درخواست به لیست در حال اجرا اضافه شد"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                isSpectial: false,
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
