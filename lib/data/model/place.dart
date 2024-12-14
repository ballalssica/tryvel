class Place {
  String id;
  String name;
  String category;
  String address;
  String holiday;
  String open;
  String close;
  String tel;
  String description;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.holiday,
    required this.open,
    required this.close,
    required this.tel,
    required this.description,
  });

  // 1. formJson 네임드 생성자 만들기
  Place.fromJson(Map<String, dynamic> map)
      : this(
            id: map['id'],
            name: map['name'],
            category: map['category'],
            address: map['address'],
            holiday: map['holiday'],
            open: map['open'],
            close: map['close'],
            tel: map['tel'],
            description: map['desciption']);

  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'address': address,
      'holiday': holiday,
      'open': open,
      'close': close,
      'tel': tel,
      'description': description,
    };
  }
}
