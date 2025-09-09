import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intro_slider/intro_slider.dart';

class InstructionsScreen extends ConsumerStatefulWidget {
  const InstructionsScreen({super.key});
  @override
  InstructionsScreenState createState() => InstructionsScreenState();
}

class InstructionsScreenState extends ConsumerState<InstructionsScreen> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
        title: "Welcome",
        description:
        "Welcome in DriveSense App , where you can monitor drivers",
        pathImage: "assets/steps/welcome.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Connect Raspberry Pi",
        description:
        "make sure that you connect the raspberry pi to the internet",
        pathImage: "assets/steps/connect.png",
        backgroundColor: Color(0xff203152),
      ),
    );
    listContentConfig.add(
      const ContentConfig(
        title: "Get Started",
        description:
        "Go to Drive page and start driving",
        pathImage: "assets/steps/get_started.png",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: listContentConfig,
      isShowDoneBtn: false,
      isShowSkipBtn: false,
      isShowPrevBtn: false,
      isShowNextBtn: false,
    );
  }
}

