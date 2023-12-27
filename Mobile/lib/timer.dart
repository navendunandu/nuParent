import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:nu_parent/main.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '0:00:00') {
      startBeepSound();
      showStopSoundDialog(context); // Pass the context to showStopSoundDialog
    }
  }

  bool isDialogOpen = false;

  void showStopSoundDialog(BuildContext context) {
    if (!isDialogOpen) {
      isDialogOpen = true;
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Times Up!'),
                content: const Text('Do you want to stop the sound?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      stopBeepSound(context);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Cancel Sound'),
                  ),
                ],
              );
            },
          );
        },
      ).then((value) {
        // Reset the flag when the dialog is closed
        isDialogOpen = false;
      });
    }
  }

  Future<void> startBeepSound() async {
    await FlutterRingtonePlayer.playAlarm();
  }

  void playBombingSound() {
    FlutterRingtonePlayer.playAlarm();

    // Schedule the stop action after 3 seconds using a delayed future
    Future.delayed(const Duration(seconds: 3), () {
      FlutterRingtonePlayer.stop();
    });
  }

  void stopBeepSound(BuildContext context) {
    FlutterRingtonePlayer.stop();
    setState(() {
      controller.duration = const Duration(seconds: 10);
    });
    // Navigator.of(context, rootNavigator: true)
    //     .pop(); // Close the dialog using the root navigator
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    controller.addListener(() {
      notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: [
            const Text(
              'Timers',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightblue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.white),
                        child: const Text(
                          'Brushing Timer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 250,
                              height: 250,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey.shade300,
                                value: progress,
                                strokeWidth: 6,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.isDismissed) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                      height: 300,
                                      child: CupertinoTimerPicker(
                                        initialTimerDuration:
                                            controller.duration!,
                                        onTimerDurationChanged: (time) {
                                          setState(() {
                                            controller.duration = time;
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) => Text(
                                  countText,
                                  style: const TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  if (controller.isAnimating) {
                                    controller.stop();
                                    setState(() {
                                      isPlaying = false;
                                    });
                                  } else {
                                    controller.reverse(
                                        from: controller.value == 0
                                            ? 1.0
                                            : controller.value);
                                    setState(() {
                                      isPlaying = true;
                                    });
                                  }
                                },
                                icon: Icon(
                                  isPlaying == true
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  controller.reset();
                                  setState(() {
                                    isPlaying = false;
                                  });
                                },
                                icon: const Icon(
                                  Icons.stop,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightblue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  children: [
                    Text(
                      'Include a reward system that gives points, tokens or stars each time the child brushes their teeth.',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'when children brushes for 7 days a week some reward.',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    Text(
                        'or incorporate songs for 2 minutes to encourage the right length of brushing.',
                        style: TextStyle(color: AppColors.primaryColor))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        radius: 30,
        child: Icon(
          icon,
          size: 36,
        ),
      ),
    );
  }
}
