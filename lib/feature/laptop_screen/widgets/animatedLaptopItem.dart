import 'package:flutter/material.dart';
import '../../favorite_screen/model/fav.dart';
import '../model/laptop_Response.dart';

class AnimatedLaptopItem extends StatefulWidget {
  final FavoriteProducts product;

  const AnimatedLaptopItem({super.key, required this.product});

  @override
  State<AnimatedLaptopItem> createState() => _AnimatedLaptopItemState();
}

class _AnimatedLaptopItemState extends State<AnimatedLaptopItem> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isTapped ? Colors.blue.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.network(
              widget.product.image ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.product.price ?? ''}",
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
