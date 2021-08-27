import './widgets.dart';
import 'package:enviro_shared/enviro_shared.dart';

import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class HistoryList extends StatelessWidget {
  final List<SpacialRequest> historyList;
  const HistoryList({
    Key? key,
    required this.historyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<SpacialRequest, DateTime>(
      elements: historyList,
      physics: const BouncingScrollPhysics(),
      order: GroupedListOrder.DESC,
      reverse: false,
      itemComparator: (el1, el2) =>
          el1.receivedTime!.compareTo(el2.receivedTime!),
      floatingHeader: true,
      useStickyGroupSeparators: true,
      groupBy: (SpacialRequest element) => DateTime(element.receivedTime!.year,
          element.receivedTime!.month, element.receivedTime!.day),
      groupHeaderBuilder: (SpacialRequest element) => SizedBox(
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
                element.receivedTime!.toPersianDateStr(
                  strMonth: true,
                  showDayStr: true,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (_, SpacialRequest spacialRequest) {
        return HistoryButton(spacialRequest: spacialRequest);
      },
    );
  }
}
