import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/pages/pages.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:tuple/tuple.dart';

class Index extends StatefulWidget {
  static const String path = "/index";
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> with AutomaticKeepAliveClientMixin {
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
      "مدیریت ساختمان ها",
      AddLocation(),
    ),
    Tuple2<String, Widget>(
      "پروفایل",
      Profile(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page != 2.0) {
          setState(() {
            pageIndex = 2;
            pageController.animateToPage(
              2,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
            );
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
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
          leading: Container(),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Settings.path);
              },
              visualDensity: VisualDensity.compact,
              tooltip: "تنظیمات",
              icon: const Icon(
                Icons.settings,
              ),
              color: Colors.white,
            ),
          ],
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
              FocusManager.instance.primaryFocus?.unfocus();
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
