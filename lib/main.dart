// import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:final_chat_app/src/features/contacts/screens/contact_list_screen.dart';
import 'package:final_chat_app/src/features/group/screens/group_list_screen.dart';
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
            textTheme: GoogleFonts.latoTextTheme(),
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic ?? _defaultDarkColorScheme,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              foregroundColor: Colors.white,
            ),
          ),
          themeMode: ThemeMode.light,
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = const [
    ContactListScreen(),
    GroupListScreen(),
  ];
  int tabIndex = 0;
  double? iconSize = 28;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: tabIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tabIndex,
        height: 65,
        onDestinationSelected: (int index) {
          setState(() {
            tabIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.chat_bubble_outline,
              size: iconSize! - 2.0,
            ),
            selectedIcon: Icon(
              Icons.chat_bubble,
              size: iconSize! - 2.0,
            ),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.groups_outlined,
              size: iconSize,
            ),
            selectedIcon: Icon(
              Icons.groups,
              size: iconSize,
            ),
            label: 'Groups',
          ),
        ],
      ),
    );
  }
}
