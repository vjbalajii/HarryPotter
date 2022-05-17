import 'package:harry_potter/model/wand.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable(explicitToJson: true)
class Character{

  String? name;
  List<dynamic>? alternate_names;
  String? species;
  String? gender;
  String? house;
  String? dateOfBirth;
  dynamic yearOfBirth;
  bool? wizard;
  String? ancestry;
  String? eyeColour;
  String? hairColour;
  Wand? wand;
  String? patronus;
  bool? hogwartsStudent;
  bool? hogwartsStaff;
  String? actor;
  List<dynamic>? alternate_actors;
  bool? alive;
  String? image;


  Character({
    this.name,
    List<String>? alternateNames,
    this.species,
    this.gender,
    this.house,
    this.dateOfBirth,
    this.yearOfBirth,
    this.wizard,
    this.ancestry,
    this.eyeColour,
    this.hairColour,
    this.wand,
    this.patronus,
    this.hogwartsStudent,
    this.hogwartsStaff,
    this.actor,
    List<String>? alternateActors,
    this.alive,
    this.image,
  }): alternate_names = alternateNames ?? <String>[], alternate_actors = alternateActors ?? <String>[] ;


  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);




}