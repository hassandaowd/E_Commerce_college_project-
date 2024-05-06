import 'package:dio/dio.dart';
import 'package:e_commerce_app/models/shop_app_register.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/register/states.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit(): super(ShopRegisterInitialState());

  late ShopRegisterModel registerModel ;
  //int currentStep = 0;
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({required String username , required String password  }){
    emit(ShopRegisterLoadingState());
    print(localhost);
    DioHelper.postData(
      formData: FormData.fromMap({
        "action":"add_user",
        "user_lang":"en",
        "username":username,
        "password":password,
        "isAdmin":kIsWeb ? "1" :"0",
        "has_default_profile":"0",
        "has_default_profile_img":"0",
        "is_geo_enabled":"0",
        "membership_subscription":"subscription",
        "followers_count":"0",
        "friends_count":"0",
        "avg_purchases_per_day":"0",
        "account_age":"1",
        "prod_fav_count":"2",
        "purchase_count":"1",
        "purchase_date":"",
      }),
    ).then((value) {
      registerModel = shopRegisterModelFromJson(value.data);

      emit(ShopRegisterSuccessState(registerModel));
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopRegisterErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopRegisterChangePasswordVisibilityState());

  }
  // void changeCurrentStep(int step){
  //   currentStep = step;
  //   emit(ShopRegisterChangeStepState());
  // }
  // void continueCurrentStep([username , password]){
  //   if(currentStep == 2){
  //     userRegister(username: username, password: password);
  //
  //   }else {
  //     currentStep++;
  //     emit(ShopRegisterChangeStepState());
  //   }
  // }
  // void cancelCurrentStep(){
  //   if(currentStep !=0){
  //     currentStep--;
  //     emit(ShopRegisterChangeStepState());
  //   }
  // }
}