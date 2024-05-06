

abstract class ShopStates{}
class ShopInitialState extends ShopStates {}

/// Bottom Nav States

class ShopChangeBottomNavState extends ShopStates{}

/// Home States

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{}
/// Home States

class ShopLoadingProductDataStates extends ShopStates{}

class ShopSuccessProductDataStates extends ShopStates{}

class ShopErrorProductDataStates extends ShopStates{}

/// Categories States

class ShopSuccessCategoriesStates extends ShopStates{}

class ShopErrorCategoriesStates extends ShopStates{}


/// add product States

class ShopLoadingAddProductStates extends ShopStates{}

class ShopSuccessAddProductStates extends ShopStates{}

class ShopErrorAddProductStates extends ShopStates{}


class ShopContinueState extends ShopStates{}

class ShopCancelState extends ShopStates{}

class ShopChangeStepState extends ShopStates{}

///  User Data States

class SearchBrandLoadingState extends ShopStates{}

class SearchBrandSuccessState extends ShopStates{}

class SearchBrandErrorState extends ShopStates{}



class ShopAddToChartState extends ShopStates{}
class ShopRemoveFromChartState extends ShopStates{}

/// transaction States

class ShopLoadingTransactionStates extends ShopStates{}

class ShopSuccessTransactionStates extends ShopStates{}

class ShopErrorTransactionStates extends ShopStates{}

//