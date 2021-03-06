import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nitenviro/logic/city_province_data/city_province_data.dart';
import 'package:public_nitenviro/public_nitenviro.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/pages.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:nitenviro/utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences keyValueStorage =
      await SharedPreferences.getInstance();
  runApp(MyApp(keyValueStorage: keyValueStorage));
}

class MyApp extends StatelessWidget {
  final SharedPreferences keyValueStorage;
  final navigatorKey = GlobalKey<NavigatorState>();
  MyApp({Key? key, required this.keyValueStorage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PublicNitEnviroApi(
            nitenviroClient: PublicNitenviroClient(),
          ),
        ),
        RepositoryProvider(
          create: (context) => RubbishCollectorsApi(
            rubbishCollectorsClient: RubbishCollectorsClient(
              getAccessToken: () async =>
                  keyValueStorage.getString(kAccessTokenKey) ?? "",
              getRefreshToken: () async =>
                  keyValueStorage.getString(kRefreshTokenKey) ?? "",
              setAccessToken: (String token) async {
                await keyValueStorage.setString(kAccessTokenKey, token);
                return;
              },
              setRefreshToken: (String token) async {
                await keyValueStorage.setString(kRefreshTokenKey, token);
                return;
              },
              onAuthError: () async {
                await keyValueStorage.remove(kAccessTokenKey);
                await keyValueStorage.remove(kRefreshTokenKey);
                await keyValueStorage.remove(kIsLoggedIn);
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                  Intro.path,
                  (route) => false,
                );
              },
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<NewRequestCubit>(
            create: (context) => NewRequestCubit(
              rubbishCollectorsApi: context.read<RubbishCollectorsApi>(),
            ),
          ),
          BlocProvider<RecyclableDetectorCubit>(
            create: (context) => RecyclableDetectorCubit(
              publicNitEnviroApi: context.read<PublicNitEnviroApi>(),
            )..getAllItems(),
            lazy: false,
          ),
          BlocProvider<CityProvinceDataCubit>(
            create: (context) => CityProvinceDataCubit(
              rubbishCollectorsApi: context.read<RubbishCollectorsApi>(),
            ),
          ),
          BlocProvider<VideoTutorialsCubit>(
            create: (context) => VideoTutorialsCubit(
              publicNitEnviroApi: context.read<PublicNitEnviroApi>(),
            )..getAllTutorials(),
            lazy: false,
          ),
          BlocProvider<UserInfoCubit>(
            create: (context) => UserInfoCubit(
              rubbishCollectorsApi: context.read<RubbishCollectorsApi>(),
            ),
          ),
          BlocProvider<HistoryListCubit>(
            create: (context) => HistoryListCubit(
              isDriver: false,
              rubbishCollectorsApi: context.read<RubbishCollectorsApi>(),
            ),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
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
          // home: const LoginPhoneNumber(),
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
                  builder: (context) => BlocProvider<AuthPhoneInputCubit>(
                    create: (context) => AuthPhoneInputCubit(
                      rubbishCollectorsApi:
                          context.read<RubbishCollectorsApi>(),
                    ),
                    child: const LoginPhoneNumber(),
                  ),
                );
              case LoginPhoneNumberValidate.path:
                final phoneNumber = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => BlocProvider<AuthLoginInputCubit>(
                    create: (context) => AuthLoginInputCubit(
                      userType: 0,
                      keyValueStorage: keyValueStorage,
                      rubbishCollectorsApi:
                          context.read<RubbishCollectorsApi>(),
                      userInfoCubit: context.read<UserInfoCubit>(),
                    ),
                    child: LoginPhoneNumberValidate(
                      phoneNumber: phoneNumber,
                    ),
                  ),
                );

              case Intro.path:
                return MaterialPageRoute(
                  builder: (context) => const Intro(),
                );
              case History.path:
                return MaterialPageRoute(
                  builder: (context) => const History(),
                );
            }
          },
          // home: const Index(),
        ),
      ),
    );
  }
}
