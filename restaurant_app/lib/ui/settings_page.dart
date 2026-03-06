import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme_provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';

class SettingsPage extends StatefulWidget  {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ReminderProvider>().loadReminder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return SwitchListTile(
                title: const Text('Dark Theme'),
                value: themeProvider.isDarkTheme,
                onChanged: (value) {
                  themeProvider.setTheme(value);
                },
              );
            },
          ),

          Consumer<ReminderProvider>(
            builder: (context, schedulingProvider, _) {
              return SwitchListTile(
                title: const Text('Daily Restaurant Notification'),
                subtitle: const Text('Aktifkan notifikasi rekomendasi restaurant setiap hari'),
                value: schedulingProvider.isActive,
                onChanged: (value) {
                  schedulingProvider.setReminder(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
