class ChangeFavoritesModel{
  bool? status;
  String? message;

  ChangeFavoritesModel({this.message,this.status});

  ChangeFavoritesModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}