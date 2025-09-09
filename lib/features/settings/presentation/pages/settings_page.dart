import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/theme/theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage> {

  final double spacing = 8;
  bool soundAlert = false;
  bool vibration = false;
  bool contactsAlert = false;
  bool mobileAlerts = false;

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(title: Text('settings.title'.tr())),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'settings.language'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: spacing),
          SegmentedButton<Locale>(
            segments: <ButtonSegment<Locale>>[
              ButtonSegment<Locale>(
                value: const Locale('en'),
                label: Text('language.en'.tr()),
              ),
              ButtonSegment<Locale>(
                value: const Locale('ar'),
                label: Text('language.ar'.tr()),
              ),
            ],
            selected: <Locale>{context.locale},
            onSelectionChanged: (selection) async {
              final Locale newLocale = selection.first;
              await context.setLocale(newLocale);
            },
          ),
          SizedBox(height: spacing),
          Text(
            'settings.theme'.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: spacing),
          SegmentedButton<ThemeMode>(
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                value: ThemeMode.system,
                label: Text('System'),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.light,
                label: Text('Light'),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.dark,
                label: Text('Dark'),
              ),
            ],
            selected: <ThemeMode>{themeMode},
            onSelectionChanged: (selection) {
              ref
                  .read(themeModeProvider.notifier)
                  .setThemeMode(selection.first);
            },
          ),
          SizedBox(height: spacing),
          Text('Sound Alert', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: spacing),
          SegmentedButton<bool>(
            segments: <ButtonSegment<bool>>[
              ButtonSegment<bool>(value: true, label: Text('On')),
              ButtonSegment<bool>(value: false, label: Text('Off')),
            ],
            selected: <bool>{soundAlert},
            onSelectionChanged: (selection) async {
              setState(() {
                soundAlert = selection.first;
              });
            },
          ),
          SizedBox(height: spacing),
          Text('Vibration', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: spacing),
          SegmentedButton<bool>(
            segments: <ButtonSegment<bool>>[
              ButtonSegment<bool>(value: true, label: Text('On')),
              ButtonSegment<bool>(value: false, label: Text('Off')),
            ],
            selected: <bool>{vibration},
            onSelectionChanged: (selection) async {
              setState(() {
                vibration = selection.first;
              });
            },
          ),
          SizedBox(height: spacing),
          Text('Contacts alerts', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: spacing),
          SegmentedButton<bool>(
            segments: <ButtonSegment<bool>>[
              ButtonSegment<bool>(value: true, label: Text('On')),
              ButtonSegment<bool>(value: false, label: Text('Off')),
            ],
            selected: <bool>{contactsAlert},
            onSelectionChanged: (selection) async {
              setState(() {
                contactsAlert = selection.first;
              });
            },
          ),
          SizedBox(height: spacing),
          Text('Mobile alerts', style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: spacing),
          SegmentedButton<bool>(
            segments: <ButtonSegment<bool>>[
              ButtonSegment<bool>(value: true, label: Text('On')),
              ButtonSegment<bool>(value: false, label: Text('Off')),
            ],
            selected: <bool>{mobileAlerts},
            onSelectionChanged: (selection) async {
              setState(() {
                mobileAlerts = selection.first;
              });
            },
          ),

        ],
      ),
    );
  }
}
