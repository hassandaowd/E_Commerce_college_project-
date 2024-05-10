import 'package:e_commerce_app/modules/products/products_screen.dart';
import 'package:flutter/material.dart';


class DashboardDetails extends StatelessWidget {
  const DashboardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: ProductsScreen(),
        ),
        Container(
          width: 4,
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white,
        ),
        // const Expanded(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       AutomatedScreen(),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
