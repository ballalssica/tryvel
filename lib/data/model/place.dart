import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  String id;
  String name;
  String category;
  String address;
  String? addressDetail;
  String holiday;
  String open;
  String close;
  String tel;
  String description;
  String? imageUrl;
  double latitude;
  double longitude;
  Timestamp timestamp;
  String parking;

  Place({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.addressDetail,
    required this.holiday,
    required this.open,
    required this.close,
    required this.tel,
    required this.description,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.parking,
  });

  // Firestore 문서를 JSON으로 변환할 때 사용
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'address': address,
      'addressDetail': addressDetail,
      'holiday': holiday,
      'open': open,
      'close': close,
      'tel': tel,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
      'parking': parking,
    };
  }

  // Firestore 문서에서 데이터를 읽을 때 사용
  Place.fromJson(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        name = map['name'] ?? '',
        category = map['category'] ?? '',
        address = map['address'] ?? '',
        addressDetail = map['addressDetail'] ?? '',
        holiday = map['holiday'] ?? '',
        open = map['open'] ?? '',
        close = map['close'] ?? '',
        tel = map['tel'] ?? '',
        description = map['description'] ?? '',
        imageUrl = map['imageUrl'],
        latitude = _toDouble(map['latitude']),
        longitude = _toDouble(map['longitude']),
        timestamp = map['timestamp'] ?? Timestamp.now(),
        parking = map['parking'] ?? '';

  // latitude와 longitude 변환을 위한 헬퍼 메서드
  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    } else if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }
}
