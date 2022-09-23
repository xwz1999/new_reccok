
import 'package:json_annotation/json_annotation.dart';



part 'shopping_cart_list_model.g.dart';


@JsonSerializable()
class ShoppingCartBrandModel extends Object {
  int? id;

  int? brandID;

  String? brandLogo;

  String? brandName;

  List<ShoppingCartGoodsModel>? children;

  bool? selected;
  bool? isShowMore;
  ShoppingCartBrandModel(this.id, this.brandID, this.brandLogo, this.brandName,
      this.children, this.selected) {
    this.selected = false;
    isShowMore = false;
  }

  factory ShoppingCartBrandModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShoppingCartBrandModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShoppingCartBrandModelToJson(this);

}

@JsonSerializable()
class ShoppingCartGoodsModel extends Object {
  int? shoppingTrolleyId;
  int? goodsId;

  String? goodsName;

  String? mainPhotoUrl;

  String? skuName;

  int? skuId;

  int? quantity;

  num? price;

  bool? selected;

  int? publishStatus;


  ShoppingCartGoodsModel(
    this.shoppingTrolleyId,
    this.goodsId,
    this.goodsName,
    this.mainPhotoUrl,
    this.skuName,
    this.skuId,
    this.quantity,
    this.price,
    this.selected,
    this.publishStatus,

  ) {
    this.selected = false;
  }

  factory ShoppingCartGoodsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShoppingCartGoodsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShoppingCartGoodsModelToJson(this);

  ShoppingCartGoodsModel.empty();


}
