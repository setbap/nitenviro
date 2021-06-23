import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/logic/location/location_request_cubit.dart';
import 'package:nitenviro/models/location_model.dart';
import 'package:nitenviro/pages/add_building/add_building_form.dart';
import 'package:nitenviro/shared_widget/background_circle_painter.dart';
import 'package:nitenviro/utils/colors.dart';

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
      child: BlocConsumer<LocationRequestCubit, GenericApiState<LocationModel>>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
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
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AddBuildingForm();
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
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Dismissible(
                      onDismissed: (direction) {},
                      direction: DismissDirection.startToEnd,
                      key: ValueKey(index),
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
                                "حذف خانه تقی",
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
                          title: const Text("خانه تقی"),
                          dense: false,
                          subtitle: Row(
                            children: const [
                              Icon(
                                CupertinoIcons.clock,
                                color: darkGreen,
                              ),
                              SizedBox(width: 8),
                              Text("شنبه"),
                              Text("ها"),
                              SizedBox(width: 8),
                              Text("از ساعت"),
                              SizedBox(width: 2),
                              Text("09:00"),
                              SizedBox(width: 10),
                              Text("تا ساعت"),
                              SizedBox(width: 2),
                              Text("21:00"),
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
                                    return const AddBuildingForm(
                                      name: "خانه تقی",
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    childCount: 12,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 80,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
