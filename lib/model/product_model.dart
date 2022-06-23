import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? description;
  int? price;
  double? ratings;
  List<Image>? images;
  Product(
      {this.name,
      this.description,
      this.price,
      this.ratings,
      this.images,
      this.id});
  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
