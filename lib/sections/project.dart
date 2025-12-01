import 'package:flutter/material.dart';
import 'package:modern_portfolio/util/HoverButton.dart';
import 'package:modern_portfolio/util/hovercard.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSection extends StatefulWidget {
  ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> {
  final List<Map<String, dynamic>> projects = const [
    {
      'title': 'BookNest',
      'subtitle': 'E-Commerce web App',
      'image': 'assets/booknest.png',
      'tags': ['Flutter', 'Firebase', 'Firestore', 'Khalti'],
      'description': [
        'Complete e-commerce platform for buying and selling books with secure payments, real-time inventory, and user-friendly browsing.',
      ],
      'types': ['web', 'all'],
      'url': ["https://github.com/surojkasai/BookNest.git"],
    },
    {
      'title': 'ComikSan',
      'subtitle': 'Full-Stack Manga App',
      'image': 'assets/comiksan.jpg',
      'tags': ['Flutter', '.NET', 'Firebase Auth', 'MangaDex API'],
      'description': [
        'Full-stack manga reading application with chapter management, offline support, API-based content fetching, and user authentication.',
      ],
      'types': ['android', 'all'],
      'url': ["https://github.com/surojkasai/ComikSan.git"],
    },
    {
      'title': 'NotePad',
      'subtitle': 'Note taking App',
      'image': 'assets/learn-pad.png',
      'tags': ['Flutter', 'Hive'],
      'description': [
        'Lightweight note-taking app with instant saving, fast search, and task management for everyday productivity.',
      ],
      'types': ['android', 'all'],
      'url': ["https://github.com/surojkasai/NotePad-.git"],
    },
  ];

  final List<String> categories = ['All Projects', 'Web Applications', 'Android Applications'];
  String mapCategoryToType(String cat) {
    switch (cat) {
      case 'Web Applications':
        return 'web';
      case 'Android Applications':
        return 'android';
      default:
        return 'all';
    }
  }

  String selectedCategory = "All Projects";

  List<Map<String, dynamic>> get filteredProjects {
    if (selectedCategory == "All Projects") {
      return projects;
    }

    final type = mapCategoryToType(selectedCategory);

    return projects.where((p) {
      final List t = p['types'];
      return t.contains(type); // ← USE THIS
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount =
        size.width > 1200
            ? 3
            : size.width > 800
            ? 2
            : 1; // responsive columns

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 210),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'PORTFOLIO',
            style: TextStyle(fontSize: 16, color: Colors.grey[400], letterSpacing: 2),
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
              children: [
                TextSpan(text: 'Featured '),
                TextSpan(text: 'Projects', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Explore some of my recent work',
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          // Category Buttons
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children:
                categories.map((cat) {
                  return HoverButton(
                    onPressed: () {
                      setState(() => selectedCategory = cat);
                    },
                    bgColor: Colors.black,
                    frColor: Colors.white,
                    shdwColor: Colors.white,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

                    child: Text(cat),
                  );
                }).toList(),
          ),
          const SizedBox(height: 40),
          // Project Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              return HoverCard(
                borderRadius: 12,
                blrradius: 6,
                padding: EdgeInsets.all(0),
                child: ProjectCard(
                  title: project['title'],
                  subtitle: project['subtitle'],
                  image: project['image'],
                  description: project['description'],
                  tags: List<String>.from(project['tags']),
                  url: project['url'],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final List<String> tags;
  final List<String> description;
  final List<String> url;

  const ProjectCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.tags,
    required this.description,
    required this.url,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(image, fit: BoxFit.cover, height: 180, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                      tags
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(fontSize: 12, color: Colors.white70),
                              ),
                            ),
                          )
                          .toList(),
                ),
                ...description.map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(d, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                  ),
                ),
                SizedBox(height: 16),
                // With this:
                Center(
                  child: Wrap(
                    children:
                        url
                            .map(
                              (link) => HoverButton(
                                bgColor: Colors.grey,

                                onPressed: () async {
                                  final uri = Uri.parse(link);
                                  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                    throw 'Could not launch $link';
                                  }
                                },
                                shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                bwidth: 10,
                                bheight: 30,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Github'),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      'assets/github.png',
                                      width: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
