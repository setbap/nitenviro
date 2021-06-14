import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nitenviro/index.dart';
import 'package:nitenviro/logic/new_request_form/new_request_cubit.dart';
import 'package:nitenviro/logic/recyclable_detector/recyclable_detector_cubit.dart';
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
                publicNitEnviroApi: context.read<PublicNitEnviroApi>()),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("fa", "IR"),
          ],
          locale: const Locale("fa", "IR"),
          title: 'Flutter Demo',
          theme: ThemeData(
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
          home: const Index(),
        ),
      ),
    );
  }
}
