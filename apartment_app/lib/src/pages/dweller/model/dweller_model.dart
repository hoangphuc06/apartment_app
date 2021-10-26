class Dweller {
  Dweller({this.name,this.birthday});


  Dweller.fromJson(Map<String, Object?> json)
      : this(
    name: json['name']! as String,
    birthday: json['birthday']! as String,
  );

  String? name;
  String? birthday;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'birthday': birthday,
    };
  }
}