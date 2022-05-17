import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:harry_potter/model/repository/characters_repository.dart';
import 'package:harry_potter/utils/CachedImage.dart';
import 'package:harry_potter/view_model/character_view_model.dart';
import 'package:provider/provider.dart';
import '../../model/apis/api_response.dart';
import '../../model/character.dart';
import '../../resource/app_colors.dart';
import '../../resource/app_constants.dart';
import '../../resource/app_styles.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _allSearchInputController = TextEditingController();
  final _houseSearchInputController = TextEditingController();
  final _staffSearchInputController = TextEditingController();

  String? _houseInputText = '';

  List<Character>? _allCharactersSearchList = [];
  List<Character>? _allCharactersList = [];

  List<Character>? _staffCharactersSearchList = [];
  List<Character>? _staffCharactersList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CharactersViewModel>(context, listen: false).fetchAllCharactersData();
      Provider.of<CharactersViewModel>(context, listen: false).fetchStaffCharactersData();
    });
  }

  @override
  Widget build(BuildContext context) {

    ApiResponse allCharactersResponse = Provider.of<CharactersViewModel>(context).allCharactersResponse;
    ApiResponse houseCharactersResponse = Provider.of<CharactersViewModel>(context).houseCharactersResponse;
    ApiResponse staffCharactersResponse = Provider.of<CharactersViewModel>(context).staffCharactersResponse;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppColors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: AppConstants.containerSmall,
              width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(AppConstants.spaceBig),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.grey.shade800,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: const [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(AppConstants.viewCharacter, style: AppStyles.textSubTitleWhite,),
                  Text(AppConstants.viewHarryPotter, style: AppStyles.textTitleWhiteBold,),
                ],
              )
            ),
            Expanded(
              child: Container(
                child: ContainedTabBarView(
                  tabs: const [
                    Text(AppConstants.viewAllCharacters),
                    Text(AppConstants.viewHouse),
                    Text(AppConstants.viewStaffs),
                  ],
                  tabBarProperties: TabBarProperties(
                    height: AppConstants.tabBarHeight,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(left: AppConstants.spaceBig),
                    position: TabBarPosition.top,
                    alignment: TabBarAlignment.start,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.black,
                    labelStyle: AppStyles.textSubTitleBlack,
                    unselectedLabelColor: AppColors.grey.withAlpha(AppConstants.alphaHigh),
                  ),
                  views: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppConstants.spaceBig),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                            borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusBig)),
                          ),
                          child: buildAllCharactersSearchWidget(),
                        ),
                        Expanded(child: getAllCharactersWidget(context, allCharactersResponse)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppConstants.spaceBig),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                            borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusBig)),
                          ),
                          child: buildHouseCharactersSearchWidget(),
                        ),
                        Expanded(child: getHouseCharactersWidget(context, houseCharactersResponse)),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppConstants.spaceBig),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                            borderRadius: const BorderRadius.all(Radius.circular(AppConstants.radiusBig)),
                          ),
                          child: buildStaffCharactersSearchWidget(),
                        ),
                        Expanded(child: SizedBox(child: getStaffCharactersWidget(context, staffCharactersResponse))),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Search all character text field
  TextField buildAllCharactersSearchWidget() {
    return TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _allSearchInputController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(AppConstants.onlyAlphabets)),
        ],
        onChanged: onAllCharacterSearchTextChanged,
        onSubmitted: (value) {
          callAllCharacterData();
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: AppConstants.spaceMedium),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: AppConstants.enterCharacterName,
            suffixIcon: IconButton(onPressed: (){
            }, icon: Icon(Icons.search, color: AppColors.grey,))
        )
    );
  }

  //Search house text field
  TextField buildHouseCharactersSearchWidget() {
    return TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _houseSearchInputController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(AppConstants.onlyAlphabets)),
        ],
        onChanged: (value) {
          setState(() {
            _houseInputText = _houseSearchInputController.text.toString();
          });
        },
        onSubmitted: (value) {
          callHouseData();
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: AppConstants.spaceMedium),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: AppConstants.enterHouseName,
            suffixIcon: IconButton(onPressed: (){
              callHouseData();
            }, icon: Icon(Icons.search, color: AppColors.grey,))
        )
    );
  }

  //Search staff text field
  TextField buildStaffCharactersSearchWidget() {
    return TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _staffSearchInputController,
        keyboardType: TextInputType.name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(AppConstants.onlyAlphabets)),
        ],
        onChanged: onStaffCharacterSearchTextChanged,
        onSubmitted: (value) {
          callAllCharacterData();
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: AppConstants.spaceMedium),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: AppConstants.enterStaffName,
            suffixIcon: IconButton(onPressed: (){
            }, icon: Icon(Icons.search, color: AppColors.grey,))
        )
    );
  }

  void callHouseData() {
    if (_houseInputText!.isNotEmpty) {
      Provider.of<CharactersViewModel>(context, listen: false)
          .fetchHouseCharactersData(_houseInputText!);
    }else{
      showToast(context, AppConstants.toastInvalidHouse);
    }
  }

  void callAllCharacterData() {
    Provider.of<CharactersViewModel>(context, listen: false)
        .fetchAllCharactersData();
  }

  SizedBox buildAllSearchDataInfoWidget() {
    return SizedBox(
      height: AppConstants.containerBig,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: AppConstants.containerSmall, color: AppColors.grey,),
            const SizedBox(height: AppConstants.spaceBig,),
            const Text(AppConstants.enterCharacterName),
          ],
        ),
      ),
    );
  }

  SizedBox buildHouseSearchDataInfoWidget() {
    return SizedBox(
      height: AppConstants.containerBig,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: AppConstants.containerSmall, color: AppColors.grey,),
            const SizedBox(height: AppConstants.spaceBig,),
            const Text(AppConstants.enterHouseNameInfo),
          ],
        ),
      ),
    );
  }

  Widget getAllCharactersWidget(BuildContext context, ApiResponse apiResponse) {
    List<Character>? _characters = apiResponse.data;

    setState(() {
      _allCharactersList = _characters;
    });

    switch (apiResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return _allCharactersSearchList!.isNotEmpty || _allSearchInputController.text.isNotEmpty ?
        Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _allCharactersSearchList!.length,
            itemBuilder: (BuildContext context, int index) {
              Character data = _allCharactersSearchList![index];
              return buildCharacterItem(data);
            },
          ),
        ):Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _characters!.length,
            itemBuilder: (BuildContext context, int index) {
              Character data = _characters[index];
              return buildCharacterItem(data);
            },
          ),
        );
      case Status.ERROR:
        return buildErrorCharactersWidget();
      case Status.INITIAL:
      default:
        return Container();
    }
  }

  Widget getHouseCharactersWidget(BuildContext context, ApiResponse apiResponse) {
    List<Character>? _characters = apiResponse.data;

    switch (apiResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _characters!.length,
            itemBuilder: (BuildContext context, int index) {
              Character data = _characters[index];
              return buildCharacterItem(data);
            },
          ),
        );
      case Status.ERROR:
        return buildErrorCharactersWidget();
      case Status.INITIAL:
      default:
        return buildHouseSearchDataInfoWidget();
    }
  }

  Widget getStaffCharactersWidget(BuildContext context, ApiResponse apiResponse) {
    List<Character>? _characters = apiResponse.data;

    setState(() {
      _staffCharactersList = _characters;
    });
    switch (apiResponse.status) {
      case Status.LOADING:
        return buildLoadingWidget();
      case Status.COMPLETED:
        return _staffCharactersSearchList!.isNotEmpty || _staffSearchInputController.text.isNotEmpty ?
        Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _staffCharactersSearchList!.length,
            itemBuilder: (BuildContext context, int index) {
              Character data = _staffCharactersSearchList![index];
              return buildCharacterItem(data);
            },
          ),
        ):Scrollbar(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: _characters!.length,
            itemBuilder: (BuildContext context, int index) {
              Character data = _characters[index];
              return buildCharacterItem(data);
            },
          ),
        );
      case Status.ERROR:
        return buildErrorCharactersWidget();
      case Status.INITIAL:
      default:
        return Container();
    }
  }

  SizedBox buildLoadingWidget() => const SizedBox(height: AppConstants.containerBig, child: Center(child: CircularProgressIndicator()));

  SizedBox buildErrorCharactersWidget() {
    return const SizedBox(
      height: AppConstants.containerBig,
      child: Center(
        child: Text(AppConstants.errorLoadingCharacters),
      ),
    );
  }

  Widget buildCharacterItem(Character character){
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.spaceBig, left: AppConstants.spaceBig, right : AppConstants.spaceMedium,),
      child: Stack(
        children: [
          Container(
            height: AppConstants.containerSmall,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: AppConstants.dimensionBig, left: AppConstants.dimensionBig),
            padding: const EdgeInsets.only(top: AppConstants.spaceBig, left: 120, right: AppConstants.spaceBig, bottom: AppConstants.spaceBig),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.all(Radius.circular(AppConstants.dimensionBig)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withAlpha(AppConstants.alphaMedium),
                  spreadRadius: AppConstants.dimensionSmall,
                  blurRadius: AppConstants.dimensionMedium,
                  offset: const Offset(AppConstants.dimensionZero, AppConstants.dimensionSmall), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(character.house!, style: AppStyles.textDetailBlack,),
                Text(character.name!, style: AppStyles.textTitleBlackBold, overflow: TextOverflow.fade, maxLines: 1,),
                const SizedBox(height: 5,),
                character.hogwartsStudent!? Text("Hogwarts Student", style: AppStyles.textDetailBlack,):Container(),
                const SizedBox(height: 2,),
                character.hogwartsStaff!? Text("Hogwarts Staff", style: AppStyles.textDetailBlack,):Container(),
                Text(capitalize(character.species!)+" | "+capitalize(character.gender!), style: AppStyles.textDetailBlack,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    character.wizard!? Container(
                      padding: const EdgeInsets.symmetric(horizontal:AppConstants.spaceBig,vertical:AppConstants.spaceSmall,),
                      decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(AppConstants.dimensionBig)),
                    ),
                        child: Text("Wizard", style: AppStyles.textBodyBlackBold,)):
                    Text(character.dateOfBirth!, style: AppStyles.textTitleBlackBold,),
                    Icon(Icons.chevron_right, color: AppColors.grey.withAlpha(AppConstants.alphaMedium), )
                  ],
                ),
              ],
            ),
          ),
          CachedImage(url: character.image),
        ],
      ),
    );
  }
  
  String capitalize(String value) {
    return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  onAllCharacterSearchTextChanged(String text) async {
    _allCharactersSearchList!.clear();
    if (text.isEmpty) {
      setState(() {
        _allCharactersSearchList = _allCharactersSearchList;
      });
      return;
    }

    print(_allCharactersList!.length);

    for (var character in _allCharactersList!) {
      if (character.name!.toLowerCase().contains(text)){
        _allCharactersSearchList!.add(character);
      }
    }
    setState(() {
      _allCharactersSearchList = _allCharactersSearchList;
    });
  }

  onStaffCharacterSearchTextChanged(String text) async {
    _staffCharactersSearchList!.clear();
    if (text.isEmpty) {
      setState(() {
        _staffCharactersSearchList = _staffCharactersSearchList;
      });
      return;
    }

    print(_staffCharactersList!.length);

    for (var character in _staffCharactersList!) {
      if (character.name!.toLowerCase().contains(text)){
        _staffCharactersSearchList!.add(character);
      }
    }
    setState(() {
      _staffCharactersSearchList = _staffCharactersSearchList;
    });
  }

  //Show toast
  void showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: AppConstants.oneSecond,
        backgroundColor: AppColors.grey,
        textColor: AppColors.black,
        fontSize: AppConstants.toastSize
    );
  }
}