import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../cache/cache_helper.dart';
import '../../laptop_screen/widgets/SliverAppBar.dart';
import '../view_model/favorite_cubit.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late final String token;
  late final String nationalId;

  @override
  void initState() {
    super.initState();
    token = CacheHelper.getData(key: "token") ?? "";
    nationalId = CacheHelper.getData(key: "userId") ?? "";
    context.read<FavoriteCubit>().getFavorites(token: token, nationalId: nationalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomSliverAppBar(
            height: 220,
            title: "المفضلة",
          ),
          Expanded(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                if (state is FavoriteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FavoriteFailure) {
                  return Center(child: Text("حدث خطأ أثناء جلب المفضلة"));
                } else if (state is FavoriteUpdated) {
                  final items = state.favorites;

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        "لا توجد عناصر مفضلة ❤️",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Slidable(
                        key: ValueKey('${item.id}_$index'),
                        startActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.25,
                          children: [
                            SlidableAction(
                              onPressed: (_) {
                                context.read<FavoriteCubit>().deleteFavorite(
                                  token: token,
                                  nationalId: nationalId,
                                  productId: item.id!,
                                );
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
                                context.read<FavoriteCubit>().deleteFavorite(
                                  token: token,
                                  nationalId: nationalId,
                                  productId: item.id!,
                                );
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
    );
  }
}
