import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../resource/app_constants.dart';
import '../apis/app_exception.dart';
import 'base_service.dart';
import 'package:http/http.dart' as http;

class CharactersService extends BaseService{

  //Calls charactersResponse api and return characters json data
  @override
  Future getAllCharactersResponse() async {

    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(charactersBaseURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingCharacters);
    }
    return responseJson;
  }

  //Calls house characters data api with house name value and return house characters json model
  @override
  Future getHouseCharactersResponse(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(houseBaseURL + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingHouse);
    }
    return responseJson;
  }

  //Calls staff characters data api and return staff characters json model
  @override
  Future getStaffCharactersResponse() async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(staffBaseURL));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(AppConstants.noInternetError);
    } on Exception{
      throw Exception(AppConstants.errorLoadingStaff);
    }
    return responseJson;
  }

  //Returns response for apis
  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case AppConstants.responseSuccess:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case AppConstants.responseBadRequest:
        throw BadRequestException(response.body.toString());
      case AppConstants.responseInvalidAuthentication:
        throw InvalidAuthenticationException(response.body.toString());
      case AppConstants.responseUnauthorised:
        throw UnauthorisedException(response.body.toString());
      case AppConstants.responseInternalServerError:
        throw InternalServerException(response.body.toString());
      case AppConstants.responseServiceUnavailable:
        throw ServiceUnavailableException(response.body.toString());
      default:
        throw FetchDataException(
            AppConstants.communicationError+' ${response.statusCode}');
    }
  }

}