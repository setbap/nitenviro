import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/add_building/add_building_form.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class AddLocation extends StatelessWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 20,
            center: Offset(size.width / 8, size.height / 8),
            isRightPrimary: false),
        CirclePaintInfo(
          radius: 15,
          center: Offset(size.width / 2, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 20,
          center: Offset(size.width - 20, size.height / 4),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 35,
          center: Offset(size.width / 2, 0),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(size.width - 90, size.height),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(90, size.height),
          isRightPrimary: false,
        ),
      ],
      child: RefreshIndicator(
        onRefresh: () async {
          await context.read<UserInfoCubit>().getUserInfo();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: DottedDecoration(
                  shape: Shape.box,
                  borderRadius: BorderRadius.circular(16),
                  color: yellowDarken,
                ),
                height: 70,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 16,
                  left: 12,
                  right: 12,
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const AddBuildingForm(
                            id: null,
                          );
                        },
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      "اضافه کردن ساختمان جدید",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: darkGreen),
                    ),
                  ),
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.only(right: 12, top: 16),
              sliver: SliverToBoxAdapter(
                child: Text("لیست ساختمان ها"),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              sliver: BlocBuilder<UserInfoCubit, UserInfoState>(
                builder: (context, state) {
                  final buildings = state.user.buildings;
                  if (state.user.buildings.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: lightBorder.withAlpha(150),
                            width: 2,
                          ),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "ساختمانی ایجاد نشده است",
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.redAccent,
                                    ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final building = buildings[index];
                        return Dismissible(
                          onDismissed: (direction) async {},
                          direction: DismissDirection.startToEnd,
                          key: Key(building.toString()),
                          resizeDuration: const Duration(milliseconds: 300),
                          movementDuration: const Duration(milliseconds: 300),
                          confirmDismiss:
                              (DismissDirection dismissDirection) async {
                            switch (dismissDirection) {
                              case DismissDirection.startToEnd:
                                final res = await context
                                    .read<UserInfoCubit>()
                                    .deleteUserBuilding(
                                      buildingId: building.id,
                                      onDeleteSuccess: context
                                          .read<NewRequestCubit>()
                                          .clearIfSelected,
                                    );

                                return res;
                              default:
                                break;
                            }
                            return false;
                          },
                          background: Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.only(
                                right: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "حذف ${building.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            shadowColor: yellowDarken.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 2,
                                color: darkBorder.withOpacity(0.2),
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                right: 12,
                              ),
                              minVerticalPadding: 0,
                              title: Text(building.name),
                              dense: false,
                              subtitle: Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.clock,
                                    color: darkGreen,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(building.weekDayPersian),
                                  const Text("ها"),
                                  const SizedBox(width: 8),
                                  Text(building.timeOfDayPersian),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AddBuildingForm(
                                          address: building.address,
                                          dayOfWeek: building.weekDay,
                                          id: building.id,
                                          name: building.name,
                                          plaque: building.plaque,
                                          postalCode: building.postalCode,
                                          timeRange: building.timeOfDay,
                                          cityId: building.cityId,
                                          cityName: building.cityName,
                                          provinceName: "مازندران",
                                          latLng: LatLng(
                                            building.latitude,
                                            building.longitude,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: buildings.length,
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
              ),
            )
          ],
        ),
      ),
    );
  }
}
