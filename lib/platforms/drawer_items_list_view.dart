import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/models/drawer_item_model.dart';
import 'package:e_commerce_app/modules/brands/brands_screen.dart';
import 'package:e_commerce_app/platforms/drawer_item.dart';
import 'package:e_commerce_app/platforms/utils/app_images.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'dashboard_layout.dart';

class DrawerItemsListView extends StatefulWidget {
   DrawerItemsListView({
    super.key,
  });

  @override
  State<DrawerItemsListView> createState() => _DrawerItemsListViewState();
}

class _DrawerItemsListViewState extends State<DrawerItemsListView> {
  int activeIndex = 0;

  final List<DrawerItemModel> items = [
    const DrawerItemModel(title: 'Product', image: Assets.imagesDashboard),
    const DrawerItemModel(title: 'Fraud Product', image: Assets.imagesMyTransctions),
    const DrawerItemModel(title: 'Power PI', image: Assets.imagesStatistics),
    const DrawerItemModel(title: 'Brands', image: Assets.imagesWalletAccount),
    //const DrawerItemModel(title: 'Setting system', image: Assets.imagesSettings),
    // const DrawerItemModel(
    //     title: 'My Investments', image: Assets.imagesMyInvestments),
  ];

  List<Widget> webWidget =[
    const DashboardDetails(),
    const DashboardDetails(),
    const BrandsScreen(),
    const BrandsScreen(),

  ];

  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

                ShopCubit.get(context).changeDrawerIndex(index);
                currentIndex = ShopCubit.get(context).drawerIndex;
                adminWidget = webWidget[currentIndex];

                //activeIndex = currentIndex;
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: DrawerItem(
                  drawerItemModel: items[index],
                  isActive: index == currentIndex,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
