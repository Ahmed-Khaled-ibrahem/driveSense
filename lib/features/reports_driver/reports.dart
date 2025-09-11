import 'package:drivesense/features/reports_driver/session_provider.dart';
import 'package:drivesense/features/reports_driver/trip_session_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../app/theme/theme_provider.dart';
import '../auth/profile_model.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key, required this.profile});

  final Profile profile;

  @override
  ReportsScreenState createState() => ReportsScreenState();
}

class ReportsScreenState extends ConsumerState<ReportsScreen> {
  late DatabaseReference db;

  @override
  void initState() {
    super.initState();
    db = FirebaseDatabase.instance.ref(
      'profiles/${widget.profile.id}/sessions',
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final sessionState = ref.watch(reportingSessionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: FutureBuilder(
        future: TripSessionModel.fetchAll(db),
        builder: (context, asyncSnapshot) {
          final List<TripSessionModel> data = asyncSnapshot.data ?? [];
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text('Error: ${asyncSnapshot.error}'));
          }
          if (data.isEmpty) {
            return Center(child: Text('No data found'.tr()));
          }

          return Timeline.tileBuilder(
            shrinkWrap: true,
            theme: TimelineThemeData(
              indicatorTheme: IndicatorThemeData(size: 16),
              connectorTheme: ConnectorThemeData(indent: 10),
            ),
            builder: TimelineTileBuilder.fromStyle(
              contentsAlign: ContentsAlign.basic,
              connectorStyle: ConnectorStyle.solidLine,
              indicatorStyle: IndicatorStyle.dot,
              endConnectorStyle: ConnectorStyle.transparent,
              nodePositionBuilder: (context, index) => 0.3,
              itemExtent: 120,
              oppositeContentsBuilder: (context, index) => Text(
                DateFormat('EEEE, dd-MM-yyyy').format(data[index].date),
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              contentsBuilder: (context, index) => Card(
                color: themeMode == ThemeMode.light
                    ? Color(0xff8294d5)
                    : Color(0xff223c73),
                child: ListTile(
                  title: Text(
                    'Trip Session',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Started at ${DateFormat('hh:mm:ss').format(data[index].startTime)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Ended   at ${DateFormat('hh:mm:ss').format(data[index].endTime)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Duration  ${timeDiff(data[index].startTime, data[index].endTime)}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: themeMode == ThemeMode.light
                        ? Color(0xffcdb2ea)
                        : Color(0xff450a85),
                    radius: 25,
                    child: Text(
                      data[index].mistakesCount.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              itemCount: data.length,
            ),
          );
        },
      ),
    );
  }

  String timeDiff(DateTime start, DateTime end) {
    Duration diff = end.difference(start);
    int hours = diff.inHours;
    int minutes = diff.inMinutes % 60;
    int seconds = diff.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
