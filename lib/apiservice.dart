import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gilbert_uas/model.dart';
import 'package:gilbert_uas/response.dart';

class ApiService {
  Future<PostResponse?> get() async {
    try {
      final response = await Dio().get("http://10.0.2.2/penjualan_alatmusik_api/get.php");
      debugPrint('Get Data : ${response.data}');
      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Model?> create(String tanggal, String nama, int harga, int quantity, int total,String? jenis) async {
    try {
      final response = await Dio().post("http://10.0.2.2/penjualan_alatmusik_api/create.php",
          data: {"tanggal_penjualan": tanggal, "nama_alatmusik": nama, "harga_alatmusik": harga,
          "quantity": quantity, "total_harga":total, "jenis_alatmusik":jenis });
      debugPrint('create : ${response.data}');
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Model?> update(String id, String tanggal, String nama, int harga, int quantity, int total,String? jenis) async {
    try {
      final response = await Dio().put("http://10.0.2.2/penjualan_alatmusik_api/update.php",
          data: {"id" : id, "tanggal_penjualan": tanggal, "nama_alatmusik": nama, "harga_alatmusik": harga,
            "quantity": quantity, "total_harga":total, "jenis_alatmusik":jenis });
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Model?> delete(String id) async {
    try {
      final response = await Dio().delete("http://10.0.2.2/penjualan_alatmusik_api/delete.php",
          data: {"id" : id });
      return null;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PostResponse?> search(String? query) async{
    try{
      final response = await Dio().get("http://10.0.2.2/penjualan_alatmusik_api/search.php/?keyword=${query}");
      return PostResponse.fromJson(response.data);
    }on DioException catch(e){
      debugPrint(e.toString());
    }
  }
}
