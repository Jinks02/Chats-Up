import 'dart:math';

import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/reusable_button.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

const colorizeColors = [
  Colors.blue,
  Colors.purple,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
    fontSize: 43.0, fontFamily: 'Horizon', fontWeight: FontWeight.bold);

class WelcomeScreen extends StatefulWidget {
  static const String id =
      'welcomeScreen'; // with static, no need to create an entire object just to tap into its id
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  //Single for to enable our screen's state to act as a ticker provider for single animation,for multiple, remove single

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // 'this' means that the state object is going to be the vsync
    // for curved animation upper bound cannot be >1

    // controller.reverse(from: 1); // animation from large to small
    controller
        .forward(); // on completion of forward, animation status is completed, for reverse its dismissed

    controller.addListener(() {
      setState(() {}); // to enable animation to actually happen on the screen
      // log(controller
      //     .value); // prints different values of animations taking place
    });
    // animation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.white)
    //     .animate(controller);

    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    // animation.addStatusListener((status) { // infinite looping animation
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller
        .dispose(); // closing the controller when the state is destroyed or screen is changed, so that it does not keep going on in bg and consuming resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: animation.value, // animating this property using values
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                      child: Image.asset('images/logo.png'),
                      height: animation.value *
                          90 // animation.value goes from 0 to 1,
                      // height: 60,
                      ),
                ),
                // SizedBox(
                //   child: DefaultTextStyle(
                //     style: const TextStyle(
                //         fontSize: 45.0,
                //         fontWeight: FontWeight.w900,
                //         color: Colors.black),
                //     child: AnimatedTextKit(
                //       animatedTexts: [
                //         TypewriterAnimatedText('Flash Chat'),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Flash Chat',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            ReusableButton(
              title: 'Log In',
              buttonColor: Colors.lightBlueAccent,
              onPressedButton: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ReusableButton(
                buttonColor: Colors.blueAccent,
                title: 'Register',
                onPressedButton: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                })
          ],
        ),
      ),
    );
  }
}
