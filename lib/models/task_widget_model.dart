// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

Model welcomeFromJson(String str) => Model.fromJson(json.decode(str));

String welcomeToJson(Model data) => json.encode(data.toJson());

class Model {
    Model({
        this.date,
       required this.data,

    });
       String? date;
       String data;
      

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        date: json["date"],
        data: json["data"],
       
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "data": data,
      
    };
}
