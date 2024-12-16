class PlaceAddState {
  final String storeName;
  final String category;
  final String address;
  final String addressDetail;
  final String holiday;
  final String operatingHours;
  final String parking;
  final String storeNumber;
  final String description;
  final String? imageUrl;
  final double latitude;
  final double longitude;

  PlaceAddState({
    this.storeName = '',
    this.category = '',
    this.address = '',
    this.addressDetail = '',
    this.holiday = '',
    this.operatingHours = '',
    this.parking = '',
    this.storeNumber = '',
    this.description = '',
    this.imageUrl,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  PlaceAddState copyWith({
    String? storeName,
    String? category,
    String? address,
    String? addressDetail,
    String? holiday,
    String? operatingHours,
    String? parking,
    String? storeNumber,
    String? description,
    String? imageUrl,
    double? latitude,
    double? longitude,
  }) {
    return PlaceAddState(
      storeName: storeName ?? this.storeName,
      category: category ?? this.category,
      address: address ?? this.address,
      addressDetail: addressDetail ?? this.addressDetail,
      holiday: holiday ?? this.holiday,
      operatingHours: operatingHours ?? this.operatingHours,
      parking: parking ?? this.parking,
      storeNumber: storeNumber ?? this.storeNumber,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
