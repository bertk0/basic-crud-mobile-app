import 'package:gilbert_uas/model.dart';

class PostResponse{
  List<Model> list = [];

  PostResponse.fromJson(json){
    for(int i = 0; i < json.length;i++){
      Model model = Model.fromJson(json[i]);
      list.add(model);
    }
  }
}


