import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/layout/cubit.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {


      },
      builder: (context, state) {
        if(true ){
          //var model = cubit.userModel!;
          nameController.text = 'model.data!.name!';
          emailController.text = 'model.data!.email!';
          phoneController.text = 'model.data!.phone!';

          return ConditionalBuilder(
            condition: true,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      defaultFormField(
                        onChange: (value){},
                        onTap: (value){},
                        onSubmit: (value){},
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) return 'name must not be empty';
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        onChange: (value){},
                        onTap: (value){},
                        onSubmit: (value){},
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) return 'Email must not be empty';
                        },
                        label: 'Username',
                        prefix: Icons.email,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // defaultFormField(
                      //   onChange: (value){},
                      //   onTap: (value){},
                      //   onSubmit: (value){},
                      //   controller: phoneController,
                      //   type: TextInputType.phone,
                      //   validate: (String value) {
                      //     if (value.isEmpty) return 'Phone must not be empty';
                      //   },
                      //   label: 'Phone Number',
                      //   prefix: Icons.phone,
                      // ),
                      const SizedBox(height: 20,),
                      defaultButton(
                          function: () {},
                          text: 'update'
                      ),
                      const SizedBox(height: 20,),
                      defaultButton(
                          function: () {
                            logOut(context);
                          },
                          text: 'logout'
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
