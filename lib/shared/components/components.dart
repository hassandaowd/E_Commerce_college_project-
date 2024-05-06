import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_network/image_network.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  Color fontColor = Colors.white,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        textColor: Colors.white,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: (){function();},
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function onSubmit ,
  required Function onChange ,
  required Function onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  Color color = Colors.black
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value) =>  onSubmit(value) ,
      onChanged: (value) => onChange(value),
      //onTap: () =>  onTap() ,
      validator: (value) => validate(value),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed:  () => suffixPressed!() ,
          icon: Icon(
            suffix,
          ),
        ):null,
        border: const OutlineInputBorder(),
      ),
    );

///********************** ToDo App

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${model['date']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        IconButton(
          onPressed: () {
            //AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
          icon: const Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ),
        IconButton(
          onPressed: () {
            //AppCubit.get(context).updateData(status: 'archive', id: model['id']);
          },
          icon: const Icon(
            Icons.archive,
            color: Colors.black45,
          ),
        ),
      ],
    ),
  ),
  onDismissed: (direction) {
    //AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({required List<Map> tasks,}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) {
      return buildTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => separateList(),
    itemCount: tasks.length,
  ),
  fallback: (context) => const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

///********************** News App

Widget separateList()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article , context) => InkWell(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        ImageNetwork(
          image: '${article['urlToImage']}',
          height: 120,
          width: 120,
          duration: 1500,
          curve: Curves.easeIn,
          fullScreen: false,
          fitAndroidIos: BoxFit.cover,
          fitWeb: BoxFitWeb.cover,
          onLoading: const CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
          onError: const Icon(
            Icons.error,
            color: Colors.deepOrange,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          // ignore: sized_box_for_whitespace
          child: Container(
            height: 120,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
  onTap: (){
    //navigateTo(context, WebViewScreen(url: article['url'].toString()));
  },
);

Widget articleBuilder(List list , BuildContext context , {isSearch = false}) => ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) => ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemBuilder: (BuildContext context, int index) => buildArticleItem(list[index] , context),
    separatorBuilder: (BuildContext context, int index) => separateList(),
    itemCount: list.length,
  ),
  fallback: (context) => isSearch ? Container(): const Center(child:  CircularProgressIndicator(),),
);

void navigateTo(context , widget) => Navigator.push(context , MaterialPageRoute(builder: (context)=> widget));

void navigateToFinish(context , widget) => Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> widget) , (route) => false);

Future<bool?> toast({required String msg , required ToastState state }) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState {success , error , warning}

Color chooseToastColor(ToastState state){
  Color color;
  switch (state){
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color= Colors.amber;
      break;
  }
  return color;
}


String? extractUrls(String text) {
  RegExp regExp = RegExp(r'https://[^\s]+\.jpg');
  List<String?> urls = regExp.allMatches(text).map((match) => match.group(0)).toList();
  //print(text);
  return urls.isNotEmpty ? urls.first : 'https://gebelesebeti.ge/front/asset/img/default-product.png';}