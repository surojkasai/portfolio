import 'package:flutter/material.dart';

class FloatingSpiderButton extends StatefulWidget {
  const FloatingSpiderButton({super.key});

  @override
  State<FloatingSpiderButton> createState() => _FloatingSpiderButtonState();
}

class _FloatingSpiderButtonState extends State<FloatingSpiderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true); // continuously go up and down

    _animation = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(offset: Offset(0, _animation.value), child: child);
      },
      child: GestureDetector(
        onTap: () {
          print("Scroll down clicked");
        },
        child: Image.asset('assets/spidy.png', height: 50, width: 60),
      ),
    );
  }
}
