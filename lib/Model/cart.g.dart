// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      cart: json['data'] == null
          ? null
          : Cart.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'data': instance.cart,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as int?,
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      items: json['items'] as int?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'total': instance.total,
      'items': instance.items,
      'products': instance.products,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      value: json['value'] as String?,
      currency: json['currency'] as String?,
      formatted: json['formatted'] as String?,
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
      'formatted': instance.formatted,
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      unitPrice: json['unit_price'] == null
          ? null
          : Total.fromJson(json['unit_price'] as Map<String, dynamic>),
      totalQuantity: json['total_quantity'] as int?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'total': instance.total,
      'unit_price': instance.unitPrice,
      'total_quantity': instance.totalQuantity,
    };
