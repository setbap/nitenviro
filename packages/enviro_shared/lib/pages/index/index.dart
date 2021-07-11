import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:enviro_shared/pages/pages.dart';
import 'package:enviro_shared/shared_widget/shared_widget.dart';
import 'package:enviro_shared/utils/utils.dart';
import 'package:tuple/tuple.dart';

class IndexPage extends StatefulWidget {
  final List<Tuple3<String, Widget, BottomNavigationBarItem>> pages;

  const IndexPage({Key? key, required this.pages}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  int pageIndex = 2;
  final pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );

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
                    widget.pages[pageIndex].item1,
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
          itemBuilder: (context, index) => widget.pages[index].item2,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          itemCount: 5,
        ),
        extendBodyBehindAppBar: false,
        resizeToAvoidBottomInset: true,
        extendBody: true,
        bottomNavigationBar: NEBottomNavigation(
          currentIndex: pageIndex,
          items: widget.pages.map((e) => e.item3).toList(),
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
