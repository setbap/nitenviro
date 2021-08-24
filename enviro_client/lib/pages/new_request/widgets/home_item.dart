import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/models/request_model.dart';
import 'package:nitenviro/pages/new_request/widgets/building_button.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:tuple/tuple.dart';

class HomeItem extends StatefulWidget {
  final FnWithOneParam<int> onSelect;
  final List<Building> buildings;
  Tuple2<Color, Color> getColorSteps(int number) {
    final colors = [
      const Tuple2(Color(0xffED213A), Color(0xffb3291E)),
      const Tuple2(Color(0xffF37335), Color(0xffFDC830)),
      const Tuple2(Color(0xff00B4DB), Color(0xff0083B0)),
      const Tuple2(Color(0xff6f5b96), Color(0xff98a0ff)),
    ];

    return colors[number % 4];
  }

  const HomeItem({
    Key? key,
    required this.onSelect,
    required this.buildings,
  }) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.buildings.isEmpty) {
      return Container(
        height: 70,
        margin: const EdgeInsets.only(top: 4),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          color: lightBorder,
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            "ساختمانی ایجاد نشده است",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent,
                ),
          ),
        ),
      );
    }
    return BlocBuilder<NewRequestCubit, CollectingRequest>(
      builder: (context, state) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final building = widget.buildings[index];
              return NEBuildingButton(
                onPressed: () {
                  widget.onSelect(index);

                  setState(() {});
                },
                colors: widget.getColorSteps(index),
                isActive: building.id == state.selectedBuildingId,
                title: building.name,
              );
            },
            itemCount: widget.buildings.length,
          ),
        );
      },
    );
  }
}
