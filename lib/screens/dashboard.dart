import 'package:flutter/material.dart';
import 'profile.dart'; // Ensure this file exists
import 'cart.dart';    // Ensure this file exists

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // --- STATE VARIABLES ---
  int _selectedIndex = 0;
  String _searchKeyword = "";
  String _selectedTag = "All";

  // --- STYLE CONSTANTS ---
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

  // --- DATA ---
  final List<String> hotTags = ["All", "Anime", "Western", "K-pop", "Video Game"];

  final List<Map<String, dynamic>> allProducts = [
    {'name': 'Herta Kuru-kuru', 'price': '₱ 5,000', 'image': 'assets/character.png', 'category': 'Anime'},
    {'name': 'Stellar Witch', 'price': '₱ 4,500', 'image': 'assets/character.png', 'category': 'Anime'},
    {'name': 'Iron Man MK50', 'price': '₱ 12,500', 'image': 'assets/character.png', 'category': 'Western'},
    {'name': 'BTS Lightstick', 'price': '₱ 3,200', 'image': 'assets/character.png', 'category': 'K-pop'},
    {'name': 'Master Chief', 'price': '₱ 8,000', 'image': 'assets/character.png', 'category': 'Video Game'},
    {'name': 'Galactic Ranger', 'price': '₱ 6,200', 'image': 'assets/character.png', 'category': 'Anime'},
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return allProducts.where((product) {
      final matchesCategory = _selectedTag == "All" || product['category'] == _selectedTag;
      final matchesSearch = product['name'].toLowerCase().contains(_searchKeyword.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050011),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. MAIN CONTENT AREA
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildHomeContent(),        // Index 0: Home
                const CartPage(),           // Index 1: Cart (External File)
                const ProfilePage(),        // Index 2: Profile (External File)
              ],
            ),
          ),

          // 2. CUSTOM BOTTOM NAVIGATION BAR
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildCustomBottomNavBar(),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 1: HOME CONTENT
  // ==========================================
  Widget _buildHomeContent() {
    bool isFiltering = _searchKeyword.isNotEmpty || _selectedTag != "All";
    
    // Wrapped in SingleChildScrollView so everything (including search bar) scrolls
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 120), // Bottom padding for Nav Bar
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Image.asset('assets/logo.png', height: 50, fit: BoxFit.contain, errorBuilder: (c, o, s) => const Icon(Icons.star, size: 40, color: Colors.white)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => rainbowGradient.createShader(bounds),
                          child: const Text("Welcome", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const Text("What are you looking for today?", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 25),

            // --- HOT TAGS ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("Hot Tags", style: TextStyle(color: Colors.white70, fontSize: 14)),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: hotTags.map((tag) {
                  bool isSelected = _selectedTag == tag;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTag = tag),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.white10,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(tag, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            // --- SEARCH BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        onChanged: (value) => setState(() => _searchKeyword = value),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(hintText: "Looking for something specific?", hintStyle: TextStyle(color: Colors.white38, fontSize: 14), border: InputBorder.none),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.purpleAccent), color: const Color(0xFF121212)),
                    child: const Icon(Icons.search, color: Colors.purpleAccent),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // --- PRODUCT LISTS ---
            isFiltering ? _buildSearchResults() : _buildStandardLayout(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // HELPER WIDGETS
  // ==========================================
  Widget _buildStandardLayout() {
    return Column(
      children: [
        _buildCategoryRow("Featured", allProducts.take(4).toList()),
        const SizedBox(height: 30),
        _buildCategoryRow("Anime", allProducts.where((p) => p['category'] == 'Anime').toList()),
        const SizedBox(height: 30),
        _buildCategoryRow("Western", allProducts.where((p) => p['category'] == 'Western').toList()),
        const SizedBox(height: 30),
        _buildCategoryRow("K-pop", allProducts.where((p) => p['category'] == 'K-pop').toList()),
        const SizedBox(height: 30),
        _buildCategoryRow("Video Game", allProducts.where((p) => p['category'] == 'Video Game').toList()),
      ],
    );
  }

  Widget _buildSearchResults() {
    final results = _filteredProducts;
    if (results.isEmpty) return const Center(child: Text("No items found!", style: TextStyle(color: Colors.grey)));
    
    return GridView.builder(
      shrinkWrap: true, 
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        crossAxisSpacing: 15, 
        mainAxisSpacing: 15, 
        childAspectRatio: 0.75
      ),
      itemCount: results.length,
      itemBuilder: (context, index) => _buildProductCard(results[index], isGrid: true),
    );
  }

  Widget _buildCategoryRow(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const Icon(Icons.more_horiz, color: Colors.purpleAccent),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: items.length,
            itemBuilder: (context, index) => _buildProductCard(items[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, {bool isGrid = false}) {
    return Container(
      width: isGrid ? null : 150,
      margin: isGrid ? null : const EdgeInsets.only(right: 15, bottom: 5),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Center(child: Padding(padding: const EdgeInsets.all(10.0), child: Image.asset(product['image'], fit: BoxFit.contain, errorBuilder: (c, o, s) => const Icon(Icons.image_not_supported, color: Colors.white10, size: 50)))),
                Positioned(top: 10, right: 10, child: Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Color(0xFF9C27B0), shape: BoxShape.circle), child: const Icon(Icons.shopping_bag, size: 14, color: Colors.white))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity, padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(product['name'], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text(product['price'], style: const TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold, fontSize: 14)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CUSTOM NAVBAR
  // ==========================================
  Widget _buildCustomBottomNavBar() {
    const double barHeight = 80;
    return SizedBox(
      height: barHeight + 20,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Background Curve
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, barHeight),
            painter: LiquidCurvePainter(_selectedIndex, 3),
            child: Container(height: barHeight),
          ),
          
          // Icon Row
          SizedBox(
            height: barHeight + 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildNavItem(0, 'assets/home.png'),
                _buildNavItem(1, 'assets/cart.png'),
                _buildNavItem(2, 'assets/profile.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: 70, 
        height: 100, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              // Lift margin: 25px when selected, 20px when not
              margin: EdgeInsets.only(bottom: isSelected ? 25 : 20), 
              
              // --- ICON SIZES (UPDATED) ---
              // Selected: 45px
              // Unselected: 38px (Increased from 30)
              height: isSelected ? 45 : 38, 
              width: isSelected ? 45 : 38,
              
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                shape: BoxShape.circle,
                boxShadow: isSelected
                    ? [BoxShadow(color: Colors.purpleAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))]
                    : null,
              ),
              child: isSelected
                  ? ShaderMask(
                      shaderCallback: (bounds) => rainbowGradient.createShader(bounds),
                      child: Image.asset(iconPath, color: Colors.white, fit: BoxFit.contain),
                    )
                  : Image.asset(iconPath, color: Colors.white70, fit: BoxFit.contain),
            ),
            const SizedBox(height: 15), 
          ],
        ),
      ),
    );
  }
}

// ================= PAINTER =================

class LiquidCurvePainter extends CustomPainter {
  final int selectedIndex;
  final int itemsCount;
  LiquidCurvePainter(this.selectedIndex, this.itemsCount);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF1A1A2E)..style = PaintingStyle.fill;
    final path = Path();
    double itemWidth = size.width / itemsCount;
    double center = (selectedIndex * itemWidth) + (itemWidth / 2);
    
    path.moveTo(0, 0); 
    path.lineTo(center - 60, 0);
    // Smooth curve -25px depth
    path.cubicTo(center - 30, 0, center - 35, -25, center, -25);
    path.cubicTo(center + 35, -25, center + 30, 0, center + 60, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawShadow(path, Colors.black.withOpacity(0.5), 8.0, true);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant LiquidCurvePainter oldDelegate) => oldDelegate.selectedIndex != selectedIndex;
}
