import 'dart:math';

import 'package:flutter/material.dart';

class SnaowMan extends StatefulWidget {
  const SnaowMan({super.key});

  @override
  State<SnaowMan> createState() => _SnaowManState();
}

class _SnaowManState extends State<SnaowMan>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<SnowFlake> snowFlakes = List.generate(1000, (index) => SnowFlake());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snow Man'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.95],
          ),
        ),
        child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              for (var snowFlake in snowFlakes) {
                snowFlake.fall();
              }
              return CustomPaint(painter: MyPainter(snowFlakes));
            }),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  late List<SnowFlake> snowFlakes;

  MyPainter(this.snowFlakes);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      size.center(const Offset(0, 80)),
      40,
      Paint()..color = Colors.white,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: size.center(const Offset(0, 250)),
        width: 200,
        height: 300,
      ),
      Paint()..color = Colors.white,
    );
    for (var snowFlake in snowFlakes) {
      canvas.drawCircle(
        snowFlake.offset,
        snowFlake.radius,
        Paint()..color = Colors.white,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SnowFlake {
  late Offset offset;
  late double radius;
  late double velocity;

  SnowFlake() {
    final random = Random();
    offset = Offset(random.nextDouble() * 420, random.nextDouble() * 800);
    radius = random.nextDouble() * 2 + 2;
    velocity = random.nextDouble() * 4 + 2;
  }

  void fall() {
    double y = offset.dy + velocity;
    if (y > 800) {
      final random = Random();
      offset = Offset(random.nextDouble() * 420, 0);
      radius = random.nextDouble() * 2 + 2;
      velocity = random.nextDouble() * 4 + 2;
    } else {
      offset = Offset(offset.dx, y);
    }
  }
}
