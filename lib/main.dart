import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:modern_portfolio/sections/services_section.dart';
import 'package:particles_fly/particles_fly.dart';

import 'package:modern_portfolio/sections/about.dart';
import 'package:modern_portfolio/sections/footer.dart';
import 'package:modern_portfolio/sections/hero_section.dart';
import 'package:modern_portfolio/sections/project.dart';
import 'package:modern_portfolio/sections/skills.dart';
import 'package:modern_portfolio/util/NavItem.dart';
import 'package:modern_portfolio/util/particle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suroj Kasai',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Suroj .'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final herokey = GlobalKey();
  final aboutKey = GlobalKey();
  final skillsKey = GlobalKey();
  final projectsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final contactkey = GlobalKey();

  void scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 700;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      // Colors.grey[900]

      // ----------------------
      // DRAWER (FOR MOBILE)
      // ----------------------
      drawer:
          isMobile
              ? Drawer(
                backgroundColor: Colors.black,
                child: ListView(
                  children: [
                    DrawerHeader(
                      child: Text(
                        widget.title,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      title: const Text("About", style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),

                    ListTile(
                      title: const Text("Skills", style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context); // close drawer
                        scrollTo(skillsKey);
                      },
                    ),
                    ListTile(
                      title: const Text("Projects", style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),

                    ListTile(
                      title: const Text("Contact", style: TextStyle(color: Colors.white)),
                      onTap: () {},
                    ),
                  ],
                ),
              )
              : null,

      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white70,

        // MOBILE: Show hamburger menu
        leading:
            isMobile
                ? Builder(
                  builder:
                      (context) => IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                )
                : null,

        // TITLE
        title: DefaultTextStyle(
          style: const TextStyle(),
          child: AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            pause: Duration.zero,
            animatedTexts: [
              ColorizeAnimatedText(
                widget.title,
                speed: const Duration(milliseconds: 400),
                textStyle: const TextStyle(fontSize: 35),
                colors: [Colors.white, Colors.lightBlueAccent],
              ),
            ],
          ),
        ),

        // DESKTOP: AppBar buttons in a Wrap for spacing
        actions:
            isMobile
                ? null
                : [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Wrap(
                      spacing: 24,
                      children: [
                        NavItem(label: "Home", onTap: () => scrollTo(herokey)),
                        NavItem(label: "About", onTap: () => scrollTo(aboutKey)),
                        NavItem(label: "Skills", onTap: () => scrollTo(skillsKey)),
                        NavItem(label: "Projects", onTap: () => scrollTo(projectsKey)),

                        NavItem(label: "Contact", onTap: () => scrollTo(contactkey)),
                      ],
                    ),
                  ),
                ],
      ),

      // MAIN BODY
      body: Stack(
        children: [
          Positioned.fill(
            child: ParticlesFly(
              numberOfParticles: 60,
              speedOfParticles: 1.5,
              particleColor: Colors.blue,
              connectDots: true,
              awayAnimationCurve: Curves.slowMiddle,
              maxParticleSize: 4,
              height: size.height,
              width: size.width,
            ),
            // ParticleBackground()
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                KeyedSubtree(
                  key: herokey,
                  child: HeroSection(
                    onLetsConnect: () => scrollTo(contactkey),
                    onViewMyWork: () => scrollTo(projectsKey),
                  ),
                ),
                const SizedBox(height: 100),
                KeyedSubtree(key: aboutKey, child: const About()),
                KeyedSubtree(key: skillsKey, child: Skills()),
                KeyedSubtree(key: projectsKey, child: ProjectSection()),
                KeyedSubtree(key: contactkey, child: Footer()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
