import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(

      listener: (context, state) {

      },
      builder: (context, state) {
        if(cubit.myChart.isNotEmpty) {
          return ListView.separated(
          itemBuilder: (context, index) => Container(),//buildCatItem(cubit.categoriesModel!.data!.data![index]),
          separatorBuilder: (context, index) => separateList(),
          itemCount: 10,
        );
        }
        else{
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text('There is nothing to show',style: Theme.of(context).textTheme.titleMedium,),
            ),
          );
        }
      },
    );
  }

}
// Widget buildCatItem(DataCatModel model) => Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           Image(
//             image: NetworkImage(model.image!),
//             width: 80,
//             height: 120,
//             fit: BoxFit.cover,
//             loadingBuilder: (BuildContext context, Widget child,
//                 ImageChunkEvent? loadingProgress) {
//               if (loadingProgress == null) {
//                 return child;
//               }
//               return const CircularProgressIndicator();
//             },
//             errorBuilder: (BuildContext context , Object object , StackTrace? stackTrace){
//               return const SizedBox(
//                 height: 120,
//                 width: 80,
//                 child: Center(
//                   child: Icon(
//                     Icons.error,
//                     color: Colors.red,
//                   ),
//                 ),
//               );
//             },
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Text(
//             model.name!,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Spacer(),
//           const Icon(Icons.arrow_forward_ios),
//         ],
//       ),
//     );
