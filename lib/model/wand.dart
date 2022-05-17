import 'package:json_annotation/json_annotation.dart';

part 'wand.g.dart';

@JsonSerializable()
class Wand{

  String? wood;
  String? core;
  dynamic length;

  Wand({
    this.wood,
    this.core,
    this.length,
  });

  factory Wand.fromJson(Map<String, dynamic> json) => _$WandFromJson(json);
  Map<String, dynamic> toJson() => _$WandToJson(this);
}
