import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/search/cubit.dart';
import 'package:e_commerce_app/modules/search/states.dart';
import 'package:e_commerce_app/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearchCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                cubit.model!.search =[];
                Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) return 'enter brand name for search';
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        SearchCubit.get(context).search(value);
                      },
                      onChanged: (value){
                        SearchCubit.get(context).search(value);
                      },
                      decoration: const InputDecoration(
                        label: Text('Search'),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    (state is SearchInitialState) ? Container() :
                    ConditionalBuilder(
                      condition: state is! SearchLoadingState ,
                      builder: (context) => Expanded(
                        child: (cubit.model!.search!.isEmpty)
                            ?  Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text('There is nothing to show',style: Theme.of(context).textTheme.titleMedium,),
                            )
                            : ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(cubit.model!.search![index],context),
                          separatorBuilder: (context, index) => separateList(),
                          itemCount: cubit.model!.search!.length ,
                        ),
                      ),
                      fallback: (context) => const LinearProgressIndicator(),
                    ),
                  ],
                ),
              ),
            )
        );
      },
    );
  }

  Widget buildSearchItem(String? model, BuildContext context) => InkWell(
    onTap: (){},
    child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    model!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
