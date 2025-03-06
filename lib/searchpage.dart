import 'package:flutter/material.dart';
import 'package:gilbert_uas/model.dart';
import 'package:gilbert_uas/apiservice.dart';
import 'package:gilbert_uas/response.dart';
import 'package:gilbert_uas/detailpage.dart';

class SearchPage extends SearchDelegate{
  final apiService = ApiService();

  @override
  ThemeData appBarTheme(BuildContext context){
    return ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.grey[400],
      ),
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
            fontSize: 22,
          )
      ),
    );
  }


  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(onPressed: (){
      Navigator.of(context).pop();
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context){
    return Container(
      color: Colors.grey[300],
      child: FutureBuilder(
        future: apiService.search(query),
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            PostResponse response = snapshot.data;
            List<Model> list = response.list;
            return ListView.builder(
                itemCount: list?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, top: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              '${list?[index].nama_alatmusik.toString()}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Quantity : ${list?[index].quantity
                                  .toString()}'),
                              Text('Total Harga : ${list?[index].total_harga
                                  .toString()}'),
                            ],
                          ),
                          leading: Icon(Icons.music_note),
                          trailing: Icon(Icons.near_me),
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) =>
                                    DetailPage(model: list[index],)));
                          },
                        ),
                      ),
                    ),
                  );
                }
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }



  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Text('Searching', style: TextStyle(color: Colors.black),),
      ),
    );
  }

}