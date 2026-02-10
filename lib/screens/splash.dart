import 'package:flutter/material.dart';
import 'login.dart'; // Import the login page so we can navigate to it

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Keep the gradient here for the Splash text/button
  static const Gradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFF9C27B0),
      Color(0xFFFF4081),
      Color(0xFF00E5FF),
      Color(0xFFFFD740),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050011),
      body: Stack(
        children: [
          // 1. Background Glow
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6200EA).withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6200EA).withOpacity(0.4),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // 2. LOGO (Top Left)
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Image.asset(
                  'assets/logo.png',
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (c, o, s) => const Icon(Icons.star, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),

          // 3. Main Content
          Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purpleAccent.withOpacity(0.2),
                                blurRadius: 80,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/character.png',
                          fit: BoxFit.contain,
                          errorBuilder: (c, o, s) => const Icon(Icons.auto_fix_high, size: 150, color: Colors.white24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  // --- FIX: Reduced vertical padding from 30 to 20 to solve overflow ---
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    border: Border(top: BorderSide(color: Colors.white10, width: 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ShaderMask(
                        shaderCallback: (bounds) => rainbowGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: const Text(
                          "Shop the Figures You Love",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Explore high-quality figurines and bring your favorite characters home with just a few taps.",
                        style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: rainbowGradient,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
