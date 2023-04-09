// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : Links.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'data': instance.data,
      'links': instance.links,
      'meta': instance.meta,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : ImageData.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      value: json['value'] as String?,
      currency: json['currency'] as String?,
      formatted: json['formatted'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'value': instance.value,
      'currency': instance.currency,
      'formatted': instance.formatted,
    };

ImageData _$ImageDataFromJson(Map<String, dynamic> json) => ImageData(
      id: json['id'] as int?,
      fileName: json['fileName'] as String?,
      conversions: json['conversions'] == null
          ? null
          : Conversions.fromJson(json['conversions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageDataToJson(ImageData instance) => <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'conversions': instance.conversions,
    };

Conversions _$ConversionsFromJson(Map<String, dynamic> json) => Conversions(
      small: json['small'] as String?,
      medium: json['medium'] as String?,
      large: json['large'] as String?,
    );

Map<String, dynamic> _$ConversionsToJson(Conversions instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      currentPage: json['currentPage'] as int?,
      from: json['from'] as int?,
      lastPage: json['lastPage'] as int?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: json['perPage'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'currentPage': instance.currentPage,
      'from': instance.from,
      'lastPage': instance.lastPage,
      'links': instance.links,
      'path': instance.path,
      'perPage': instance.perPage,
      'to': instance.to,
      'total': instance.total,
    };

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'url': instance.url,
      'label': instance.label,
      'active': instance.active,
    };
