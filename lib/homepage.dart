import 'package:flutter/material.dart';
import 'package:gilbert_uas/createpage.dart';
import 'package:gilbert_uas/detailpage.dart';
import 'package:gilbert_uas/model.dart';
import 'package:gilbert_uas/response.dart';
import 'package:gilbert_uas/apiservice.dart';
import 'package:gilbert_uas/searchpage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text('Gilbert Instrument Music'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Pengelohan Data Penjualan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey[800],),
            ),

            // Fitur Search
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                readOnly: true,
                enableInteractiveSelection: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
                onTap: () {
                  showSearch(context: context, delegate: SearchPage());
                },
              ),
            ),

            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreatePage()));
              },
              child: Text("Tambah Data"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                foregroundColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ListBuilder(),
            ),
          ],
        ),
      ),
    );
  }


  Widget ListBuilder(){
    return FutureBuilder(
      future: apiService.get(),
      builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        } else if (snapshot.hasData) {
          PostResponse response = snapshot.data;
          List<Model> list = response.list;
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (context, index) {
                // Model model = list[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  margin: EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(list[index].nama_alatmusik.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity : ${list[index].quantity.toString()}'),
                          Text('Total Harga : Rp ${list[index].total_harga.toString()}'),
                        ],
                      ),
                      leading: Icon(Icons.music_note),
                      trailing: Icon(Icons.near_me),
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) =>
                                DetailPage(model: list[index],)));
                      },
                    ),
                  ),
                );
              });
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
