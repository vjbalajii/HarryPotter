import '../../resource/app_constants.dart';

abstract class BaseService{

  final String charactersBaseURL = AppConstants.charactersBaseURL;
  final String houseBaseURL = AppConstants.houseBaseURL;
  final String staffBaseURL = AppConstants.staffBaseURL;

  Future<dynamic> getAllCharactersResponse();
  Future<dynamic> getHouseCharactersResponse(String url);
  Future<dynamic> getStaffCharactersResponse();

}