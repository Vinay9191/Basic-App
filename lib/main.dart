import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Morning 5:00–11:59, afternoon 12:00–16:59, evening 17:00–20:59, night otherwise.
({String heading, String subtitle}) greetingFor(DateTime time) {
  final hour = time.hour;
  if (hour >= 5 && hour < 12) {
    return (heading: 'Good morning!', subtitle: 'Have a wonderful day!');
  }
  if (hour >= 12 && hour < 17) {
    return (heading: 'Good afternoon!', subtitle: 'Hope your day is going well!');
  }
  if (hour >= 17 && hour < 21) {
    return (heading: 'Good evening!', subtitle: 'Hope you had a great day!');
  }
  return (heading: 'Good night!', subtitle: 'Sleep well and rest up!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.now});

  /// Used in tests so the greeting does not depend on the machine clock.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final greeting = greetingFor(now ?? DateTime.now());

    return MaterialApp(
      title: greeting.heading,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF8E7),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WavingHand(),
                  const SizedBox(height: 24),
                  Text(
                    greeting.heading,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF513A24),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    greeting.subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF715B45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WavingHand extends StatefulWidget {
  const WavingHand({super.key});

  @override
  State<WavingHand> createState() => _WavingHandState();
}

class _WavingHandState extends State<WavingHand>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _wave;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..repeat(reverse: true);
    _wave = Tween<double>(begin: -0.4, end: 0.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _wave,
      builder: (context, child) {
        return Transform.rotate(
          angle: _wave.value * math.pi / 4,
          alignment: Alignment.bottomCenter,
          child: child,
        );
      },
      child: const Text(
        '\u{1F44B}',
        semanticsLabel: 'Waving hand',
        style: TextStyle(fontSize: 88),
      ),
    );
  }
}
