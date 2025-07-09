import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../cache/cache_helper.dart';
import '../../cart/view_model/cart_cubit.dart';
import '../../favorite_screen/view_model/favorite_cubit.dart';
import '../view_model/laptop_cubit.dart';
import '../view_model/laptop_state.dart';
import '../widgets/SliverAppBar.dart';
import '../widgets/custom_hart.dart';
import '../widgets/side_drawer.dart';

class LaptopView extends StatelessWidget {
  LaptopView({super.key});

  final token = CacheHelper.getData(key: "token");
  final nationalId = CacheHelper.getData(key: "userId");

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  SideDrawer(),
      body: Column(
        children: [
           CustomSliverAppBar(
            title: " Laptops Store",
            height: 210.h,
          ),


          Padding(
            padding: EdgeInsets.only(left: 12.w, top: 4.h), // قللنا الـ top هنا
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.menu, size: 32),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
            ),
          ),


          Expanded(
            child: CustomScrollView(
              slivers: [
                BlocBuilder<LaptopCubit, LaptopState>(
                  builder: (context, state) {
                    if (state is Laptoploading) {
                      return SliverToBoxAdapter(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: const Color(0xff3b3b72),
                          size: 50.r,
                        ),
                      );
                    } else if (state is LaptopFailure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text('Error: ${state.message}'),
                          ),
                        ),
                      );
                    } else if (state is LaptopSuccess) {
                      final laptops = state.laps.product ?? [];

                      return SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        sliver: SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final laptop = laptops[index];

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                        child: laptop.image != null
                                            ? Image.network(
                                          laptop.image!,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                            : const Icon(Icons.laptop, size: 60),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            laptop.name ?? "No Name",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${laptop.price} EGP",
                                            style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  final token = CacheHelper.getData(key: "token");
                                                  final nationalId = CacheHelper.getData(key: "userId");

                                                  if (token != null && nationalId != null) {
                                                    context.read<CartCubit>().addToCart(
                                                      productId: laptop.id!,
                                                    );

                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("تمت الإضافة إلى السلة")),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      const SnackBar(content: Text("يرجى تسجيل الدخول أولاً")),
                                                    );
                                                  }
                                                },
                                                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.blue),
                                              ),

                                              CustomHeart(
                                                onTap: (isLiked) {
                                                  if (isLiked) {
                                                    context.read<FavoriteCubit>().addToFavorite(
                                                      token: token!,
                                                      nationalId: nationalId,
                                                      productId: laptop.id!,
                                                    );
                                                  } else {
                                                    context.read<FavoriteCubit>().deleteFavorite(
                                                      token: token!,
                                                      nationalId: nationalId,
                                                      productId: laptop.id!,
                                                    );
                                                  }
                                                },
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            childCount: laptops.length,
                          ),
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
