import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Toggle States
  bool _pushNotifications = true;
  bool _promoNotifications = false;

  // Shared Rainbow Gradient
  static const Gradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFF9C27B0), // Purple
      Color(0xFFFF4081), // Pink
      Color(0xFF00E5FF), // Cyan
      Color(0xFFFFD740), // Gold/Yellow
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050011), // Deep Dark Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // --- PROFILE HEADER (Avatar & Name) ---
            Center(
              child: Column(
                children: [
                  // Gradient Border Avatar
                  Container(
                    padding: const EdgeInsets.all(3), // Border width
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: rainbowGradient,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2), // Gap between border and image
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF050011),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/character.png'), // Reusing your asset
                        backgroundColor: Colors.white10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Gradient Name
                  ShaderMask(
                    shaderCallback: (bounds) => rainbowGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      "Hannah Turin",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "hannah.turin@email.com",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 15),
                  
                  // Edit Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E1E1E),
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.purpleAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: const Text("Edit Profile"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --- CONTENT CARD (Like Splash Screen) ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFF121212), // Card Color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SECTION: GENERAL
                  _buildSectionHeader("GENERAL"),
                  _buildListTile(icon: Icons.credit_card, title: "Payment Methods", subtitle: "Visa  **34"),
                  _buildListTile(icon: Icons.location_on_outlined, title: "Locations", subtitle: "2 saved locations"),
                  _buildListTile(icon: Icons.people_outline, title: "Social Accounts", subtitle: "Facebook, Twitter"),

                  const SizedBox(height: 25),

                  // SECTION: NOTIFICATIONS
                  _buildSectionHeader("NOTIFICATIONS"),
                  _buildSwitchTile(
                    title: "Push Notifications", 
                    value: _pushNotifications, 
                    onChanged: (v) => setState(() => _pushNotifications = v)
                  ),
                  _buildSwitchTile(
                    title: "Promotional Notifications", 
                    value: _promoNotifications, 
                    onChanged: (v) => setState(() => _promoNotifications = v)
                  ),

                  const SizedBox(height: 25),

                  // SECTION: MORE
                  _buildSectionHeader("MORE"),
                  _buildListTile(icon: Icons.help_outline, title: "Contact Us"),
                  _buildListTile(icon: Icons.logout, title: "Logout", isDestructive: true),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // --- Bottom Nav (Visual Only for consistency) ---
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF121212),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(Icons.home_outlined, color: Colors.grey), onPressed: () {}),
              IconButton(icon: const Icon(Icons.favorite_border, color: Colors.grey), onPressed: () {}),
              const SizedBox(width: 40), 
              IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey), onPressed: () {}),
              // Profile is active here (Purple)
              IconButton(icon: const Icon(Icons.person, color: Color(0xFF9C27B0)), onPressed: () {}),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: rainbowGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.qr_code_scanner),
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon, 
    required String title, 
    String? subtitle, 
    bool isDestructive = false
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isDestructive ? Colors.red.withOpacity(0.1) : const Color(0xFF9C27B0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon, 
              color: isDestructive ? Colors.redAccent : const Color(0xFF9C27B0), 
              size: 20
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? Colors.redAccent : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ]
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title, 
    required bool value, 
    required Function(bool) onChanged
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.notifications_none, color: Colors.cyanAccent, size: 20),
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFFD740), // Gold toggle
            activeTrackColor: Colors.purple.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}