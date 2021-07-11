import 'package:flutter/material.dart';
import 'package:nitenviro/pages/new_request/widgets/building_button.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:tuple/tuple.dart';

class HomeItem extends StatefulWidget {
  final FnWithOneParam<int> onSelect;
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
  }) : super(key: key);

  @override
  _HomeItemState createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return NEBuildingButton(
            onPressed: () {
              widget.onSelect(index);
              selectedIndex = index;
              setState(() {});
            },
            colors: widget.getColorSteps(index),
            isActive: index == selectedIndex,
            title: "خانه",
          );
        },
        itemCount: 10,
      ),
    );
  }
}
