import 'package:e_commerce_app/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';

class PowerBiScreen extends StatelessWidget {
  const PowerBiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
          return const Center(
            child: Text('POWER BI'),
          );

      },
    );
  }
}
