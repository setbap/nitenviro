import 'package:enviro_shared/pages/second_splash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secondsplash/secondsplash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/utils/utils.dart';

class MyHomePageSplash extends StatefulWidget {
  final PageReturn authPage;
  final PageReturn notAuthPage;
  const MyHomePageSplash({
    Key? key,
    required this.authPage,
    required this.notAuthPage,
  }) : super(key: key);

  @override
  State<MyHomePageSplash> createState() => _MyHomePageSplashState();
}

class _MyHomePageSplashState extends State<MyHomePageSplash> {
  SplashController splashController = SplashController();
  bool loggedIn = false;
  bool showConnectionBanner = false;
  bool isPageClosed = false;
  bool serverError = false;
  void checkLogin() async {
    setState(() {
      serverError = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool(kIsLoggedIn) ?? false;
    if (loggedIn) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!isPageClosed) {
          setState(() {
            showConnectionBanner = true;
          });
        }
      });

      try {
        await context.read<UserInfoCubit>().getUserInfo();
      } catch (e) {
        setState(() {
          serverError = true;
        });
      }
    }
    loggedIn = prefs.getBool(kIsLoggedIn) ?? false;
    setState(() {});
    if (!serverError) {
      Future.delayed(const Duration(milliseconds: 60), () {
        splashController.close();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    isPageClosed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SecondSplash(
      controller: splashController,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Center(
            child: AnimatedLogo(),
          ),
          if (serverError)
            Align(
              child: OutlinedButton(
                onPressed: checkLogin,
                child: const Text(
                  "???????? ???? ?????????? ???? ????????. ?????????? ???????????? ??????????????.",
                ),
              ),
              alignment: const Alignment(0, 0.85),
            )
          else ...[
            const Align(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
              alignment: Alignment(0, 0.65),
            ),
            AnimatedOpacity(
              opacity: showConnectionBanner ? 1 : 0,
              duration: const Duration(milliseconds: 300),
              child: const Align(
                child: Text(
                  "???????? ?????????? ?????????????? ?????? ???? ?????????? ????????",
                ),
                alignment: Alignment(0, 0.85),
              ),
            ),
          ]
        ],
      ),
      next: loggedIn ? widget.authPage() : widget.notAuthPage(),
    );
  }
}
