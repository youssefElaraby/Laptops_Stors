import 'package:flutter/material.dart';

import '../laptop_screen/model/laptop_Response.dart';

class LaptopDetailsScreen extends StatelessWidget {
  final Products laptop;

  const LaptopDetailsScreen({super.key, required this.laptop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(laptop.name ?? "تفاصيل اللابتوب"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: laptop.id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: laptop.image != null
                    ? Image.network(
                  laptop.image!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.laptop, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              laptop.name ?? "اسم غير معروف",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "${laptop.price} EGP",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              "الوصف",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              laptop.description ?? "لا يوجد وصف متاح لهذا المنتج.",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
