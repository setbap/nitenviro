import 'package:flutter/material.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:tuple/tuple.dart';

class NEReminderTime extends StatefulWidget {
  final FnWithOneParam<int> fnWithOneParam;
  final List<Tuple2<String, int>> data;
  const NEReminderTime({
    Key? key,
    required this.fnWithOneParam,
    required this.data,
  }) : super(key: key);

  Tuple2<String, int> getReminder(int number) {
    return data[number % data.length];
  }

  @override
  _NEReminderTimeState createState() => _NEReminderTimeState();
}

class _NEReminderTimeState extends State<NEReminderTime> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  16,
                ),
              ),
            ),
            builder: (context) {
              return NESelectList(
                fnWithOneParam: (value) {
                  widget.fnWithOneParam(value);
                  selectedIndex = value;
                  setState(() {});
                },
                data: widget.data,
                defualtIndex: selectedIndex,
              );
            },
          );
        },
        child: Center(
          child: Text(
            widget.data[selectedIndex].item1,
          ),
        ),
      ),
    );
  }
}

class NESelectList extends StatefulWidget {
  final FnWithOneParam<int> fnWithOneParam;
  final List<Tuple2<String, int>> data;
  final int defualtIndex;

  const NESelectList({
    Key? key,
    required this.fnWithOneParam,
    required this.data,
    this.defualtIndex = 0,
  }) : super(key: key);

  @override
  _NESelectListState createState() => _NESelectListState();
}

class _NESelectListState extends State<NESelectList> {
  late int selectedItemIndex;

  @override
  void initState() {
    super.initState();
    selectedItemIndex = widget.defualtIndex;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: Text(
                "زمان جمع آوری",
                style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    selectedItemIndex = index;
                    widget.fnWithOneParam(index);
                    setState(() {});
                  },
                  title: Text(widget.data[index].item1),
                  leading: Radio(
                    value: widget.data[index].item2,
                    groupValue: selectedItemIndex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedItemIndex = value as int;
                        widget.fnWithOneParam(value);
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0,
                );
              },
              padding: const EdgeInsets.all(0),
              itemCount: widget.data.length,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "انجام",
                    style: textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
