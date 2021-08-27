import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/models/models.dart';
import 'package:enviro_driver/pages/history/widgets/history_list.dart';
import 'package:enviro_driver/repo/repo.dart';
import './widgets/widgets.dart';

const items = [
  Tuple2("روز اخیر", 1),
  Tuple2("ماه اخیر", 30),
  Tuple2("سال اخیر", 365),
  Tuple2("همه", 9999),
];

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int selectedDate = 1;

  @override
  void initState() {
    super.initState();
    context.read<HistoryListCubit>().showHistoryList();
  }

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
        child: Column(
          children: [
            ColoredBox(
              color: yellowDarken,
              child: SizedBox(
                height: 60,
                child: BlocBuilder<HistoryListCubit, HistoryListState>(
                  builder: (context, state) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: items
                          .map((item) => HistoryChips(
                              isSelected: item.item2 == state.day,
                              text: item.item1,
                              onTap: () {
                                context
                                    .read<HistoryListCubit>()
                                    .showHistoryList(days: item.item2);
                              }))
                          .toList(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HistoryListCubit, HistoryListState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 32),
                        Text(
                          "در حال دربافت  صبر کنید...",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ));
                  }
                  if (state.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "خطا در دریافت",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 32),
                          Text(
                            state.error ?? "",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const SizedBox(height: 32),
                          OutlinedButton(
                            onPressed: () {
                              context
                                  .read<HistoryListCubit>()
                                  .showHistoryList();
                            },
                            child: Text(
                              "تلاش دوباره",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return HistoryList(historyList: state.historyItems);
                },
              ),
            ),
          ],
        ));
  }
}
