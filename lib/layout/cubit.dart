import 'package:dio/dio.dart';
import 'package:e_commerce_app/layout/states.dart';
import 'package:e_commerce_app/models/add_product_model.dart';
import 'package:e_commerce_app/models/landing.dart';
import 'package:e_commerce_app/models/product_details_model.dart';
import 'package:e_commerce_app/models/search_model.dart';
import 'package:e_commerce_app/modules/brands/brands_screen.dart';
import 'package:e_commerce_app/modules/my_chart/my_chart_screen.dart';
import 'package:e_commerce_app/modules/new_product/add_product.dart';
import 'package:e_commerce_app/modules/products/products_screen.dart';
import 'package:e_commerce_app/modules/search/search_screen.dart';
import 'package:e_commerce_app/modules/your_orders/your_orders_screen.dart';
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
    const BrandsScreen(),
    AddProduct(),
    const MyChartScreen(),
    const YourOrdersScreen(),
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


  AddProductModel? addProductModel;
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
      'category': category,
      'product_details': productDetails,
      'feature_details': featuresDetails,
      'malicious_url': malicious,
      'image_url': image,
      'location': location,
      'has_company_logo': '1',
      'has_questions': '1',
      'industry': industry
    })).then((value) {
      addProductModel = addProductModelFromJson(value.data);
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

  void goToSearch(context){
    model = SearchModel();
    navigateTo(context, SearchScreen());
    emit(SearchInitialState());
  }
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


  SearchModel? brands ;



  void getBrands(){
    emit(GetBrandLoadingState());

    DioHelper.getData(data: {'action':'brands'}).then((value) {
      brands = searchModelFromJson(value.data);
      emit(GetBrandSuccessState());
    }).catchError((error){
      //print(error.toString());
      emit(GetBrandErrorState());
    });
  }

  LandingModel? productOfBrands;

  void getProductOfBrands({String? brandName}) {
    emit(ShopLoadingProductBrandsStates());

    DioHelper.getData(data: {'action': 'products_by_brand', 'brand_name': brandName}).then((value) {
      productOfBrands = landingModelFromJson(value.data);
      //print(value.data);
      emit(ShopSuccessProductBrandsStates());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorProductBrandsStates());
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

}
