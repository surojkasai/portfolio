import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_portfolio/util/hovercard.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final List<Map<String, String>> stats = [
    {'value': '10+', 'label': 'Projects'},
    {'value': '2+', 'label': 'Clients'},
    {'value': '1', 'label': 'Years Experience'},
    {'value': '50+', 'label': 'Commits'},
  ];
  bool _animate = false; // controls animation
  bool _animateStats = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        double titleSize = screenWidth < 600 ? 20 : 30;
        double paragraphSize = screenWidth < 600 ? 14 : 18;
        double cardWidth = screenWidth < 1100 ? screenWidth * 0.9 : 1000;

        return SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "About me",
                      style: TextStyle(fontSize: titleSize, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                VisibilityDetector(
                  key: Key('ideas-text'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.1 && !_animate) {
                      setState(() {
                        _animate = true;
                      });
                    }
                  },
                  child:
                      _animate
                          ? AnimatedTextKit(
                            repeatForever: true,
                            pause: Duration.zero,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                'Ideas to execution',
                                speed: const Duration(milliseconds: 400),
                                textStyle: GoogleFonts.inter(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600,
                                ),
                                colors: [Colors.white, Colors.white12, Colors.white24],
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ).animate().slide(
                            begin: Offset(-1, 0),
                            end: Offset(0, 0),
                            duration: 1000.ms,
                          )
                          : Text(
                            "Ideas to execution",
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                ),

                const SizedBox(height: 30),
                Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),

                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 48, 48, 48),
                        blurRadius: 14,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "I'm a Flutter Developer who builds clean, scalable apps that actually solve problems.",
                        style: TextStyle(
                          fontSize: paragraphSize + 6,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "I solve complex, real-world problems by designing practical software solutions. I optimize data flows to prevent bottlenecks and ensure smooth operations, implement safeguards that protect sensitive information without slowing processes, and create interfaces that make complex systems intuitive for users. Every challenge I address is an opportunity to simplify, accelerate, and improve the way technology serves people.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: paragraphSize + 4,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "When I’m not coding, I’m usually experimenting — trying new packages, improving UI patterns, setting up backend workflows, or learning whatever I need to make the next feature better. ",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: paragraphSize + 4,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: stats.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 14,
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 60,
                              childAspectRatio: 1.8,
                            ),
                            itemBuilder: (context, index) {
                              // Extract numeric value from string like "10+"
                              final targetValue =
                                  int.tryParse(
                                    stats[index]['value']!.replaceAll(RegExp(r'[^0-9]'), ''),
                                  ) ??
                                  0;

                              return VisibilityDetector(
                                key: Key('stat-$index'),
                                onVisibilityChanged: (info) {
                                  if (info.visibleFraction > 0.1 && !_animateStats) {
                                    setState(() {
                                      _animateStats = true;
                                    });
                                  }
                                },
                                child: HoverCard(
                                  borderRadius: 12,
                                  borderWidth: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AnimatedFlipCounter(
                                        value: _animateStats ? targetValue : 0,
                                        duration: const Duration(seconds: 2),
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        stats[index]['label']!,
                                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
