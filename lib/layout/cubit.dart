import 'package:dio/dio.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/models/landing.dart';
import 'package:e_commerce_app/models/product_details_model.dart';
import 'package:e_commerce_app/models/search_model.dart';
import 'package:e_commerce_app/modules/categories/categories_screen.dart';
import 'package:e_commerce_app/modules/my_chart/my_chart_screen.dart';
import 'package:e_commerce_app/modules/new_product/add_product.dart';
import 'package:e_commerce_app/modules/products/products_screen.dart';
import 'package:e_commerce_app/modules/settings/settings_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/components/constants.dart';
import 'package:e_commerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    AddProduct(),
    const MyChartScreen(),
    SettingsScreen(),
  ];

  void changeCurrentIndex(int index ,context) {
    if(index == 2) {
      navigateTo(context, bottomScreen[index]);
      emit(ShopChangeBottomNavState());
    }else{
      currentIndex = index;
      emit(ShopChangeBottomNavState());
    }
  }

  LandingModel? landingProduct;

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());

    DioHelper.getData(data: {'action': 'landing_page'}).then((value) {
      landingProduct = landingModelFromJson(value.data);
      //print(landingProduct!.toJson());
      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorHomeDataStates());
    });
  }

  ProductDetailModel? productDetailModel;

  void getProductData({String? asin}) {
    emit(ShopLoadingProductDataStates());

    DioHelper.getData(data: {'action': 'product', 'asin': asin}).then((value) {
      productDetailModel = productDetailModelFromJson(value.data);
      print(value.data);
      emit(ShopSuccessProductDataStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorProductDataStates());
    });
  }

  void addNewProduct({
    String? title,
    String? asin,
    String? price,
    String? brandName,
    String? category,
    String? productDetails,
    String? featuresDetails,
    String? malicious,
    String? image,
    String? location,
    String? industry
}) {
    emit(ShopLoadingAddProductStates());
    DioHelper.postData(formData: FormData.fromMap({
      'action': 'add_product',
      'title': title,
      'asin': asin,
      'price': price,
      'brand_name': brandName,
      'category': 'Example Category',
      'product_details': productDetails,
      'feature_details': featuresDetails,
      'malicious_url': malicious,
      'image_url': image,
      'location': location,
      'has_company_logo': '1',
      'has_questions': '1',
      'industry': industry
    })).then((value) {
      //productDetailModel = productDetailModelFromJson(value.data);
      print(value.data);
      emit(ShopSuccessAddProductStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorAddProductStates());
    });
  }

  SearchModel? model ;

  void search(String? search){
    emit(SearchBrandLoadingState());

    DioHelper.getData(data: {'action':'brand_search' , 'brand':search}).then((value) {
      model = searchModelFromJson(value.data);
      emit(SearchBrandSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(SearchBrandErrorState());
    });
  }

  List<ProductDetailModel> myChart = [];
  List<List<ProductDetailModel>> successfulTransaction = [];

  void addToChart({ProductDetailModel? product}){
    myChart.add(product!);
    emit(ShopAddToChartState());
  }
  void removeFromChart({index}){
    myChart.removeAt(index);
    emit(ShopRemoveFromChartState());
  }

  void newTransaction() {
    String products ='';
    for (var element in myChart) {
      products = "$products,${element.brandId!}" ;
    }
    emit(ShopLoadingTransactionStates());
    DioHelper.postData(formData: FormData.fromMap({
      'action': 'transaction',
      'UserID': token,
      'DeviceID': 454,
      'DeviceType': 'Android',
      'IPAddress': 732758368.79972,
      'Country': 'egypt',
      'ProductIDs': products,
      'Browser': 'Mobile App',
    })).then((value) {
      //productDetailModel = productDetailModelFromJson(value.data);
      print(value.data);
      successfulTransaction.add(myChart);
      myChart =[];
      emit(ShopSuccessTransactionStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorTransactionStates());
    });
  }

  int currentStep = 0;

  void changeCurrentStep(int step){
    currentStep = step;
    emit(ShopChangeStepState());
  }
  void continueCurrentStep(){
    if(currentStep == 2){

    }else {
      currentStep++;
      emit(ShopChangeStepState());
    }
  }
  void cancelCurrentStep(){
    if(currentStep !=0){
      currentStep--;
      emit(ShopChangeStepState());
    }
  }

  //
  // HomeModel? homeModel ;
  //
  // Map<int , bool> my_chart ={};
  //
  // void getHomeData(){
  //   emit(ShopLoadingHomeDataStates());
  //
  //   DioHelper.getData(url: homeUrl , token: token).then((value) {
  //     homeModel = HomeModel.fromJson(value.data);
  //     //printFullText(homeModel!.data!.banners![0].image.toString());
  //
  //     my_chart = <int , bool>{};
  //     for (var element in homeModel!.data!.products!) {
  //       my_chart.addAll({element.id! : element.inFavorites!});
  //     }
  //
  //     emit(ShopSuccessHomeDataStates());
  //   }).catchError((error){
  //     //print(error.toString());
  //     emit(ShopErrorHomeDataStates());
  //   });
  // }
  //
  // CategoriesModel? categoriesModel ;
  //
  //
  // void getCategories(){
  //
  //   DioHelper.getData(url: getCategoriesUrl , token: token).then((value) {
  //     categoriesModel = CategoriesModel.fromJson(value.data);
  //
  //     emit(ShopSuccessCategoriesStates());
  //   }).catchError((error){
  //     //print(error.toString());
  //     emit(ShopErrorCategoriesStates());
  //   });
  // }
  //
  // ChangeFavoritesModel? changeFavoritesModel;
  //
  //  void changeFavorites(int productId){
  //   my_chart[productId] = !my_chart[productId]!;
  //   emit(ShopChangeFavStates());
  //
  //   DioHelper.postData(
  //       url: favouritesUrl,
  //       data: {
  //         'product_id' : productId
  //       },
  //     //token: token,
  //   ).then((value) {
  //     changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  //     if(!changeFavoritesModel!.status!){
  //       my_chart[productId] = !my_chart[productId]!;
  //     }else{
  //       getFavorites();
  //     }
  //
  //     emit(ShopSuccessChangeFavStates(changeFavoritesModel!));
  //   }).catchError((error){
  //     my_chart[productId] = !my_chart[productId]!;
  //
  //     emit(ShopSuccessChangeFavStates(changeFavoritesModel!));
  //   });
  // }
  //
  // FavoritesModel? favoritesModel  ;

  // void getFavorites(){
  //   emit(ShopLoadingGetFavStates());
  //
  //   DioHelper.getData(url: favouritesUrl , token: token).then((value) {
  //     favoritesModel = FavoritesModel.fromJson(value.data);
  //
  //     emit(ShopSuccessGetFavStates());
  //   }).catchError((error){
  //     //print(error.toString());
  //     emit(ShopErrorGetFavStates());
  //   });
  // }
  //
  // ShopLoginModel? userModel  ;

  // void getUserData(){
  //   emit(ShopLoadingUserDataStates());
  //
  //   DioHelper.getData(url: profileUrl , token: token).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //
  //     emit(ShopSuccessUserDataStates(userModel!));
  //   }).catchError((error){
  //     //print(error.toString());
  //     emit(ShopErrorUserDataStates());
  //   });
  // }

  // void updateUserData({required String name, required String email, required String phone,}){
  //   emit(ShopLoadingUpdateUserStates());
  //
  //   DioHelper.putData(
  //     url: updateProfileUrl ,
  //     token: token,
  //     data: {
  //       'name':name,
  //       'phone':phone,
  //       'email':email
  //     },
  //   ).then((value) {
  //     userModel = ShopLoginModel.fromJson(value.data);
  //
  //     emit(ShopSuccessUpdateUserStates(userModel!));
  //   }).catchError((error){
  //     //print(error.toString());
  //     emit(ShopErrorUpdateUserStates());
  //   });
  // }
}
