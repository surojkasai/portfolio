import 'package:flutter/material.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  // Skill data with icons,image
  final List<Map<String, dynamic>> frontend = [
    {"name": "Flutter ", "icon": Image.asset("assets/flutter.png", color: Colors.white)},
    {"name": "TypeScript", "icon": Icons.code, "level": "Advanced"},
    {"name": "Tailwind CSS", "icon": Icons.palette, "level": "Expert"},
  ];

  final List<Map<String, dynamic>> backend = [
    {"name": ".Net", "icon": Icons.storage},
    {"name": "Redis", "icon": Image.asset("db.png", color: Colors.white)},
    {"name": "Hive", "icon": Image.asset("db.png", color: Colors.white)},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int columns;
    if (width > 1100) {
      columns = 3;
    } else if (width > 750) {
      columns = 2;
    } else {
      columns = 1;
    }

    final List<Widget> data = [
      _buildColumn("Frontend", frontend),
      _buildColumn("Backend", backend),
    ];

    return Padding(
      padding: const EdgeInsets.all(40),
      child: LayoutBuilder(
        builder: (_, __) {
          return Wrap(
            spacing: 30,
            runSpacing: 30,
            children:
                data
                    .map(
                      (col) => SizedBox(
                        width: width / columns - (30 * (columns - 1) / columns),
                        child: col,
                      ),
                    )
                    .toList(),
          );
        },
      ),
    );
  }

  Widget _buildColumn(String title, List<Map<String, dynamic>> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Column title
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        // Skill cards
        Column(
          children:
              skills
                  .map(
                    (skill) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: _SkillCard(skill),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

// Hoverable Skill Card
class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> skill;
  const _SkillCard(this.skill);

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool hovered = false;
  Widget _buildIcon(dynamic icon) {
    if (icon is Image) {
      return SizedBox(width: 28, height: 28, child: icon);
    } else if (icon is IconData) {
      return Icon(icon, size: 24, color: Colors.white);
    } else {
      return const SizedBox.shrink(); // safety fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1, end: hovered ? 1.03 : 1),
        duration: const Duration(milliseconds: 150),
        builder: (context, scale, child) => Transform.scale(scale: scale, child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 90, // fixed height for all cards
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: hovered ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.05),
            boxShadow:
                hovered
                    ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.15),
                        blurRadius: 14,
                        spreadRadius: 1,
                      ),
                    ]
                    : [],
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // center content
            children: [
              _buildIcon(widget.skill['icon']),

              const SizedBox(width: 12),
              Text(
                widget.skill['name'],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
