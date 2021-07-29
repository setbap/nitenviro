import 'dart:math';

import 'package:enviro_driver/models/collected_rubbish.dart';
import 'package:enviro_driver/pages/history/widgets/widgets.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:grouped_list/grouped_list.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<CollectedRubish, DateTime>(
      elements: generator(),
      physics: const BouncingScrollPhysics(),
      order: GroupedListOrder.DESC,
      reverse: false,
      floatingHeader: true,
      useStickyGroupSeparators: true,
      groupBy: (CollectedRubish element) => DateTime(element.collectedAt.year,
          element.collectedAt.month, element.collectedAt.day),
      groupHeaderBuilder: (CollectedRubish element) => SizedBox(
        height: 48,
        child: Align(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              border: Border.all(color: yellowDarken),
              color: lightYellow,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                element.collectedAt.toPersianDateStr(
                  strMonth: true,
                  showDayStr: true,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (_, CollectedRubish collectedRubish) {
        return HistoryButton(collectedRubish: collectedRubish);
      },
    );
  }
}

List<CollectedRubish> generator() {
  final random = Random(100000);
  final List<String?> images = [
    "https://dast2.com/uploads/cdn4/103506/6c064205a7b323fb002ecbf4de6a61ef0680f00f/l.jpg",
    null,
    null,
    "https://dast2.com/uploads/cdn9/103462/b72f93c19cadf12dbc5f9425108f3dcb42889e71/l.jpg",
    "https://dast2.com/uploads/cdn2/103401/5a6b2254c559ed5cebfbe20548f9c1003aa6f613/l.jpg",
    null,
    "https://dast2.com/uploads/cdn6/103394/b6c82906afd7634d08be9cd3d8fb2b017815a856/l.jpg",
    "https://dast2.com/uploads/cdn2/103302/574acbfae13575c33ec5d9abebbe240a9d62903e/l.jpg",
    null,
    "https://dast2.com/uploads/cdn3/103268/1812e85d4835ca486ed5363fdfd7e2b5682b8704/l.jpg",
  ];

  var list = <CollectedRubish>[];
  for (var i = 0; i < 1000; i++) {
    list.add(CollectedRubish(
      address: "asdasd",
      collectedAt: DateTime(
        random.nextInt(2) + 2020,
        random.nextInt(12),
        random.nextInt(3) * 6,
        random.nextInt(8) + 8,
        random.nextInt(59),
      ),
      isSpectial: random.nextBool(),
      driverDesc: "korea das dasd as dasd ",
      imageUrl: images[random.nextInt(10)] ?? "",
      lat: random.nextInt(100) / 100 + 56,
      lng: random.nextInt(100) / 100 + 36,
      plak: random.nextInt(100),
      postalCode: 2003040500,
      glass: random.nextBool() ? random.nextInt(10000) / 100 : null,
      metal: random.nextBool() ? random.nextInt(10000) / 100 : null,
      mix: random.nextBool() ? random.nextInt(10000) / 100 : null,
      paper: random.nextBool() ? random.nextInt(10000) / 100 : null,
      plastic: random.nextBool() ? random.nextInt(10000) / 100 : null,
    ));
  }
  return list;
}
