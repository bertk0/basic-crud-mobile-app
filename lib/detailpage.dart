import 'package:flutter/material.dart';
import 'package:gilbert_uas/model.dart';
import 'package:gilbert_uas/apiservice.dart';
import 'package:gilbert_uas/updatepage.dart';
import 'package:gilbert_uas/homepage.dart';

class DetailPage extends StatefulWidget {
  final Model model;
  DetailPage({required this.model});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Back"),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Text(
            "Detail Data Penjualan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey[800],),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black),
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tanggal Transaksi : ${widget.model.tanggal_penjualan}',
                    style: TextStyle(fontSize: 22, color: Colors.white),),
                  SizedBox(height: 10,),
                  Text('Nama Item : ${widget.model.nama_alatmusik}',
                    style: TextStyle(fontSize: 16,color: Colors.black),),
                  SizedBox(height: 10,),
                  Text('Jenis Item : ${widget.model.jenis_alatmusik}',
                    style: TextStyle(fontSize: 16,color: Colors.black),),
                  SizedBox(height: 10,),
                  Text('Harga per Item : Rp ${widget.model.harga_alatmusik}',
                    style: TextStyle(fontSize: 16,color: Colors.black),),
                  SizedBox(height: 10,),
                  Text('Quantity  : ${widget.model.quantity}',
                    style: TextStyle(fontSize: 16,color: Colors.black),),
                  SizedBox(height: 10,),
                  Text('Total Harga : Rp ${widget.model.total_harga}',
                    style: TextStyle(fontSize: 16,color: Colors.black),),
                  SizedBox(height: 20,),

                  ButtonBar(
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext context)
                              => UpdatePage(model : widget.model)));
                        },
                        child: Text("Edit"),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  title: Text('Hapus Data Penjualan'),
                                  content: Text('Hapus Data ini?'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel')),

                                    ElevatedButton(
                                      onPressed: () async {
                                       await apiService.delete(widget.model.id.toString());
                                        debugPrint(widget.model.id.toString());

                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                           content: Text('Data berhasil dihapus')));

                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage()),
                                                (route) => false);
                                      },
                                      child: Text('OK'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[400],
                                        foregroundColor: Colors.white,
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Text("Hapus"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
