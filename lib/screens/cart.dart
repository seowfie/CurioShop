import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // Shared Rainbow Gradient from your Dashboard
  static const Gradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFF9C27B0), // 0%
      Color(0xFFFF4081), // 25%
      Color(0xFF00E5FF), // 75%
      Color(0xFFFFD740), // 100%
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050011),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Header: Added Back Button + Your Logo/Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Image.asset('assets/logo.png', width: 65, height: 65),
                  const SizedBox(width: 15),
                  ShaderMask(
                    shaderCallback: (bounds) => rainbowGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      "Cart",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Main Cart Section with your "Dent" design
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 663,
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(37),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.15),
                        offset: const Offset(0, -1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60), 
                      _buildCartItem(),
                      _buildDivider(),
                      _buildCartItem(),
                      _buildDivider(),
                      _buildCartItem(),
                      const Spacer(),
                      
                      // Total Section with your custom clipper
                      ClipPath(
                        clipper: TotalSectionClipper(),
                        child: Container(
                          width: double.infinity,
                          height: 289,
                          color: Colors.white,
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Total Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                  Text("₱ 5,000", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF7A56AE))),
                                ],
                              ),
                              const SizedBox(height: 30),
                              _buildCheckoutButton(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Floating Cylinder in the Top Dent
                Positioned(
                  top: 10,
                  child: Container(
                    width: 60,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7A56AE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      width: 198,
      height: 61,
      decoration: BoxDecoration(
        gradient: rainbowGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4081).withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: const Center(
        child: Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildCartItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0xFFB19DCC), Color(0xFF121212)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Center(child: Image.asset('assets/character.png', width: 63, height: 63)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Herta Kuru-kuru", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                Text("1 piece", style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          const Text("₱ 5,000", style: TextStyle(color: Color(0xFFB19DCC), fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Center(
      child: Container(
        width: 331,
        height: 1,
        color: const Color(0xFF7A56AE).withOpacity(0.5),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomAppBar(
        color: const Color(0xFF121212),
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(Icons.home, color: Colors.grey), onPressed: () => Navigator.pop(context)),
              IconButton(icon: const Icon(Icons.person_outline, color: Colors.grey), onPressed: () => Navigator.pop(context)),
            ],
          ),
        ),
      );
  }
}

class TotalSectionClipper extends CustomClipper<Path> {
  @override
  Path getPath(Size size) {
    Path path = Path();
    double dentWidth = 120;
    double dentHeight = 40;
    path.lineTo((size.width / 2) - (dentWidth / 2) - 20, 0);
    path.lineTo(size.width / 2 - (dentWidth / 2), dentHeight);
    path.lineTo(size.width / 2 + (dentWidth / 2), dentHeight);
    path.lineTo((size.width / 2) + (dentWidth / 2) + 20, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  @override
  Path getClip(Size size) {
    return getPath(size);
  }
}
