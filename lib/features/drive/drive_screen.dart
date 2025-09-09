import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class DriveScreen extends ConsumerStatefulWidget {
  const DriveScreen({super.key});
  @override
  DriveScreenState createState() => DriveScreenState();
}

class DriveScreenState extends ConsumerState<DriveScreen> {
  bool isDriving = false;
  bool isLiveOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drive Sense'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Builder(
            builder: (context) {
              if (isDriving) {
                if (isLiveOn) {
                  return const Text('Detecting in progress...');
                }
                return Lottie.asset(
                  'assets/lottie/camera.json',
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                );
              }
              return CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/logo.png'),
              );
            },
          ),
          SizedBox(height: 80),
          Builder(
            builder: (context) {
              if (isDriving) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Detecting in progress...'),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isDriving = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: const Text('Finish'),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Click start to begin with driving'),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isDriving = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: const Text('Start'),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
