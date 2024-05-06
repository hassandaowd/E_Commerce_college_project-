import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/modules/login/shop_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/register/cubit.dart';
import 'package:e_commerce_app/modules/register/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({super.key});
  int currentStep = 0;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.success!) {
              toast(
                msg: 'Register Successfully \n Login Now',
                state: ToastState.success,
              );
              navigateToFinish(context, ShopLoginScreen());
            } else {
              toast(
                msg: 'error when logging',
                state: ToastState.error,
              );
            }
          }
          else if(state is ShopRegisterErrorState){
            toast(
              msg: 'Connection Error',
              state: ToastState.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = ShopRegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          onChange: (value) {},
                          onTap: (value) {},
                          onSubmit: (value) {},
                          suffixPressed: () {},
                          controller: usernameController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Email address must not be empty';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        defaultFormField(
                            onChange: (value) {},
                            onTap: (value) {},
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: cubit.suffix,
                            onSubmit: (value) {},
                            isPassword: cubit.isPassword,
                            suffixPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
