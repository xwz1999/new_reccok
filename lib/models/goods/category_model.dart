import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  final List<FirstCategory>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryModel({
    this.data,
  });

  @override
  List<Object?> get props => [data];
}

@JsonSerializable()
class FirstCategory extends Equatable {
  final int? id;

  final String? name;

  final int? parentId;

  final String? logoUrl;

  final List<SecondCategory>? sub;

  factory FirstCategory.fromJson(Map<String, dynamic> json) =>
      _$FirstCategoryFromJson(json);

  FirstCategory({
    this.id,
    this.name,
    this.parentId,
    this.logoUrl,
    this.sub,
  });
  @override
  List<Object?> get props => [id,name,parentId,logoUrl,sub,];
}

@JsonSerializable()
class SecondCategory extends Equatable {
  final int? id;

  final String? name;

  final int? parentId;

  final String? logoUrl;

  SecondCategory(
    this.id,
    this.name,
    this.parentId,
    this.logoUrl,
  );

  @override
  List<Object?> get props => [id,name,parentId,logoUrl,];
  factory SecondCategory.fromJson(Map<String, dynamic> srcJson) =>
      _$SecondCategoryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SecondCategoryToJson(this);
}
