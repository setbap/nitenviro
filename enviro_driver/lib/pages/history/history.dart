import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enviro_driver/shared_widget/shared_widget.dart';
import 'package:tuple/tuple.dart';

const items = [
  Tuple2("روز اخیر", 0),
  Tuple2("ماه اخیر", 1),
  Tuple2("سال اخیر", 2),
  Tuple2("همه", 3),
];

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int selectedDate = 0;
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
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ColoredBox(
              color: yellowDarken,
              child: SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: items
                      .map((item) => HistoryChips(
                          isSelected: item.item2 == selectedDate,
                          text: item.item1,
                          onTap: () {
                            setState(() {
                              selectedDate = item.item2;
                            });
                          }))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HistoryChips extends StatelessWidget {
  const HistoryChips(
      {Key? key,
      required this.isSelected,
      required this.text,
      required this.onTap})
      : super(key: key);

  final bool isSelected;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Chip(
          label: Text(
            text,
            style: isSelected
                ? Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold)
                : Theme.of(context).textTheme.subtitle1,
          ),
          backgroundColor: isSelected ? veryLightYellow : lightYellow,
          avatar: isSelected
              ? const Icon(
                  Icons.done,
                  color: darkGreen,
                )
              : null,
          side:
              isSelected ? const BorderSide(color: darkGreen, width: 3) : null,
        ),
      ),
    );
  }
}
