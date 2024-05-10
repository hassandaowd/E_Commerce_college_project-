import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/models/landing.dart';
import 'package:e_commerce_app/modules/product_details/product_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/styles/colors.dart';

class FraudScreen extends StatelessWidget {
  const FraudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessProductDataStates) {
          navigateTo(context, const ProductDetails());
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: false,//cubit.landingProduct != null,
          builder: (context) => builder(cubit.landingProduct!, context),
          fallback: (context) => (state is! ShopErrorHomeDataStates &&
                  state is! GetBrandErrorState &&
                  state is! ShopChangeBottomNavState &&
                  state is! SearchInitialState)
              ? const Center(child: CircularProgressIndicator())
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('There is a problem in your network'),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget builder(LandingModel model, context) => Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: SingleChildScrollView(
          child: kIsWeb ?
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              children: List.generate(
                model.landingProduct!.length,
                    (index) =>
                    buildGridProduct(model.landingProduct![index], context),
              ),
            ),
          ) :Container(
            color: Colors.grey[300],
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.77,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model.landingProduct!.length,
                (index) =>
                    buildGridProduct(model.landingProduct![index], context),
              ),
            ),
          ),
        ),
  );

  Widget buildGridProduct(LandingProduct model, BuildContext context) =>
      InkWell(
        onTap: () {
          ShopCubit.get(context).getProductData(asin: model.asin!);
        },
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  image(extractUrls(model.imageUrLs![0])),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      model.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          model.price ?? 'not available',
                          style: const TextStyle(
                            fontSize: 12,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget image(String? url) => Image(
        image: NetworkImage(url!),
        width: double.infinity,
        height: 200,
        errorBuilder:
            (BuildContext context, Object object, StackTrace? stackTrace) {
          return kIsWeb ? const SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Image(image: AssetImage('assets/images/no_product.png'),
              fit: BoxFit.cover,),
            ),
          ) :const SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const SizedBox(
            height: 200,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
}
