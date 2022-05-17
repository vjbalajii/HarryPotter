import 'dart:convert';
import 'package:harry_potter/model/character.dart';
import 'package:harry_potter/model/services/characters_service.dart';

import '../services/base_service.dart';


abstract class CharactersRepository {

  Future<List<Character>> fetchAllCharactersData();
  Future<List<Character>> fetchHouseCharactersData(String value);
  Future<List<Character>> fetchStaffCharactersData();
}

class CharactersRepositoryImpl extends CharactersRepository{
  final BaseService _characterService = CharactersService();

  ///Fetches all character data api and return character models
  @override
  Future<List<Character>> fetchAllCharactersData() async {
    dynamic response = await _characterService.getAllCharactersResponse();

    List<dynamic> parsedListJson = response;
    List<Character> charactersList = List<Character>.from(parsedListJson.map((i) => Character.fromJson(i)));


    return charactersList;
  }

  ///Fetches house character data api with house name value and return character models
  @override
  Future<List<Character>> fetchHouseCharactersData(String value) async {
    dynamic response = await _characterService.getHouseCharactersResponse(value);

    List<dynamic> parsedListJson = response;
    List<Character> charactersList = List<Character>.from(parsedListJson.map((i) => Character.fromJson(i)));

    return charactersList;
  }

  ///Fetches staff character data api and return character models
  @override
  Future<List<Character>> fetchStaffCharactersData() async {
    dynamic response = await _characterService.getStaffCharactersResponse();

    List<dynamic> parsedListJson = response;
    List<Character> charactersList = List<Character>.from(parsedListJson.map((i) => Character.fromJson(i)));

    return charactersList;
  }


}