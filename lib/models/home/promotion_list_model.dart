
import 'package:json_annotation/json_annotation.dart';
import '../base_model.dart';

part 'promotion_list_model.g.dart';


@JsonSerializable()
class PromotionListModel extends BaseModel {

  List<Promotion> data;

  PromotionListModel(code,this.data,msg,):super(code,msg);

  factory PromotionListModel.fromJson(Map<String, dynamic> srcJson) => _$PromotionListModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PromotionListModelToJson(this);

}


@JsonSerializable()
class Promotion extends Object {

  int id;
  String promotionName;
  String startTime;
  String endTime;
  String showName;
  int isProcessing;

  Promotion(this.id,this.promotionName,this.startTime, this.endTime, this.showName, this.isProcessing,);


  factory Promotion.fromJson(Map<String, dynamic> srcJson) => _$PromotionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);

}

  
