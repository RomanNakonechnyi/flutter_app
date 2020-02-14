import 'dart:convert';

SynonymModel synonymModelFromJson(String str) => SynonymModel.fromJson(json.decode(str));

String synonymModelToJson(SynonymModel data) => json.encode(data.toJson());

class SynonymModel {
  String word;
  List<String> synonyms;

  SynonymModel({
    this.word,
    this.synonyms,
  });

  factory SynonymModel.fromJson(Map<String, dynamic> json) => SynonymModel(
    word: json["word"],
    synonyms: List<String>.from(json["synonyms"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "synonyms": List<dynamic>.from(synonyms.map((x) => x)),
  };
}
