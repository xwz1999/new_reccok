// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => FirstCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

FirstCategory _$FirstCategoryFromJson(Map<String, dynamic> json) {
  return FirstCategory(
    id: json['id'] as int?,
    name: json['name'] as String?,
    parentId: json['parentId'] as int?,
    logoUrl: json['logoUrl'] as String?,
    sub: (json['sub'] as List<dynamic>?)
        ?.map((e) => SecondCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}


SecondCategory _$SecondCategoryFromJson(Map<String, dynamic> json) {
  return SecondCategory(
    json['id'] as int?,
    json['name'] as String?,
    json['parentId'] as int?,
    json['logoUrl'] as String?,
  );
}

Map<String, dynamic> _$SecondCategoryToJson(SecondCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'logoUrl': instance.logoUrl,
    };
