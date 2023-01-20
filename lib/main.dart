import 'package:dynamic_color/dynamic_color.dart';
import 'package:final_chat_app/home_screen.dart';
import 'package:final_chat_app/src/features/auth/controller/auth_controller.dart';
import 'package:final_chat_app/src/features/auth/screens/register_screen.dart';
import 'package:final_chat_app/src/navigation/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: lightDynamic ?? _defaultLightColorScheme,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
            ),
            textTheme: GoogleFonts.interTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ?? _defaultDarkColorScheme,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            ),
            textTheme: GoogleFonts.interTextTheme(),
          ),
          themeMode: ThemeMode.light,
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          home: ref.watch(userDataAuthProvider).when(
                data: (user) {
                  if (user == null) {
                    return const RegisterScreen();
                  } else {
                    return const HomeScreen();
                  }
                },
                error: (err, trace) {
                  return Center(child: Text(err.toString()));
                },
                loading: () => const CircularProgressIndicator(),
              ),
        );
      },
    );
  }
}
