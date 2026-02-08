import 'package:flutter/material.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  // Gradient for text/buttons
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const SizedBox(height: 40),
              
              // 1. LOGO
              Image.asset(
                'assets/logo.png',
                height: 80, 
                fit: BoxFit.contain,
                errorBuilder: (c, o, s) => const Icon(Icons.star, size: 80, color: Colors.white),
              ),
              
              const SizedBox(height: 40),

              // 2. TITLE "Let's Sign You In"
              ShaderMask(
                shaderCallback: (bounds) => rainbowGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const Text(
                  "Let's Sign You In",
                  style: TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // 3. SUBTITLE
              const Text(
                "Start your curio shopping now!",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              
              const SizedBox(height: 50),

              // 4. EMAIL FIELD (Floating Label)
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  // LABEL ANIMATION LOGIC:
                  labelText: 'Email Address', 
                  labelStyle: const TextStyle(color: Colors.grey), // Color when inside
                  floatingLabelStyle: const TextStyle(color: Color(0xFF9C27B0)), // Color when up top
                  
                  hintText: 'ruanmei@gmail.com',
                  hintStyle: const TextStyle(color: Colors.white38),
                  
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF9C27B0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // 5. PASSWORD FIELD (Floating Label)
              TextField(
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  // LABEL ANIMATION LOGIC:
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.grey),
                  floatingLabelStyle: const TextStyle(color: Color(0xFF9C27B0)),

                  hintText: '••••••',
                  hintStyle: const TextStyle(color: Colors.white38),
                  
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF9C27B0)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              
              const SizedBox(height: 15),

              // 6. REMEMBER ME & FORGOT PASSWORD
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: const Color(0xFF9C27B0),
                          checkColor: Colors.white,
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text("Remember Me", style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password ?", style: TextStyle(color: Colors.purpleAccent)),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),

              // 7. LOGIN BUTTON (Gradient)
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: rainbowGradient,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DashboardPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              // 8. SIGN UP LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account ? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {},
                    child: ShaderMask(
                      shaderCallback: (bounds) => rainbowGradient.createShader(bounds),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
