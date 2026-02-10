import 'package:flutter/material.dart';
import 'profile.dart'; 
import 'cart.dart';    

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
  
  // Cart Logic
  final List<Map<String, dynamic>> _cartItems = [];

  // --- STYLE CONSTANTS ---
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

  // --- DATA ---
  final List<String> hotTags = ["All", "Anime", "Western", "K-pop", "Video Game"];

  final List<Map<String, dynamic>> allProducts = [
    // --- ANIME ---
    {'name': 'Satoru Gojo 1/7 Scale', 'price': '₱ 7,200', 'image': 'assets/gojo.jpg', 'category': 'Anime', 'featured': true},
    {'name': 'Frieren the Slayer Luminasta', 'price': '₱ 4,800', 'image': 'assets/frieren.jpg', 'category': 'Anime', 'featured': false},
    {'name': 'GSC Ultimate Madoka', 'price': '₱ 15,000', 'image': 'assets/madoka.jpg', 'category': 'Anime', 'featured': false},
    {'name': 'Anya and Bond Forger Sleepy', 'price': '₱ 3,200', 'image': 'assets/anya.jpg', 'category': 'Anime', 'featured': false},

    // --- WESTERN ---
    {'name': 'Winter Soldier Bucky Barnes', 'price': '₱ 12,500', 'image': 'assets/bucky.jpg', 'category': 'Western', 'featured': true},
    {'name': 'Super Mario Original 1/4', 'price': '₱ 25,000', 'image': 'assets/mario.jpg', 'category': 'Western', 'featured': false},
    {'name': 'Iron Man Mark 80 Exclusive', 'price': '₱ 22,000', 'image': 'assets/ironman.jpg', 'category': 'Western', 'featured': false},
    {'name': 'Wonder Woman 1/9 Justice League', 'price': '₱ 9,000', 'image': 'assets/wonderwoman.jpg', 'category': 'Western', 'featured': false},
    {'name': 'Scarlet Witch Darkhold Statue', 'price': '₱ 11,500', 'image': 'assets/scarletwitch.jpg', 'category': 'Western', 'featured': false},

    // --- K-POP ---
    {'name': 'NewJeans Binky Bong', 'price': '₱ 3,500', 'image': 'assets/njz.jpg', 'category': 'K-pop', 'featured': true},
    {'name': 'BTS Army Bomb Ver 4', 'price': '₱ 3,800', 'image': 'assets/bts.jpg', 'category': 'K-pop', 'featured': false},
    {'name': 'TWICE CandyBong', 'price': '₱ 3,500', 'image': 'assets/twice.jpg', 'category': 'K-pop', 'featured': false},
    {'name': 'LE SSERAFIM FimBong', 'price': '₱ 3,600', 'image': 'assets/lesserafim.jpg', 'category': 'K-pop', 'featured': false},

    // --- VIDEO GAME ---
    {'name': 'The Herta Star Rail LIVE Ver.', 'price': '₱ 8,500', 'image': 'assets/herta.jpg', 'category': 'Video Game', 'featured': true},
    {'name': 'Hatsune Miku v3 1/4', 'price': '₱ 18,000', 'image': 'assets/miku.jpg', 'category': 'Video Game', 'featured': false},
    {'name': 'Arataki Itto Fichier ST', 'price': '₱ 9,500', 'image': 'assets/itto.jpg', 'category': 'Video Game', 'featured': false},
  ];

  List<Map<String, dynamic>> get _filteredProducts {
    return allProducts.where((product) {
      final matchesCategory = _selectedTag == "All" || product['category'] == _selectedTag;
      final matchesSearch = product['name'].toLowerCase().contains(_searchKeyword.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // --- LOGIC ---
  void _addToCart(Map<String, dynamic> product) {
    setState(() {
      _cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product['name']} added to cart!",
        style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 800),
        backgroundColor: const Color(0xFF9C27B0),
      ),
    );
  }

  void _removeFromCart(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item removed from cart"),
        duration: Duration(milliseconds: 600),
        backgroundColor: Colors.redAccent,
      ),
    );
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
                _buildHomeContent(),        
                CartPage(
                  cartItems: _cartItems, 
                  onRemove: _removeFromCart,
                ),
                const ProfilePage(),        
              ],
            ),
          ),

          // 2. FLAT BOTTOM NAVIGATION BAR
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
    
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 120),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png', 
                    height: 50, 
                    fit: BoxFit.contain, 
                    errorBuilder: (c, o, s) => const Icon(Icons.star, size: 40, color: Colors.white)
                  ),
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

            // HOT TAGS
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

            // SEARCH BAR
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

            // CONTENT BODY
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
        _buildCategoryRow("Featured", allProducts.where((p) => p['featured'] == true).toList()),
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
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.75
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

  // --- UPDATED PRODUCT CARD TO BE FULL IMAGE ---
  Widget _buildProductCard(Map<String, dynamic> product, {bool isGrid = false}) {
    return Container(
      width: isGrid ? null : 150,
      margin: isGrid ? null : const EdgeInsets.only(right: 15, bottom: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias, // Ensures image respects the rounded corners
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // FULL IMAGE FILL
                Positioned.fill(
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover, // Ensures image fills the entire area
                    errorBuilder: (c, o, s) => const Icon(Icons.image_not_supported, color: Colors.white10, size: 50),
                  ),
                ),
                Positioned(
                  top: 10, right: 10, 
                  child: GestureDetector(
                    onTap: () => _addToCart(product),
                    child: Container(
                      padding: const EdgeInsets.all(6), 
                      decoration: const BoxDecoration(color: Color(0xFF9C27B0), shape: BoxShape.circle), 
                      child: const Icon(Icons.shopping_bag, size: 14, color: Colors.white)
                    ),
                  )
                ),
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
  // FLAT CUSTOM NAVBAR
  // ==========================================
  Widget _buildCustomBottomNavBar() {
    return Container(
      height: 90, 
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A2E), 
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, -5),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, 'assets/home.png'),
            _buildNavItem(1, 'assets/cart.png'),
            _buildNavItem(2, 'assets/profile.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(20), 
        child: isSelected
            ? ShaderMask(
                shaderCallback: (bounds) => rainbowGradient.createShader(bounds),
                child: Image.asset(
                  iconPath, 
                  color: Colors.white, 
                  width: 26, 
                  height: 26,
                  fit: BoxFit.contain
                ),
              )
            : Image.asset(
                iconPath, 
                color: Colors.white70, 
                width: 24, 
                height: 24,
                fit: BoxFit.contain
              ),
      ),
    );
  }
}
