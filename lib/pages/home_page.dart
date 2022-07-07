// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redio/model/radio.dart';
import 'package:redio/utils/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyRadio> radios;
  @override
  void initState() {
    super.initState();
    fetchRadios();
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(
                LinearGradient(colors: [
                  AiColors.primaryColor1,
                  AiColors.primaryColor2,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              )
              .make(),
          AppBar(
            title: "AI Radio".text.xl4.bold.white.make().shimmer(
                  primaryColor: Vx.purple300,
                  secondaryColor: Colors.white,
                ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
          ).h(100.0).p16(),
          VxSwiper.builder(
            itemCount: radios.length,
            aspectRatio: 1.0,
            itemBuilder: (context, index) {
              final rad = radios[index];

              return VxBox(child: ZStack([]))
                  .bgImage(DecorationImage(
                    image: NetworkImage(rad.image),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                  ))
                  .withRounded(value: 60.0)
                  .make()
                  .p16();
            },
          ),
        ],
      ),
    );
  }
}
