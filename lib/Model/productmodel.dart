import 'package:json_annotation/json_annotation.dart';

part 'productmodel.g.dart';

@JsonSerializable()
class Product {
  List<Data>? data;
  Links? links;
  Meta? meta;

  Product({this.data, this.links, this.meta});

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductToJson(this);
  }
}

@JsonSerializable()
class Detail {
  Data? data;

  Detail({this.data});

  Detail.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class Data {
  int? id;
  String? title;
  String? description;
  Price? price;
  ImageData? image;

  Data({this.id, this.title, this.description, this.price, this.image});

  factory Data.fromJson(Map<String, dynamic> json) {
    return _$DataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DataToJson(this);
  }
}

@JsonSerializable()
class Price {
  String? value;
  String? currency;
  String? formatted;

  Price({this.value, this.currency, this.formatted});

  factory Price.fromJson(Map<String, dynamic> json) {
    return _$PriceFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$PriceToJson(this);
  }
}

@JsonSerializable()
class ImageData {
  int? id;
  String? fileName;
  Conversions? conversions;

  ImageData({this.id, this.fileName, this.conversions});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return _$ImageDataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageDataToJson(this);
  }
}

@JsonSerializable()
class Conversions {
  String? small;
  String? medium;
  String? large;
  Conversions({this.small, this.medium, this.large});

  factory Conversions.fromJson(Map<String, dynamic> json) {
    return _$ConversionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ConversionsToJson(this);
  }
}

@JsonSerializable()
class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) {
    return _$LinksFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LinksToJson(this);
  }
}

@JsonSerializable()
class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  String? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return _$MetaFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaToJson(this);
  }
}

@JsonSerializable()
class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromJson(Map<String, dynamic> json) {
    return _$LinkFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LinkToJson(this);
  }
}
