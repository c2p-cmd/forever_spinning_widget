import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Forever Spinning Widget",
      theme: ThemeData.dark(),
      home: const SpinningWidget(),
    );
  }
}

class SpinningWidget extends StatefulWidget {
  const SpinningWidget({super.key});

  @override
  State<SpinningWidget> createState() => _SpinningWidgetState();
}

class _SpinningWidgetState extends State<SpinningWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _reverseController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        seconds: 2,
        milliseconds: 500,
      ),
      vsync: this,
    );
    _reverseController = AnimationController(
      duration: const Duration(
        seconds: 1,
      ),
      vsync: this,
    );
    
    _reverseController.repeat(reverse: true);
    _controller.repeat();
  }

  @override
  void dispose() {
    _reverseController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CupertinoNavigationBar(
        middle: Text("Spinning Widget"),
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            ForeverSpinningItem(
              animationValue: _controller,
              child: const Image(
                image: AssetImage("images/CD.png"),
                height: 120,
              ),
            ),
            ForeverBobbingItem(
              animationValue: _reverseController,
              child: const Image(
                image: AssetImage("images/music.png"),
                height: 55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForeverBobbingItem extends AnimatedWidget {
  final Animation<double> animationValue;
  final Widget child;

  const ForeverBobbingItem({
    super.key,
    required this.child,
    required this.animationValue,
  }) : super(listenable: animationValue);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, animationValue.value * 20),
      child: child,
    );
  }
}

class ForeverSpinningItem extends AnimatedWidget {
  final Animation<double> animationValue;
  final Widget child;

  const ForeverSpinningItem({
    super.key,
    required this.animationValue,
    required this.child,
  }) : super(listenable: animationValue);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animationValue.value * pi * 2.0,
      child: child,
    );
  }
}
