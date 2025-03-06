import 'package:flutter/material.dart';
import 'package:gilbert_uas/model.dart';
import 'package:gilbert_uas/apiservice.dart';
import 'package:gilbert_uas/homepage.dart';

class CreatePage extends StatefulWidget {
  Model? model;
  CreatePage({super.key, this.model});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final apiService = ApiService();
  final tecTanggal = TextEditingController();
  final tecNama = TextEditingController();
  final tecHarga = TextEditingController();
  final tecQty = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? valueDropdown;
  var DropdownItem = [
    "Gitar", "Piano", "Drum"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Back'),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Form Tambah Data",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.grey[800],),
            ),
            Container(
              margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(20),

                ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: tecTanggal,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Mohon Diisi Tanggal'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Pilih Tanggal',
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today_rounded),
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                        ),
                        readOnly: true,
                        onTap: (){
                          selectDate();
                        },
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: tecNama,
                        decoration: InputDecoration(
                            labelText: 'Nama', hintText: 'Masukkan Nama',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Mohon Diisi Nama' : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 65,
                        padding: EdgeInsets.only(left: 15, right: 15, top: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5,color: Colors.black),
                        ),
                        child: DropdownButton(
                          hint: Text("Jenis Alat Musik") ,
                          value: valueDropdown,
                          icon: Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              valueDropdown = newValue;
                            });
                            },
                          items: DropdownItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem) ,
                              );
                            }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: tecHarga,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Harga per item', hintText: 'Masukkan Harga',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Mohon Masukkan Harga' : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: tecQty,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Quantity', hintText: 'Masukkan Quantity',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.5,
                            ),
                          ),),
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Mohon masukkan quantity' : null,
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[100],
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                int total = int.parse(tecQty.text) * int.parse(tecHarga.text);
                                String? jenis = valueDropdown;

                                await apiService.create(tecTanggal.text.toString(),
                                    tecNama.text.toString(), int.parse(tecHarga.text),
                                  int.parse(tecQty.text), total, jenis);

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Data berhasil ditambahkan')));

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                        (route) => false);
                                 }
                            },
                            child: Text('Tambah')
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future selectDate() async{
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050)
    );

    if (date != null){
      setState(() {
        tecTanggal.text = date.toString().split(" ")[0];
      });
    }
  }

}
