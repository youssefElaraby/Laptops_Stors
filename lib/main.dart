import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'cache/cache_helper.dart';
import 'feature/Auth/signIn/view/signIn_view.dart';
import 'feature/Auth/signIn/view_model/sign_in_cubit.dart';
import 'feature/Auth/signUp/view_model/sign_up_cubit.dart';
import 'feature/cart/view_model/cart_cubit.dart';
import 'feature/favorite_screen/view_model/favorite_cubit.dart';
import 'feature/laptop_screen/view/laptop_view.dart';
import 'feature/laptop_screen/view_model/laptop_cubit.dart';
import 'feature/profile/view_model/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  final token = CacheHelper.getData(key:"token");

  Widget startWidget;
  if (token != null) {
    startWidget = LaptopView();
  } else {
    startWidget = const SignInView();
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(startWidget: startWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LaptopCubit()..getLaptop()),
            BlocProvider(create: (_) => FavoriteCubit()),
            BlocProvider(create: (_) => CartCubit()..getCart()),
            BlocProvider(create: (_) => SignUpCubit()),
            BlocProvider(create: (_) => SignInCubit()),
            BlocProvider(create: (_) => ProfileCubit()),
          ],
          child: MaterialApp(
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'Laptops App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.grey[100],
            ),
            home: startWidget,
          ),
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
