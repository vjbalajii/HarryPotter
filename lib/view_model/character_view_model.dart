import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:harry_potter/model/character.dart';
import 'package:harry_potter/model/repository/characters_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/apis/api_response.dart';
import '../resource/app_colors.dart';
import '../resource/app_constants.dart';

abstract class CharactersViewModel with ChangeNotifier{

  CharactersViewModel({
    required this.repo,
  });

  final CharactersRepository repo;

  ApiResponse _allCharactersResponse = ApiResponse.initial(AppConstants.emptyData);
  ApiResponse _houseCharactersResponse = ApiResponse.initial(AppConstants.emptyData);
  ApiResponse _staffCharactersResponse = ApiResponse.initial(AppConstants.emptyData);

  ApiResponse get allCharactersResponse;

  ApiResponse get houseCharactersResponse;

  ApiResponse get staffCharactersResponse;

  List<Character>? get allCharacterList;

  List<Character>? get houseCharacterList;

  List<Character>? get staffCharacterList;

  Future<List<Character>?> fetchAllCharactersData();

  Future<List<Character>?> fetchHouseCharactersData(String value);

  Future<List<Character>?> fetchStaffCharactersData();
}

class CharactersViewModelImpl extends CharactersViewModel{

  List<Character>? _allCharacters;
  List<Character>? _houseCharacters;
  List<Character>? _staffCharacters;

  CharactersViewModelImpl({required CharactersRepository repo})
      : super(repo: repo);

  @override
  ApiResponse get allCharactersResponse {
    return _allCharactersResponse;
  }

  @override
  ApiResponse get houseCharactersResponse {
    return _houseCharactersResponse;
  }


  @override
  ApiResponse get staffCharactersResponse {
    return _staffCharactersResponse;
  }


  @override
  List<Character>? get allCharacterList {
    return _allCharacters!;
  }

  @override
  List<Character>? get houseCharacterList {
    return _houseCharacters!;
  }

  @override
  List<Character>? get staffCharacterList {
    return _staffCharacters!;
  }


  ///Fetch all character data and return characters list
  @override
  Future<List<Character>?> fetchAllCharactersData() async {
    _allCharactersResponse = ApiResponse.loading(AppConstants.fetchingData);
    notifyListeners();
    List<Character> allCharacters = [];
    try {
      allCharacters = await repo.fetchAllCharactersData();
      _allCharactersResponse = ApiResponse.completed(allCharacters);
    } catch (e) {
      _allCharactersResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return allCharacters;
  }


  ///Fetch house character data and return characters list
  @override
  Future<List<Character>?> fetchHouseCharactersData(String value) async {
    _houseCharactersResponse = ApiResponse.loading(AppConstants.fetchingData);
    List<Character> houseCharacters = [];
    notifyListeners();
    try {
      houseCharacters = await repo.fetchHouseCharactersData(value);
      _houseCharactersResponse = ApiResponse.completed(houseCharacters);
    } catch (e) {
      _houseCharactersResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return houseCharacters;
  }


  ///Fetch staff character data and return characters list
  @override
  Future<List<Character>?> fetchStaffCharactersData() async {
    _staffCharactersResponse = ApiResponse.loading(AppConstants.fetchingData);
    List<Character> staffCharacters = [];
    notifyListeners();
    try {
      staffCharacters = await repo.fetchStaffCharactersData();
      _staffCharactersResponse = ApiResponse.completed(staffCharacters);
    } catch (e) {
      _staffCharactersResponse = ApiResponse.error(e.toString());
      print(e);
      rethrow;
    }
    notifyListeners();
    return staffCharacters;
  }

}