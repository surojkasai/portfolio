import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modern_portfolio/sections/spidy_button.dart';
import 'package:modern_portfolio/util/HoverButton.dart';
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
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;
    final bool isTablet = size.width < 900;

    // dynamic font sizes
    final double nameSize = isMobile ? 55 : (isTablet ? 80 : 100);
    final double roleSize = isMobile ? 20 : 28;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 50 : 100,
        left: isMobile ? 20 : (isTablet ? 60 : 250),
        right: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // intro text
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/Hello.gif", color: Colors.white, height: isMobile ? 60 : 90),
                  const SizedBox(width: 12),
                  AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      ColorizeAnimatedText(
                        ',i am ',
                        textStyle: GoogleFonts.inter(
                          fontSize: isMobile ? 28 : 40,
                          fontWeight: FontWeight.w600,
                        ),
                        colors: const [
                          Colors.white,
                          Colors.white12,
                          Colors.white24,
                          Colors.white30,
                          Colors.white38,
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // NAME
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
                      children: [
                        Text(
                          "Suro",
                          style: TextStyle(
                            fontSize: nameSize,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "j",
                          style: TextStyle(
                            fontSize: nameSize,
                            fontWeight: FontWeight.w700,
                            height: 0.8,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 100 : (isTablet ? 150 : 210)),
                      child: Text(
                        "Kasai",
                        style: TextStyle(
                          fontSize: nameSize,
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
                    style: TextStyle(
                      fontSize: roleSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TyperAnimatedText(
                          "Android Developer",
                          speed: const Duration(milliseconds: 120),
                        ),
                        TyperAnimatedText(
                          "Full Stack Developer",
                          speed: const Duration(milliseconds: 120),
                        ),
                        TyperAnimatedText(
                          "Backend Enthusiast",
                          speed: const Duration(milliseconds: 120),
                        ),
                      ],
                    ),
                  ),
                  FadeTransition(
                    opacity: _cursorController,
                    child: Text("|", style: TextStyle(fontSize: roleSize, color: Colors.white)),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // description
              SizedBox(
                width: isMobile ? size.width * 0.9 : 700,
                child: Text(
                  "Dedicated to building intuitive, high-performance applications that "
                  "deliver real value. Let’s create something extraordinary together.",
                  style: TextStyle(fontSize: isMobile ? 16 : 22, height: 1.5, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 40),

              // buttons
              isMobile
                  ? Column(
                    children: [
                      HoverButton(
                        bgColor: Colors.white,
                        frColor: Colors.black,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: widget.onViewMyWork,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          child: Text("View My Work  →", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      HoverButton(
                        bgColor: Colors.black,
                        frColor: Colors.white,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: widget.onLetsConnect,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          child: Text("Let's Connect", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      HoverButton(
                        bgColor: Colors.white,
                        frColor: Colors.black,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: widget.onLetsConnect,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                          child: Text("Let's Connect", style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ],
                  ),

              const SizedBox(height: 50),

              // socials responsive wrap
              Wrap(
                spacing: 12,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  HoverButton(
                    onPressed: () => launchURL("https://github.com/surojkasai"),
                    shapeBorder: const CircleBorder(),
                    child: Image.asset('assets/github.png', color: Colors.black, height: 30),
                  ),
                  HoverButton(
                    onPressed: () => launchURL("mailto:surojkasai@gmail.com"),
                    shapeBorder: const CircleBorder(),
                    child: const Icon(Icons.email, color: Colors.black),
                  ),
                  HoverButton(
                    onPressed: () => launchURL("https://linkedin.com/in/surojkasai"),
                    shapeBorder: const CircleBorder(),
                    child: Image.asset('assets/linkedin.png', height: 30),
                  ),
                  const SizedBox(width: 20),
                  if (!isMobile) FloatingSpiderButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
