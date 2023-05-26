class AmapEntity {
  AmapEntity({
    this.latitude,
    this.longitude,
    this.country,
    this.province,
    this.city,
    this.district,
    this.street,
    this.adCode,
    this.address,
    this.cityCode,
  });
  late final String? latitude;
  late final String? longitude;
  late final String? country;
  late final String? province;
  late final String? city;
  late final String? district;
  late final String? street;
  late final String? adCode;
  late final String? address;
  late final String? cityCode;

  AmapEntity.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    province = json['province'];
    city = json['city'];
    district = json['district'];
    street = json['street'];
    adCode = json['adCode'];
    address = json['address'];
    cityCode = json['cityCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['country'] = country;
    data['province'] = province;
    data['city'] = city;
    data['district'] = district;
    data['street'] = street;
    data['adCode'] = adCode;
    data['address'] = address;
    data['cityCode'] = cityCode;
    return data;
  }
}

class PoisResponseEntity {
  PoisResponseEntity({
    this.suggestion,
    this.count,
    this.infocode,
    this.pois,
  });
  late final SuggestionEntity? suggestion;
  late final String? count;
  late final String? infocode;
  late final List<PoisEntity>? pois;

  PoisResponseEntity.fromJson(Map<String, dynamic> json) {
    suggestion = SuggestionEntity.fromJson(json['suggestion']);
    count = json['count'];
    infocode = json['infocode'];
    pois = List.from(json['pois']).map((e) => PoisEntity.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['suggestion'] = suggestion?.toJson();
    data['count'] = count;
    data['infocode'] = infocode;
    data['pois'] = pois?.map((e) => e.toJson()).toList();
    return data;
  }
}

class SuggestionEntity {
  SuggestionEntity({
    this.keywords,
    this.cities,
  });
  late final List<dynamic>? keywords;
  late final List<dynamic>? cities;

  SuggestionEntity.fromJson(Map<String, dynamic> json) {
    keywords = List.castFrom<dynamic, dynamic>(json['keywords']);
    cities = List.castFrom<dynamic, dynamic>(json['cities']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['keywords'] = keywords;
    data['cities'] = cities;
    return data;
  }
}

class PoisEntity {
  PoisEntity({
    this.parent,
    required this.address,
    required this.distance,
    required this.pname,
    required this.importance,
    required this.bizExt,
    // required this.bizType,
    required this.cityname,
    required this.type,
    required this.photos,
    required this.typecode,
    required this.shopinfo,
    required this.poiweight,
    required this.childtype,
    required this.adname,
    required this.name,
    required this.location,
    required this.tel,
    required this.shopid,
    required this.id,
  });
  late final dynamic parent;
  late final String address;
  late final String distance;
  late final String pname;
  late final List<dynamic> importance;
  late final List<dynamic> bizExt;
  // late final dynamic bizType;
  late final String cityname;
  late final String type;
  late final List<dynamic> photos;
  late final String typecode;
  late final String shopinfo;
  late final List<dynamic> poiweight;
  late final dynamic childtype;
  late final String adname;
  late final String name;
  late final String location;
  late final dynamic tel;
  late final List<dynamic> shopid;
  late final String id;

  PoisEntity.fromJson(Map<String, dynamic> json) {
    parent = json['parent'];
    address = json['address'];
    distance = json['distance'];
    pname = json['pname'];
    importance = List.castFrom<dynamic, dynamic>(json['importance']);
    bizExt = List.castFrom<dynamic, dynamic>(json['biz_ext']);
    // bizType = List.castFrom<dynamic, dynamic>(json['biz_type']);
    cityname = json['cityname'];
    type = json['type'];
    photos = List.castFrom<dynamic, dynamic>(json['photos']);
    typecode = json['typecode'];
    shopinfo = json['shopinfo'];
    poiweight = List.castFrom<dynamic, dynamic>(json['poiweight']);
    childtype = json['childtype'];
    adname = json['adname'];
    name = json['name'];
    location = json['location'];
    tel = json['tel'];
    shopid = List.castFrom<dynamic, dynamic>(json['shopid']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parent'] = parent;
    data['address'] = address;
    data['distance'] = distance;
    data['pname'] = pname;
    data['importance'] = importance;
    data['biz_ext'] = bizExt;
    // data['biz_type'] = bizType;
    data['cityname'] = cityname;
    data['type'] = type;
    data['photos'] = photos;
    data['typecode'] = typecode;
    data['shopinfo'] = shopinfo;
    data['poiweight'] = poiweight;
    data['childtype'] = childtype;
    data['adname'] = adname;
    data['name'] = name;
    data['location'] = location;
    data['tel'] = tel;
    data['shopid'] = shopid;
    data['id'] = id;
    return data;
  }
}
