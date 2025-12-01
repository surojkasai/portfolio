import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  Offset position;
  Offset velocity;
  double radius;
  Color color;
  Offset _impulse = Offset.zero; // temporary force applied

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });

  void move(Size canvasSize) {
    // Apply smooth impulse
    velocity += _impulse;
    _impulse *= 0.9; // decay over time for smooth effect

    position += velocity;

    // Bounce off edges
    if (position.dx <= 0 || position.dx >= canvasSize.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy <= 0 || position.dy >= canvasSize.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }

  void bounceAway(Offset tapPosition, double force) {
    final diff = position - tapPosition;
    final distance = diff.distance;

    if (distance < 50) {
      // only affect nearby particles
      final direction = diff / distance;
      _impulse += direction * force; // add smooth impulse
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double connectDistance;

  ParticlePainter(this.particles, {this.connectDistance = 100});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw particles
    for (var p in particles) {
      paint.color = p.color;
      canvas.drawCircle(p.position, p.radius, paint);
    }

    // Draw connecting lines
    paint.style = PaintingStyle.stroke;
    for (var i = 0; i < particles.length; i++) {
      for (var j = i + 1; j < particles.length; j++) {
        final dist = (particles[i].position - particles[j].position).distance;
        if (dist < connectDistance) {
          paint.color = Colors.white.withOpacity(0.3);
          paint.strokeWidth = 1.5;
          canvas.drawLine(particles[i].position, particles[j].position, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late List<Particle> particles;
  late AnimationController controller;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    final size =
        WidgetsBinding.instance.window.physicalSize /
        WidgetsBinding.instance.window.devicePixelRatio;

    // Initialize particles
    particles = List.generate(80, (_) {
      return Particle(
        position: Offset(random.nextDouble() * size.width, random.nextDouble() * size.height),
        velocity: Offset((random.nextDouble() - 0.5) * 1.5, (random.nextDouble() - 0.5) * 1.5),
        radius: 2 + random.nextDouble() * 2,
        color: const Color.fromARGB(255, 30, 90, 117),
      );
    });

    controller =
        AnimationController(vsync: this, duration: const Duration(hours: 1))
          ..addListener(() {
            setState(() {
              for (var p in particles) p.move(MediaQuery.of(context).size);
            });
          })
          ..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleTap(Offset position) {
    const bounceForce = 1.5; // moderate force for smooth bounce
    for (var p in particles) {
      p.bounceAway(position, bounceForce);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        _handleTap(details.localPosition);
      },
      child: CustomPaint(size: MediaQuery.of(context).size, painter: ParticlePainter(particles)),
    );
  }
}
