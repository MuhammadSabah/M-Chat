// import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:final_chat_app/src/features/auth/screens/register_screen.dart';
import 'package:final_chat_app/src/navigation/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _defaultLightColorScheme =
      ColorScheme.fromSwatch(primarySwatch: Colors.blue);

  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
      primarySwatch: Colors.blue, brightness: Brightness.dark);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
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
          home: const RegisterScreen(),
        );
      },
    );
  }
}


