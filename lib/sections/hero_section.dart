import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:modern_portfolio/sections/spidy_button.dart';
import 'package:modern_portfolio/util/HoverButton.dart';
import 'package:modern_portfolio/util/hovercard.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewMyWork;
  final VoidCallback onLetsConnect;
  const HeroSection({super.key, required this.onLetsConnect, required this.onViewMyWork});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;

  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true); // blinking
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 250),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // important
            children: [
              // small intro text
              const Text(
                "👋 Hi, I am",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white70,
                  fontFamily: "Montserrat-Bold",
                ),
              ),
              const SizedBox(height: 10),

              // big gradient name
              ShaderMask(
                shaderCallback:
                    (bounds) => const LinearGradient(
                      colors: [Colors.white, Colors.grey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Suro",
                          style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "j",
                          style: TextStyle(
                            fontSize: 100, // BIGGER “j”
                            fontWeight: FontWeight.w700,
                            height: 0.8, // pulls it downward
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 210), // adjust this value
                      child: Text(
                        "Kasai",
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w700,
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // animated role
              Row(
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText("Android Developer", speed: Duration(milliseconds: 120)),
                        TyperAnimatedText(
                          "Full Stack Developer",
                          speed: Duration(milliseconds: 120),
                        ),
                        TyperAnimatedText("Backend Enthusiast", speed: Duration(milliseconds: 120)),
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: _cursorController,
                    child: const Text("|", style: TextStyle(fontSize: 28, color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // description paragraph
              const SizedBox(
                width: 700,
                child: Text(
                  "Dedicated to building intuitive, high-performance applications that "
                  "deliver real value. Let’s create something extraordinary together.",
                  style: TextStyle(fontSize: 22, height: 1.5, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 40),

              // buttons
              Row(
                children: [
                  HoverButton(
                    bgColor: Colors.white,
                    frColor: Colors.black,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: widget.onViewMyWork,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      child: Text("View My Work  →", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 20),
                  HoverButton(
                    bgColor: Colors.black,
                    frColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onPressed: widget.onLetsConnect,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                      child: Text("Let's Connect", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // social icons row
              Row(
                children: [
                  HoverButton(
                    onPressed: () {
                      launchURL("https://github.com/surojkasai");
                    },
                    shapeBorder: CircleBorder(),
                    child: Image.asset('assets/github.png', color: Colors.black, height: 30),
                  ),
                  const SizedBox(width: 12),
                  HoverButton(
                    onPressed: () {
                      launchURL("mailto:surojkasai@gmail.com");
                    },
                    shapeBorder: CircleBorder(),
                    child: Icon(Icons.email, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  HoverButton(
                    onPressed: () {
                      launchURL("https://linkedin.com/in/surojkasai");
                    },
                    shapeBorder: CircleBorder(),
                    child: Image.asset('assets/linkedin.png', height: 30),
                  ),
                  const SizedBox(width: 100),

                  FloatingSpiderButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
