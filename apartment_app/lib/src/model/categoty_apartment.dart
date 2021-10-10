class CategoryApartment {
  late final String id;
  late final String name;

  CategoryApartment(this.id,this.name);

  CategoryApartment.fromJson(Map<dynamic, dynamic> json)
      : id = json['text'] as String,
        name = json['text'] as String;

  Map<dynamic, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
  };

}