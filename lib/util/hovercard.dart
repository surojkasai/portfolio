import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius, blrradius;
  final Color color, bxshdw;
  final double borderWidth;
  final VoidCallback? onTap; // NEW

  const HoverCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.color = Colors.black,
    this.bxshdw = Colors.white,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.blrradius = 12,
    this.onTap, // NEW
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: hovered ? 1.05 : 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.borderWidth > 0 ? Border.all(width: widget.borderWidth) : null,
            boxShadow:
                hovered ? [BoxShadow(color: widget.bxshdw, blurRadius: widget.blrradius)] : [],
          ),
          child:
              widget.onTap != null
                  ? InkWell(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    onTap: widget.onTap,
                    child: widget.child,
                  )
                  : widget.child,
        ),
      ),
    );
  }
}
