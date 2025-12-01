import 'package:flutter/material.dart';
import 'package:modern_portfolio/util/HoverButton.dart';
import 'package:modern_portfolio/util/hovercard.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    bool isSmall = size.width < 600;
    bool isMedium = size.width >= 600 && size.width < 900;
    bool isLarge = size.width >= 900;

    return Container(
      width: double.infinity,
      color: Colors.grey[780],
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Let's Create Something Amazing",
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Have a project in mind? Let's discuss how we can work together.",
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // CONTACT CARDS - RESPONSIVE WIDTH
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: isSmall ? size.width * 0.9 : 220,
                child: _ContactCard(
                  icon: Icons.email,
                  title: "Email",
                  subtitle: "Drop me a line",
                  info: "surojkasai@gmail.com",
                  url: "mailto:surojkasai@gmail.com",
                ),
              ),
              SizedBox(
                width: isSmall ? size.width * 0.9 : 220,
                child: _ContactCard(
                  icon: Icons.business,
                  title: "LinkedIn",
                  subtitle: "Let's connect",
                  info: "@surojkasai",
                  url: "https://linkedin.com/in/surojkasai",
                ),
              ),
              SizedBox(
                width: isSmall ? size.width * 0.9 : 220,
                child: _ContactCard(
                  icon: Icons.code,
                  title: "GitHub",
                  subtitle: "Check my code",
                  info: "@surojkasai",
                  url: "https://github.com/surojkasai",
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // MESSAGE FORM + INFO CARDS SECTION
          LayoutBuilder(
            builder: (context, constraints) {
              double maxWidth = constraints.maxWidth;

              return Column(
                children: [
                  // If small/medium → stack
                  if (!isLarge) ...[
                    _buildMessageForm(size),
                    const SizedBox(height: 20),
                    _buildInfoCardsStacked(),
                  ],

                  // If large → side by side
                  if (isLarge)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMessageForm(size),
                        const SizedBox(width: 20),
                        _buildInfoCardsSide(),
                      ],
                    ),
                ],
              );
            },
          ),

          const SizedBox(height: 40),
          const Divider(color: Colors.grey),
          const SizedBox(height: 20),
          const Text(
            "© 2025 Suroj Kasai. All rights reserved.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ------------------------
  // MESSAGE FORM (Reusable)
  // ------------------------
  Widget _buildMessageForm(Size size) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Container(
      width: size.width > 900 ? 400 : size.width * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          const Text(
            "Send a Quick Message",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          _CustomTextField(hint: "Your Name", controller: nameController),
          const SizedBox(height: 10),

          _CustomTextField(hint: "Your Email", controller: emailController),
          const SizedBox(height: 10),

          _CustomTextField(hint: "Your Message", maxLines: 4, controller: messageController),
          const SizedBox(height: 15),

          HoverCard(
            borderRadius: 12,
            blrradius: 6,
            bxshdw: Colors.white,
            borderWidth: 0,
            color: Colors.transparent,
            child: ElevatedButton.icon(
              onPressed: () async {
                final name = nameController.text;
                final email = emailController.text;
                final msg = messageController.text;

                final uri = Uri(
                  scheme: 'mailto',
                  path: 'surojkasai@gmail.com',
                  queryParameters: {
                    'subject': 'Portfolio Contact from $name',
                    'body': 'Name: $name\nEmail: $email\n\nMessage:\n$msg',
                  },
                );

                if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                  throw Exception("Could not launch email client");
                }
              },
              icon: const Icon(Icons.send),
              label: const Text("Send Message"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------
  // INFO CARDS - STACKED (Small / Medium)
  // ------------------------
  Widget _buildInfoCardsStacked() {
    return Column(
      children: const [
        _InfoCard(icon: Icons.access_time, title: "Response Time", info: "Usually within 24 hours"),
        SizedBox(height: 15),
        _InfoCard(icon: Icons.location_on, title: "Location", info: "Kathmandu, Nepal (UTC+5:45)"),
        SizedBox(height: 15),
        _InfoCard(icon: Icons.work, title: "Work Preference", info: "Remote & Contract Projects"),
      ],
    );
  }

  // ------------------------
  // INFO CARDS - SIDE BY SIDE (Large)
  // ------------------------
  Widget _buildInfoCardsSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _InfoCard(icon: Icons.access_time, title: "Response Time", info: "Usually within 24 hours"),
        SizedBox(height: 15),
        _InfoCard(icon: Icons.location_on, title: "Location", info: "Kathmandu, Nepal (UTC+5:45)"),
        SizedBox(height: 15),
        _InfoCard(icon: Icons.work, title: "Work Preference", info: "Remote & Contract Projects"),
      ],
    );
  }
}

// Contact Card
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String info;
  final String? url;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.info,
    this.url,
  });

  void launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (url != null) {
            launchURL(url!);
          }
        },
        child: HoverCard(
          borderRadius: 12,
          borderWidth: 0,

          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 5),
              Text(info, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// Info Card
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;

  const _InfoCard({required this.icon, required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      child: HoverCard(
        borderRadius: 12,
        borderWidth: 0,
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(info, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Text Field
class _CustomTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const _CustomTextField({required this.hint, this.maxLines = 1, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      ),
    );
  }
}
