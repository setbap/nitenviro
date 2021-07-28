import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

List<Element> _elements = [
  Element(DateTime(2020, 6, 24, 9, 25), 'مکان : آمل'),
  Element(DateTime(2020, 6, 24, 9, 26), 'مکان : آمل'),
  Element(DateTime(2020, 6, 24, 9, 27), 'مکان : آمل'),
  Element(DateTime(2020, 6, 24, 9, 28), 'مکان : آمل'),
  Element(DateTime(2020, 6, 24, 9, 29), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 9, 20), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 9, 21), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 9, 22), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 9, 23), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 9, 24), 'مکان : آمل'),
  Element(DateTime(2020, 7, 24, 1, 25), 'مکان : آمل'),
  Element(DateTime(2020, 6, 24, 9, 25), 'مکان : آمل'),
  Element(
    DateTime(2020, 6, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 7, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 9, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 8, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 2, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 1, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 3, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(
    DateTime(2020, 4, 24, 9, 36),
    'Fine and what about you?',
  ),
  Element(DateTime(2021, 6, 24, 9, 39), 'تست 1234'),
  Element(
    DateTime(2020, 6, 25, 14, 12),
    'Hey you do you wanna go to the cinema?',
  ),
  Element(
      DateTime(2020, 6, 25, 14, 19), 'Yes of course when do we want to meet'),
  Element(
    DateTime(2020, 6, 25, 14, 20),
    'Lets meet at 8 o clock',
  ),
  Element(DateTime(2020, 6, 25, 14, 25), 'Okay see you then :)'),
  Element(DateTime(2020, 6, 27, 18, 41),
      'Hey whats up? Can you help me real quick?'),
  Element(
    DateTime(2020, 6, 27, 18, 45),
    'Of course  what do you need?',
  ),
  Element(DateTime(2020, 6, 28, 8, 47),
      'Can you send me the homework for tomorrow please?'),
  Element(
    DateTime(2020, 6, 28, 8, 48),
    'I dont understand the math questions :(',
  ),
  Element(
    DateTime(2020, 6, 28, 8, 56),
    'Yeah sure I have send them per mail',
  ),
];

class HistoryList extends StatelessWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GroupedListView<Element, DateTime>(
      elements: _elements,
      physics: const BouncingScrollPhysics(),
      order: GroupedListOrder.DESC,
      reverse: false,
      floatingHeader: true,
      useStickyGroupSeparators: true,
      groupBy: (Element element) =>
          DateTime(element.date.year, element.date.month, element.date.day),
      groupHeaderBuilder: (Element element) => SizedBox(
        height: 48,
        child: Align(
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            width: 120,
            decoration: const BoxDecoration(
              color: lightYellow,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.yMMMd().format(element.date),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
      itemBuilder: (_, Element element) {
        return Align(
          child: SizedBox(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(
                  width: 2,
                  color: yellowSemiDarken,
                ),
              ),
              elevation: 4.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                leading: Text(DateFormat.Hm().format(element.date)),
                title: Text(element.name),
                trailing: const Icon(Icons.person_outline),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Element implements Comparable {
  DateTime date;
  String name;

  Element(this.date, this.name);

  @override
  int compareTo(other) {
    return date.compareTo(other.date);
  }
}
