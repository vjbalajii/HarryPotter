import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  //URLS
  static const String charactersBaseURL = 'http://hp-api.herokuapp.com/api/characters';
  static const String houseBaseURL = 'http://hp-api.herokuapp.com/api/characters/house/';
  static const String staffBaseURL = 'http://hp-api.herokuapp.com/api/characters/staff';

  static const String emptyImage = 'assets/images/ic_empty.png';

  //RESPONSE_CODES
  static const responseSuccess = 200;
  static const responseBadRequest = 400;
  static const responseInvalidAuthentication = 401;
  static const responseUnauthorised = 403;
  static const responseInternalServerError = 500;
  static const responseServiceUnavailable = 503;

  //EXCEPTIONS
  static const String fetchError = 'Error During Fetch: ';
  static const String invalidRequest = 'Invalid Request: ';
  static const String unauthorisedRequest = 'Unauthorised Request: ';
  static const String invalidAuthentication = 'Invalid Authentication Error: ';
  static const String internalServerError = 'Internal Server Error: ';
  static const String serviceUnavailableError = 'Service Unavailable Error: ';
  static const String invalidInputError = 'Invalid Input: ';
  static const String noInternetError = 'No Internet Connection';
  static const String communicationError = 'Error occurred while communication with server' ' with status code :';

  //VIEW TEXTS
  static const String viewCharacter = 'Character';
  static const String viewHarryPotter = 'Harry Potter';
  static const String viewAllCharacters = 'All Characters';
  static const String viewHouse = 'House';
  static const String viewStaffs = 'Staffs';

  //INFO TEXTS
  static const String enterCharacterName = 'Enter character name';
  static const String enterHouseName = 'Enter house name';
  static const String enterHouseNameInfo = 'Enter house name to fetch data';
  static const String enterStaffName = 'Enter staff name';
  static const String errorLoadingCharacters = 'Error loading characters data!';
  static const String errorLoadingHouse = 'Error loading house data!';
  static const String errorLoadingStaff = 'Error loading staff data!';
  static const String emptyData = 'Empty data';
  static const String fetchingData = 'Fetching data';
  static const String toastInvalidHouse = 'Invalid house value';

  //DATE FORMATS
  static const String lastRefreshDateFormat = 'dd MMM yyyy, HH:mm:ss';
  static const convertToMilliseconds = 1000;
  static const oneSecond = 1;

  //TEXT FORMAT
  static const onlyAlphabets = r'[a-z]';
  
  //SPACES & MARGINS
  static const containerBig = 300.0;
  static const containerSmall = 150.0;
  static const imageHeight = 150.0;
  static const imageWidth = 120.0;
  static const tabBarHeight = 60.0;
  static const toastSize = 16.0;
  static const spaceBig = 20.0;
  static const spaceMedium = 16.0;
  static const spaceSmall = 8.0;
  static const radiusBig = 25.0;
  static const dimensionBig = 16.0;
  static const dimensionMedium = 8.0;
  static const dimensionSmall = 4.0;
  static const dimensionZero = 0.0;
  static const divider = 2.0;
  static const alphaMedium = 50;
  static const alphaHigh = 100;
}