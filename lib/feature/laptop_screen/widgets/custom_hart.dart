import 'package:flutter/material.dart';

class CustomHeart extends StatefulWidget {
  final bool isInitiallyLiked;
  final void Function(bool isLiked)? onTap;

  const CustomHeart({
    super.key,
    this.isInitiallyLiked = false,
    this.onTap,
  });

  @override
  State<CustomHeart> createState() => _CustomHeartState();
}

class _CustomHeartState extends State<CustomHeart> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    widget.onTap?.call(isLiked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleLike,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isLiked ? Colors.red.withOpacity(0.1) : Colors.white,
        ),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.grey,
          size: 24,
        ),
      ),
    );
  }
}
