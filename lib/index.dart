import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/add_building/add_building.dart';
import 'package:nitenviro/pages/new_request/new_request.dart';
import 'package:nitenviro/pages/profile/profile.dart';
import 'package:nitenviro/pages/recycle_finder/recycle_finder.dart';
import 'package:nitenviro/pages/tutorial/tutorials.dart';
import 'package:nitenviro/shared_widget/bottom_nav.dart';
import 'package:nitenviro/utils/colors.dart';
import 'package:tuple/tuple.dart';

class Index extends StatefulWidget {
  static const String path = "/index";
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    super.initState();
  }

  int pageIndex = 2;
  final pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );

  List<Tuple2<String, Widget>> pageList = const <Tuple2<String, Widget>>[
    Tuple2<String, Widget>(
      "آموزش",
      Tutorials(),
    ),
    Tuple2<String, Widget>(
      "شناسایی پسماند بازیافتی",
      RecycleFinder(),
    ),
    Tuple2<String, Widget>(
      "درخواست جمع آوری",
      NewRequest(),
    ),
    Tuple2<String, Widget>(
      "Page 4",
      AddLocation(),
    ),
    Tuple2<String, Widget>(
      "پروفایل",
      Profile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowDarken,
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 200,
          height: 35,
          child: PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                fillColor: Colors.transparent,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: Center(
              key: ValueKey(pageIndex),
              child: FittedBox(
                child: Text(
                  pageList[pageIndex].item1,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
          ),
          color: Colors.white,
        ),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) => pageList[index].item2,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 5,
      ),
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      bottomNavigationBar: NEBottomNavigation(
        currentIndex: pageIndex,
        onTap: (index) => setState(
          () {
            pageIndex = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          },
        ),
      ),
    );
  }
}
