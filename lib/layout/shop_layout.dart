import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/modules/search/search_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';

class ShopLayoutScreen extends StatelessWidget {
  const ShopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates >(
      listener: (context , state) {},
      builder: (context,state){
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('ShoeShack'),
            actions: [
              IconButton(
                  onPressed: (){
                    //cubit.getHomeData();
                    navigateTo(context, SearchScreen());
                  }, icon: const Icon(Icons.search))
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'add '
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.add_shopping_cart_outlined),
                  label: 'Chart'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings'
              ),
            ],
            onTap: (index){cubit.changeCurrentIndex(index , context);},
            currentIndex: cubit.currentIndex,
          ),
        );
      },
    );
  }
}