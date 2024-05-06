//import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit.dart';
import 'layout/shop_layout.dart';
import 'layout/states.dart';
import 'modules/on_boarding/on_board_screen.dart';
import 'modules/login/shop_login.dart';
import 'modules/search/cubit.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/styles/themes.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') ?? '';

  if(onBoarding != null){
    if(token != '') {
      widget = const ShopLayoutScreen();
    }
    else {
      widget = ShopLoginScreen();
    }
  }
  else {
    widget = const OnBoardingScreen();
  }

  runApp(  MyApp(startWidget: widget ,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key , required this.startWidget});
  final Widget startWidget ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getHomeData()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , states)  {},
        builder: (context , states)  {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home:  startWidget,
          );
        },
      ),
    );
  }
}
