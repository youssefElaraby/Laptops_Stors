import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cache/cache_helper.dart';
import '../../favorite_screen/view_model/favorite_cubit.dart';
import '../model/laptop_Response.dart';
import 'custom_hart.dart';

class SliverBody extends StatelessWidget {
   SliverBody({super.key});
   final token = CacheHelper.getData(key: "token");
   final nationalId = CacheHelper.getData(key: "userId");


   final List<Products> laptops = [];
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(12.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final laptop = laptops[index];

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: laptop.image != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    laptop.image!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                )
                    : const Icon(Icons.laptop, size: 40),
                title: Text(
                  laptop.name ?? "No Name",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${laptop.price} EGP",
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: CustomHeart(
                  onTap: (isLiked) {
                    if (isLiked) {
                      context.read<FavoriteCubit>().addToFavorite(
                        token: token,
                        nationalId: nationalId,
                        productId: laptop.id!,
                      );
                    }
                  },
                ),
              ),
            );
          },
          childCount: laptops.length,
        ),
      ),
    );
  }
}
