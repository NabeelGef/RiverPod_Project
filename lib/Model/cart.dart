import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';

@JsonSerializable()
class CartItem {
  Cart? cart;

  CartItem({this.cart});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return _$CartItemFromJson(json);
  }
  Map<String, dynamic> toJson() {
    return _$CartItemToJson(this);
  }
}

@JsonSerializable()
class Cart {
  int? id;
  Total? total;
  int? items;
  List<Products>? products;

  Cart({this.id, this.total, this.items, this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return _$CartFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartToJson(this);
  }
}

@JsonSerializable()
class Total {
  String? value;
  String? currency;
  String? formatted;

  Total({this.value, this.currency, this.formatted});

  factory Total.fromJson(Map<String, dynamic> json) {
    return _$TotalFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TotalToJson(this);
  }
}

@JsonSerializable()
class Products {
  int? id;
  int? productId;
  Total? total;
  Total? unitPrice;
  int? totalQuantity;

  Products(
      {this.id,
      this.productId,
      this.total,
      this.unitPrice,
      this.totalQuantity});

  factory Products.fromJson(Map<String, dynamic> json) {
    return _$ProductsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsToJson(this);
  }
}
