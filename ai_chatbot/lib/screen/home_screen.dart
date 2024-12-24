import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/global.dart';
import '../model/home_type.dart';
import '../widget/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    //initializing device size
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text(appName),
      ),

      //body
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .025),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      ),
    );
  }
}
