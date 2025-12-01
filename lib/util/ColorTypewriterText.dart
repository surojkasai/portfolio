// import 'dart:async';
// import 'package:flutter/material.dart';

// class ColorTypewriterText extends StatefulWidget {
//   final String text;
//   final Duration typingSpeed;
//   final List<Color> colors;
//   final TextStyle style;

//   const ColorTypewriterText({
//     super.key,
//     required this.text,
//     this.typingSpeed = const Duration(milliseconds: 100),
//     required this.colors,
//     this.style = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//   });

//   @override
//   State<ColorTypewriterText> createState() => _ColorTypewriterTextState();
// }

// class _ColorTypewriterTextState extends State<ColorTypewriterText> {
//   String visibleText = "";
//   int colorIndex = 0;
//   late Timer typingTimer;
//   late Timer colorTimer;

//   @override
//   void initState() {
//     super.initState();

//     // Typewriter animation
//     int index = 0;
//     typingTimer = Timer.periodic(widget.typingSpeed, (timer) {
//       if (index < widget.text.length) {
//         setState(() {
//           visibleText += widget.text[index];
//         });
//         index++;
//       } else {
//         typingTimer.cancel();
//       }
//     });

//     // Color cycling
//     colorTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
//       setState(() {
//         colorIndex = (colorIndex + 1) % widget.colors.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     typingTimer.cancel();
//     colorTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(visibleText, style: widget.style.copyWith(color: widget.colors[colorIndex]));
//   }
// }
