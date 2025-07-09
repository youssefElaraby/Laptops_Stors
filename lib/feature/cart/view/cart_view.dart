import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../laptop_screen/widgets/SliverAppBar.dart';
import '../view_model/cart_cubit.dart';
import '../view_model/cart_state.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit()..getCart(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomSliverAppBar(
              height: 220,
              title: " سلة المشتريات",
            ),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartError) {
                    return Center(child: Text("حدث خطأ: ${state.message}"));
                  } else if (state is CartSuccess) {
                    final products = state.cartResponse.products ?? [];

                    if (products.isEmpty) {
                      return const Center(
                        child: Text(
                          "السلة فارغة 🧺",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = products[index];

                        return Slidable(
                          key: ValueKey(item.id),
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  context.read<CartCubit>().deleteFromCart(productId: item.id!);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'حذف',
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  context.read<CartCubit>().deleteFromCart(productId: item.id!);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'حذف',
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ],
                          ),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: item.image != null
                                        ? Image.network(
                                      item.image!,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                        : const Icon(Icons.image, size: 60),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name ?? "بدون اسم",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text("السعر: ${item.price} EGP"),
                                        Text("الكمية: ${item.quantity}"),
                                        Text("الإجمالي: ${item.totalPrice} EGP"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
