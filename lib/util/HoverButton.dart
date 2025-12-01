import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color frColor;
  final Color shdwColor;
  final OutlinedBorder shapeBorder;
  final double? bwidth, bheight;

  const HoverButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.bgColor = Colors.white,
    this.frColor = Colors.black,
    this.shdwColor = Colors.black,
    this.bheight,
    this.bwidth,
    required this.shapeBorder,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 1.0, end: hovered ? 1.05 : 1.0),
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            foregroundColor: widget.frColor,
            backgroundColor: widget.bgColor,
            shadowColor: widget.shdwColor,
            minimumSize:
                (widget.bwidth != null || widget.bheight != null)
                    ? Size(widget.bwidth ?? 0, widget.bheight ?? 0)
                    : null,
            elevation: 6,
            shape: widget.shapeBorder,
            padding: const EdgeInsets.all(12),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
