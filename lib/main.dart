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
          title: 'Nit Enviro',
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
          initialRoute: Index.path,
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case Index.path:
                return MaterialPageRoute(
                  builder: (context) => Index(),
                );
              case Settings.path:
                return MaterialPageRoute(
                  builder: (context) => Settings(),
                );
              case LoginPhoneNumber.path:
                return MaterialPageRoute(
                  builder: (context) => LoginPhoneNumber(),
                );
              case LoginPhoneNumberValidate.path:
                return MaterialPageRoute(
                  builder: (context) => LoginPhoneNumberValidate(),
                );
              case IntroPage.path:
                return MaterialPageRoute(
                  builder: (context) => IntroPage(),
                );
            }
          },
          // home: const Index(),
        ),
      ),
    );
  }
}
