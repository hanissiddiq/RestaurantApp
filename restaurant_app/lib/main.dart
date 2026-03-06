import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/screen/detail/detail_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/provider/detail/bookmark_list_provider.dart';
import 'package:restaurant_app/provider/detail/bookmark_icon_provider.dart';
import 'package:restaurant_app/utils/notification_helper.dart';


import 'style/theme/restaurant_theme.dart';

// ===================== notification ===========
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> requestNotificationPermission() async {
  if (Platform.isAndroid) {
    final androidImplementation =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }
}
// ===================== end notification ===========


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initTimezone();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => IndexNavProvider()), // ✅ INI KUNCI

        ChangeNotifierProvider(create: (_) => ReminderProvider()..loadReminder()),

        ChangeNotifierProvider(
          create: (_) => BookmarkListProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => BookmarkIconProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(ApiServices()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode:
          themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/detail') {
          final id = settings.arguments as String;

          return MaterialPageRoute(
            builder: (_) => DetailScreen(restaurantId: id),
          );
        }
        return null;
      },
    );
  }
}
