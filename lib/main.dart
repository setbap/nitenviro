import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/location.dart';
import 'package:nitenviro/index.dart';
import 'package:nitenviro/logic/location/location_request_cubit.dart';
import 'package:nitenviro/logic/new_request_form/new_request_cubit.dart';
import 'package:nitenviro/logic/recyclable_detector/recyclable_detector_cubit.dart';
import 'package:nitenviro/logic/video_tutorial/video_tutorials_cubit.dart';
import 'package:nitenviro/pages/intro/intro.dart';
import 'package:nitenviro/pages/phone_number_login/phone_number_login.dart';
import 'package:nitenviro/pages/phone_number_validate_login/phone_number_validate_login.dart';
import 'package:nitenviro/pages/settings/settings.dart';
import 'package:nitenviro/repo/public_enviro_repo.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:public_nitenviro/public_nitenviro.dart';
import 'package:secondsplash/secondsplash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PublicNitEnviroApi(
            nitenviroClient: PublicNitenviroClient(),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewRequestCubit>(
            create: (context) => NewRequestCubit(),
          ),
          BlocProvider<RecyclableDetectorCubit>(
            create: (context) => RecyclableDetectorCubit(
                publicNitEnviroApi: context.read<PublicNitEnviroApi>())
              ..getAllItems(),
            lazy: false,
          ),
          BlocProvider<VideoTutorialsCubit>(
            create: (context) => VideoTutorialsCubit(
              publicNitEnviroApi: context.read<PublicNitEnviroApi>(),
            )..getAllTutorials(),
          ),
          BlocProvider<LocationRequestCubit>(
            create: (context) => LocationRequestCubit(
              location: Location(),
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale("en", "US"),
            Locale("fa", "IR"),
          ],
          locale: const Locale("fa", "IR"),
          title: 'Enviro',
          theme: ThemeData(
            appBarTheme: AppBarTheme.of(context).copyWith(
                color: yellowDarken,
                titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
                iconTheme: IconTheme.of(context).copyWith(color: Colors.white)),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: "vazir",
            primarySwatch: Colors.orange,
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.all(8),
              filled: true,
              fillColor: const Color(0xFFF7F7F7),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: mainYellow),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          home: const MyHomePage(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Index.path:
                return MaterialPageRoute(
                  builder: (context) => const Index(),
                );
              case Settings.path:
                return MaterialPageRoute(
                  builder: (context) => const Settings(),
                );
              case LoginPhoneNumber.path:
                return MaterialPageRoute(
                  builder: (context) => const LoginPhoneNumber(),
                );
              case LoginPhoneNumberValidate.path:
                return MaterialPageRoute(
                  builder: (context) => const LoginPhoneNumberValidate(),
                );
              case IntroPage.path:
                return MaterialPageRoute(
                  builder: (context) => const IntroPage(),
                );
            }
          },
          // home: const Index(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SplashController splashController = SplashController();
  bool loggedIn = false;

  void checkLogin() async {
    // use for checking if user is logged in or not
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = prefs.getBool("loggedIn") ?? false;
    });

    Future.delayed(const Duration(milliseconds: 60), () {
      splashController.close();
    });
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
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
          Center(
            child: Image.asset(
              "./assets/splash_light.png",
              width: 256,
              height: 256,
              fit: BoxFit.scaleDown,
            ),
          ),
          const Align(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
            alignment: Alignment(0, 0.8),
          ),
        ],
      ),
      next: loggedIn ? const Index() : const IntroPage(),
    );
  }
}
