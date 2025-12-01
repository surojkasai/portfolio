import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const NavItem({required this.label, required this.onTap, super.key});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool hover = false;
  double textWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateTextWidth();
  }

  void _calculateTextWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.label,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textWidth = textPainter.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 2,
              width: hover ? textWidth : 0, // <-- dynamic width
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
