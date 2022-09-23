// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



ShoppingCartBrandModel _$ShoppingCartBrandModelFromJson(
    Map<String, dynamic> json) {
  return ShoppingCartBrandModel(
      json['id'] as int?,
      json['brandID'] as int?,
      json['brandLogo'] as String?,
      json['brandName'] as String?,
      (json['children'] as List?)
          ?.map((e) => ShoppingCartGoodsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['selected'] as bool?);
}

Map<String, dynamic> _$ShoppingCartBrandModelToJson(
        ShoppingCartBrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandID': instance.brandID,
      'brandLogo': instance.brandLogo,
      'brandName': instance.brandName,
      'children': instance.children,
      'selected': instance.selected
    };

ShoppingCartGoodsModel _$ShoppingCartGoodsModelFromJson(
    Map<String, dynamic> json) {
  return ShoppingCartGoodsModel(
    json['shoppingTrolleyId'] as int?,
    json['goodsId'] as int?,
    json['goodsName'] as String?,
    json['mainPhotoUrl'] as String?,
    json['skuName'] as String?,
    json['skuId'] as int?,
    json['quantity'] as int?,
    (json['price'] as num?)?.toDouble(),
    json['selected'] as bool?,
    (json['publish_status'] as num?) as int?,

  );
}

Map<String, dynamic> _$ShoppingCartGoodsModelToJson(
        ShoppingCartGoodsModel instance) =>
    <String, dynamic>{
      'shoppingTrolleyId': instance.shoppingTrolleyId,
      'goodsId': instance.goodsId,
      'goodsName': instance.goodsName,
      'mainPhotoUrl': instance.mainPhotoUrl,
      'skuName': instance.skuName,
      'skuId': instance.skuId,
      'quantity': instance.quantity,

      'price': instance.price,

      'selected': instance.selected,

      'publish_status': instance.publishStatus,
    };
