import 'package:flutter/material.dart';
import 'cart.dart';
import 'login.dart'; 

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _pushNotifications = false;

  static const Gradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFF9C27B0),
      Color(0xFFFF4081),
      Color(0xFF00E5FF),
      Color(0xFFFFD740),
    ],
    begin: Alignment(-0.8, 1.0),
    end: Alignment(0.8, -1.0),
    stops: [0.0, 0.5, 0.75, 1.0],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050011),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Image.asset('assets/logo.png', width: 67, height: 67),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle, 
                      gradient: rainbowGradient
                    ),
                    child: Container(
                      width: 110, 
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1E1E1E),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/character.png',
                          fit: BoxFit.cover,
                          alignment: const Alignment(0, -0.5), 
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ShaderMask(
                    shaderCallback: (bounds) => rainbowGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      "Ruan Mei",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const Text("ruanmei@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: rainbowGradient,
                    ),
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF050011),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        ),
                        child: const Text("Edit Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFF121212),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: Text("GENERAL", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                  _buildProfileItem(icon: Icons.account_balance_wallet, iconColor: const Color(0xFF2C9335), title: "Payment Methods", subtitle: "Visa **34"),
                  _buildProfileItem(icon: Icons.location_on, iconColor: const Color(0xFFB19DCC), title: "Location", subtitle: "Angeles City, Pampanga"),
                  _buildProfileItem(icon: Icons.people, iconColor: const Color(0xFFB19DCC), title: "Social Accounts", subtitle: "Facebook, Instagram"),
                  _buildPushNotifTile(),
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: Text("MORE", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                  _buildProfileItem(icon: Icons.help_outline, iconColor: const Color(0xFFB19DCC), title: "Contact Us"),
                  
                  // --- LOG OUT BUTTON ---
                  _buildProfileItem(
                    icon: Icons.logout, 
                    iconColor: const Color(0xFFFA8D8D), 
                    title: "Log Out", 
                    isLogout: true
                  ),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProfileItem({required IconData icon, required Color iconColor, required String title, String? subtitle, bool isLogout = false}) {
    return GestureDetector(
      onTap: () {
        if (isLogout) {
          // --- NAVIGATION LOGIC FOR LOGOUT ---
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false, 
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 47,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isLogout ? const Color(0xFFFF7A7A).withOpacity(0.22) : Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                  if (subtitle != null) Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPushNotifTile() {
    return Container(
      width: double.infinity,
      height: 47,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.22), borderRadius: BorderRadius.circular(5)),
            child: const Icon(Icons.notifications, color: Color(0xFFF17D01), size: 18),
          ),
          const SizedBox(width: 15),
          const Expanded(child: Text("Push Notification", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
          Transform.scale(
            scale: 0.7,
            child: Switch(
              value: _pushNotifications,
              onChanged: (val) => setState(() => _pushNotifications = val),
              activeColor: const Color(0xFFB19DCC),
              activeTrackColor: const Color(0xFF2E2445),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.white24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: Color(0xFF1B1622),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 28),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage(cartItems: []))),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ShaderMask(
              shaderCallback: (bounds) => rainbowGradient.createShader(bounds),
              child: const Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}


