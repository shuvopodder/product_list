import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class getData with ChangeNotifier{
  List<ListData> data = [];

  Future getListData() async{
    var response =
    await http.get(
        Uri.parse('https://fakestoreapi.com/products'));

    var jsonData = json.decode(response.body);
    for(var u in jsonData){
      ListData list = ListData(u["id"],u["title"],u["price"],
          u["description"],u["category"],u["image"], u['rating']["rate"],u['rating']["count"]);
      data.add(list);
    }

    notifyListeners();
    return data;
  }
}

class ListData{
  final String title, description, category, image;
  final int id, count;
  final num price,rate;
  ListData(this.id,this.title,this.price,this.description,
      this.category, this.image, this.rate, this.count);
}