import 'package:enviro_driver/pages/requests/sub_page/sub_page.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';

const double _kTabHeight = 46.0;

class Requests extends StatelessWidget {
  const Requests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          Container(
            color: yellowDarken,
            height: _kTabHeight + 8,
            child: TabBar(
              labelColor: darkGreen,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              tabs: const [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Tab(
                    text: "همه درخواست ها",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Tab(
                    text: "در حال اجرا",
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                AllReuqest(),
                IngoinRequest(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
