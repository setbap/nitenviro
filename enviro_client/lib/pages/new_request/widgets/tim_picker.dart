import 'package:flutter/material.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:tuple/tuple.dart';

typedef OneParamCallBack<T> = void Function(T param);

class NETimPicker extends StatefulWidget {
  final DateChangedCallback onConfirm;

  const NETimPicker({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<NETimPicker> createState() => _NETimPickerState();
}

class _NETimPickerState extends State<NETimPicker> {
  late Tuple3<int, int, int>? date;
  late PersianDate now;
  final monthName = PersianDate().monthLong;

  @override
  void initState() {
    super.initState();
    date = Tuple3(
      PersianDate().year!,
      PersianDate().month!,
      PersianDate().day!,
    );
    now = PersianDate(DateTime.now().add(const Duration(days: 1)).toString());
  }

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
          DatePicker.showDatePicker(
            context,
            minYear: now.year ?? 1400,
            initialDay: now.day ?? 21,
            initialMonth: now.month ?? 7,
            maxYear: 1500,
            showTitleActions: true,
            confirm: const Text(
              'قبول',
              style: TextStyle(color: Colors.green),
            ),
            cancel: const Text(
              'بی خیال',
              style: TextStyle(color: Colors.red),
            ),
            dateFormat: "yyyy-mm-dd",
            onChanged: (year, month, day) {},
            onConfirm: (year, month, day) {
              date = Tuple3(year!, month!, day!);
              setState(() {});
              widget.onConfirm(year, month, day);
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date?.item3.toString() ?? ""),
            const Text("   /   "),
            Text(monthName[(date!.item2 - 1) % 12]),
            const Text("   /   "),
            Text(date?.item1.toString() ?? ""),
          ],
        ),
      ),
    );
  }
}
