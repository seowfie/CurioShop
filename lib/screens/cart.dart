import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int)? onRemove;
  final VoidCallback? onCheckout;

  const CartPage({
    super.key,
    this.cartItems = const [],
    this.onRemove,
    this.onCheckout,
  });

  static const Gradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFF9C27B0),
      Color(0xFFFF4081),
      Color(0xFF00E5FF),
      Color(0xFFFFD740),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    // Calculate total price based on items currently in list
    double total = cartItems.fold(0, (sum, item) {
      String priceStr = item['price'].replaceAll('₱', '').replaceAll(',', '').trim();
      return sum + (double.tryParse(priceStr) ?? 0);
    });

    return Scaffold(
      backgroundColor: const Color(0xFF050011),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset('assets/logo.png', width: 65, height: 65, 
                    errorBuilder: (c, o, s) => const Icon(Icons.shopping_cart, color: Colors.white)),
                  const SizedBox(width: 15),
                  ShaderMask(
                    shaderCallback: (bounds) => rainbowGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      "Cart",
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  constraints: const BoxConstraints(minHeight: 450),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(37),
                    boxShadow: [
                      BoxShadow(color: Colors.white.withOpacity(0.15), offset: const Offset(0, -1), blurRadius: 4),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      
                      if (cartItems.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 100),
                          child: Text("Your cart is empty!", style: TextStyle(color: Colors.white54, fontSize: 16)),
                        )
                      else
                        for (int i = 0; i < cartItems.length; i++)
                          Column(
                            children: [
                              _buildCartItem(cartItems[i], i),
                              _buildDivider(),
                            ],
                          ),

                      const SizedBox(height: 20),
                      ClipPath(
                        clipper: TotalSectionClipper(),
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                  Text("₱ ${total.toStringAsFixed(0)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF7A56AE))),
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
                Positioned(
                  top: 10,
                  child: Container(
                    width: 60, height: 8,
                    decoration: BoxDecoration(color: const Color(0xFF7A56AE), borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return GestureDetector(
      onTap: () => onCheckout?.call(),
      child: Container(
        width: 198, height: 61,
        decoration: BoxDecoration(
          gradient: rainbowGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: const Color(0xFFFF4081).withOpacity(0.5), offset: const Offset(0, 4), blurRadius: 6)],
        ),
        child: const Center(
          child: Text("Checkout", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          // 85x85 Container with 5px uneven gradient border
          Container(
            width: 85,
            height: 85,
            padding: const EdgeInsets.all(5), // 5px border thickness
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [Color(0xFFB19DCC), Color(0xFF121212)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.6], // Purple highlight ends quickly for uneven ratio
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF121212), 
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.cover, 
                  // Aligns focus to topCenter to better capture faces/product tops
                  alignment: Alignment.topCenter, 
                  errorBuilder: (c, o, s) => const Icon(Icons.image, color: Colors.white24),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'], 
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold), 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis),
                const Text("1 piece", style: TextStyle(color: Colors.white70, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => onRemove?.call(index),
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
          ),
          Text(item['price'], 
            style: const TextStyle(color: Color(0xFFB19DCC), fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Center(
      child: Container(
        width: 300, height: 1,
        color: const Color(0xFF7A56AE).withOpacity(0.2),
      ),
    );
  }
}

class TotalSectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
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
}
