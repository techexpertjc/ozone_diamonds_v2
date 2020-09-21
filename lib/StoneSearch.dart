import 'dart:convert';
import 'dart:developer';
import "package:http/http.dart" as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:ozone_diamonds/LoginPage.dart';
import 'package:ozone_diamonds/pair_search_result.dart';

import 'package:ozone_diamonds/search.dart';
import 'package:ozone_diamonds/search_with_tabs.dart';

import 'package:ozone_diamonds/shape.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'inputformator.dart';

class StoneSearch extends StatefulWidget {
  final currSavedObj, customFunction, isPair;
  StoneSearch({Key key, this.currSavedObj, this.customFunction, this.isPair})
      : super(key: key);
  @override
  _StoneSearchState createState() => _StoneSearchState();
}

List<String> savedSearch;
List<String> savedSearchSeqNo;
bool isFromSaved = false;

class _StoneSearchState extends State<StoneSearch>
    with AutomaticKeepAliveClientMixin {
  Map currSavedObj;
  final FocusNode _nodeText1 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(focusNode: _nodeText1, toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  color:Color(0XFFB8C6FF),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "DONE",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            }
          ])
        ]);
  }

  final _height = 26.0;
  final _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5), side: BorderSide.none);
  bool size = false;
  bool pressed = false;
  String caratFrom, caratTo, discountFrom, discountTo, dollarFrom, dollarTo;
  String ratioFrom,
      ratioTo,
      lengthFrom,
      lengthTo,
      widthFrom,
      widthTo,
      heightFrom,
      heightTo;
  String pavHigFrom, pavHigTo, pavAngFrom, pavAngTo, crownHigFrom, crownHigTo;
  String crownAngFrom,
      crownAngTo,
      gridleFrom,
      gridleTo,
      tableFrom,
      tableTo,
      starLenFrom,
      starLenTo;
  String filquery = " ";
  final titleFont = 14.0; //font of title
  final titlebold = FontWeight.normal; //title font width
  final buttonFont = 12.0; //font size of button font
  final buttonbold = FontWeight.w400; //font bold of button font
  //clarity Field
  List<List<String>> clarityName = [
    ['FL', 'IF', 'VVS1', 'VVS2'],
    ['VS1', 'VS2', 'SI1', 'SI2'],
    ['SI3', 'I1', 'I2', 'I3']
  ];
  List<String> clarityValue = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<dynamic> clarityColor = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> clarityResult = [];

  //colour field
  List<List<String>> colourName = [
    ['D', 'E', 'F', 'G', 'H', 'I'],
    ['J', 'K', 'l', 'M', 'N-Z', 'Fancy']
  ];
  List<String> colourValue = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11,12,13,14,15,16,17,18,19,20,21,22,23',
    '25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,59,61,62,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,92,93,94'
  ];
  List<bool> colourColor = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> colourResult = [];

  //finishing field
  List<String> finishingName = ['3EX', '3VG+', 'NOBGM'];
  List<String> finishingValue = ['1', '2', '4'];
  List<bool> finishingColor = [false, false, false];
  List<String> finishingResult = [];

  //cut field
  List<String> cutName = ['EX', 'VG', 'GD', 'FR'];
  List<String> cutValue = ['2', '3', '4', '5'];
  List<bool> cutColor = [false, false, false, false];
  List<String> cutResult = [];

  //polish field
  List<String> polishName = ['EX', 'VG', 'GD', 'FR'];
  List<String> polishValue = ['2', '3', '4', '5'];
  List<bool> polishColor = [false, false, false, false];
  List<String> polishResult = [];

  //symm field
  List<String> symmName = ['EX', 'VG', 'GD', 'FR'];
  List<String> symmValue = ['2', '3', '4', '5'];
  List<bool> symmColor = [false, false, false, false];
  List<String> symmResult = [];

  //Fluorescence field
  List<List<String>> fluoreName = [
    ['NON', 'FNT', 'MED', 'STG'],
    ['VST', 'SL', 'VSL']
  ];
  List<String> fluoreValue = ['1', '2', '3', '4', '5', '6', '7'];
  List<bool> fluoreColor = [false, false, false, false, false, false, false];
  List<String> fluoreResult = [];

  //Certificate field
  List<String> certificateName = ['GIA', 'IGI', 'HRD', 'Other'];
  List<String> certificateValue = ['1', '2', '3', '4'];
  List<bool> certificateColor = [false, false, false, false];
  List<String> certificateResult = [];

  //Luster field
  List<List<String>> lusterName = [
    ['EXCELLENT', 'VERY GOOD'],
    ['MILKY 1', 'MILKY 2']
  ];
  List<String> lusterValue = ['1', '2', '4', '5', '6'];
  List<bool> lusterColor = [false, false, false, false, false];
  List<String> lusterResult = [];

  //Shades Field
  List<List<String>> shadesName = [
    ['NONE', 'BROWN', 'GREEN'],
    ['MIX TINGE', 'GREY']
  ];
  List<String> shadesValue = [
    "''NONE''",
    "''BROWN''",
    "''GREEN''",
    "''MIX TINGE''"
        "''GREY''"
  ];
  List<bool> shadesColor = [false, false, false, false, false];
  List<String> shadesResult = [];

  //H&A field
  List<String> haName = ['EX', 'VG'];
  List<String> haValue = [
    "''EX''",
    "''VG''",
  ];
  List<bool> haColor = [false, false];
  List<String> haResult = [];

  //black Inclustion field
  List<String> blackIncnName = ['CBL-0', 'CBL-1', 'CBL-2', 'SBL-0', 'SBL-1'];
  List<String> blackIncnValue = ['1', '2', '3', '4', '5'];
  List<bool> blackIncnColor = [false, false, false, false, false];
  List<String> blackIncnResult = [];

  //white Inclustion field
  List<List<String>> whiteIncnName = [
    ['CW-0', 'CW-1', 'CW-2', 'SW-0'],
    ['SW-1', 'SW-2', 'SW-4']
  ];
  List<String> whiteIncnValue = ['1', '2', '3', '4', '5', '6', '7'];
  List<bool> whiteIncnColor = [false, false, false, false, false, false, false];
  List<String> whiteIncnResult = [];

  //shape value

  bool changeColorAll = false;
  bool changeColorRound = false;
  bool changeColorPrincess = false;
  bool changeColorCushion = false;
  bool changeColorOval = false;
  bool changeColorEmerald = false;
  bool changeColorPear = false;
  bool changeColorAsscher = false;
  bool changeColorHeart = false;
  bool changeColorRadiant = false;
  bool changeColorMarquise = false;
  bool changeColorOther = false;
  var round = shapesState.round;
  var princess = shapesState.princess;
  var marquise = shapesState.marquise;
  var emerald = shapesState.emerald;
  var pear = shapesState.pear;
  var oval = shapesState.oval;
  var cushion = shapesState.cushion;
  var radiant = shapesState.radiant;
  var heart = shapesState.heart;
  var asscher = shapesState.asscher;
  //test
  List<String> field = ['abc', 'def', 'xyz'];

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences pref;
  bool isFromSavedMy = true;
  void _syncShapeSelected(
    bool isAll,
    bool isRound,
    bool isPrincess,
    bool isCushion,
    bool isOval,
    bool isEmerald,
    bool isPear,
    bool isAsscher,
    bool isHeart,
    bool isRdiant,
    bool isMarquise,
    bool isOther,
  ) {
    changeColorAll = isAll;
    changeColorAsscher = isAsscher;
    changeColorCushion = isCushion;
    changeColorEmerald = isEmerald;
    changeColorHeart = isHeart;
    changeColorMarquise = isMarquise;
    changeColorOther = isOther;
    changeColorOval = isOval;
    changeColorPear = isPear;
    changeColorPrincess = isPrincess;
    changeColorRadiant = isRdiant;
    changeColorRound = isRound;

    // widget.customFunction(isFromSaved);
  }

  TextEditingController caratToController,
      caratListController,
      caratFromController,
      discountFromController,
      discountToController,
      ctFromController,
      ctToController,
      ratioFromController,
      ratioToController,
      lengthFromController,
      lengthToController,
      widthFromController,
      widthToController,
      heightFromController,
      heightToController,
      pavHeightFromController,
      pavHeightToController,
      pavAngleFromController,
      pavAngleToController,
      crownHeightFromController,
      crownHeightToController,
      crownAngleFromController,
      crownAngleToController,
      gridleFromController,
      gridleToController,
      tableFromController,
      tableToController,
      starLenFromController,
      starLenToController,
      certiNoController;

  Map shapesMap;

  Widget shapesWidget;

  Widget getWhiteIncOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempShadesRow = List();
    whiteIncnName.forEach((element) {
      tempShadesRow.add(Row(
        children: List.generate(element.length, (index) {
          int currIndex = initIndex;
          initIndex++;
          return Container(
            padding: EdgeInsets.all(1),
            width: (MediaQuery.of(context).size.width - 40) / 4,
            child: RaisedButton(
                elevation: 0.0,
                shape: _shape,
                color: whiteIncnColor[currIndex]
                    ? Color(0XFF294EA3)
                    : Color(0XFFEBEFFA),
                onPressed: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() {
                    whiteIncnColor[currIndex] = !whiteIncnColor[currIndex];
                    if (whiteIncnResult
                        .contains(whiteIncnValue[currIndex].toString())) {
                      whiteIncnResult
                          .remove(whiteIncnValue[currIndex].toString());
                    } else {
                      whiteIncnResult.add(whiteIncnValue[currIndex].toString());
                    }
                  });
                },
                child: Text(
                  element[index].toString(),
                  style: TextStyle(
                      fontSize: buttonFont,
                      color: whiteIncnColor[currIndex]
                          ? Colors.white
                          : Colors.black,
                      fontWeight: buttonbold),
                )),
          );
        }),
      ));
    });
    return Column(
      children: tempShadesRow,
    );
  }

  Widget getShadesOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempShadesRow = List();
    shadesName.forEach((element) {
      tempShadesRow.add(Row(
        children: List.generate(element.length, (index) {
          int currIndex = initIndex;
          initIndex++;
          return Container(
            padding: EdgeInsets.all(1),
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: RaisedButton(
                elevation: 0.0,
                shape: _shape,
                color: shadesColor[currIndex]
                    ? Color(0XFF294EA3)
                    : Color(0XFFEBEFFA),
                onPressed: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() {
                    shadesColor[currIndex] = !shadesColor[currIndex];
                    if (shadesResult
                        .contains(shadesValue[currIndex].toString())) {
                      shadesResult.remove(shadesValue[currIndex].toString());
                    } else {
                      shadesResult.add(shadesValue[currIndex].toString());
                    }
                  });
                },
                child: Text(
                  element[index].toString(),
                  style: TextStyle(
                      fontSize: buttonFont,
                      color:
                          shadesColor[currIndex] ? Colors.white : Colors.black,
                      fontWeight: buttonbold),
                )),
          );
        }),
      ));
    });
    return Column(
      children: tempShadesRow,
    );
  }

  Widget getLusterOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempLusterRow = List();
    lusterName.forEach((element) {
      tempLusterRow.add(Row(
        children: List.generate(element.length, (index) {
          int currIndex = initIndex;
          initIndex++;
          return Container(
            padding: EdgeInsets.all(1),
            width: (MediaQuery.of(context).size.width - 30) / 3,
            child: RaisedButton(
                elevation: 0.0,
                shape: _shape,
                color: lusterColor[currIndex]
                    ? Color(0XFF294EA3)
                    : Color(0XFFEBEFFA),
                onPressed: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() {
                    lusterColor[currIndex] = !lusterColor[currIndex];
                    if (lusterResult
                        .contains(lusterValue[currIndex].toString())) {
                      lusterResult.remove(lusterValue[currIndex].toString());
                    } else {
                      lusterResult.add(lusterValue[currIndex].toString());
                    }
                  });
                },
                child: Text(
                  element[index].toString(),
                  style: TextStyle(
                      fontSize: buttonFont,
                      color:
                          lusterColor[currIndex] ? Colors.white : Colors.black,
                      fontWeight: buttonbold),
                )),
          );
        }),
      ));
    });
    return Column(
      children: tempLusterRow,
    );
  }

  Widget getFluoroOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempFloroRow = List();
    fluoreName.forEach((element) {
      tempFloroRow.add(Row(
          children: List.generate(element.length, (index) {
        int currIndex = initIndex;
        initIndex++;
        return Container(
          padding: EdgeInsets.all(1),
          width: (MediaQuery.of(context).size.width - 40) / 4,
          child: RaisedButton(
              elevation: 0.0,
              shape: _shape,
              color: fluoreColor[currIndex]
                  ? Color(0XFF294EA3)
                  : Color(0XFFEBEFFA),
              onPressed: () {
                if (!FocusScope.of(context).hasPrimaryFocus) {
                  FocusScope.of(context).unfocus();
                }
                setState(() {
                  fluoreColor[currIndex] = !fluoreColor[currIndex];
                  if (fluoreResult
                      .contains(fluoreValue[currIndex].toString())) {
                    fluoreResult.remove(fluoreValue[currIndex].toString());
                  } else {
                    fluoreResult.add(fluoreValue[currIndex].toString());
                  }
                });
                // print(buttonVlaue[index].toString());
              },
              child: Text(
                element[index].toString(),
                style: TextStyle(
                    fontSize: buttonFont,
                    color: fluoreColor[currIndex] ? Colors.white : Colors.black,
                    fontWeight: buttonbold),
              )),
        );
      })));
    });
    return Column(
      children: tempFloroRow,
    );
  }

  Widget getColourOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempColourRow = List();
    colourName.forEach((element) {
      tempColourRow.add(Row(
        children: List.generate(element.length, (index) {
          int currIndex = initIndex;
          initIndex++;
          return Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(1),
              // width: (MediaQuery.of(context).size.width - 50) / 6,
              child: RaisedButton(
                  elevation: 0.0,
                  shape: _shape,
                  color: colourColor[currIndex]
                      ? Color(0XFF294EA3)
                      : Color(0XFFEBEFFA),
                  onPressed: () {
                    if (!FocusScope.of(context).hasPrimaryFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    setState(() {
                      colourColor[currIndex] = !colourColor[currIndex];
                      if (colourResult
                          .contains(colourValue[currIndex].toString())) {
                        colourResult.remove(colourValue[currIndex].toString());
                      } else {
                        colourResult.add(colourValue[currIndex].toString());
                      }
                    });
                    // print(buttonVlaue[index].toString());
                  },
                  child: Text(
                    element[index].toString(),
                    style: TextStyle(
                        fontSize: element[index].length > 3
                            ? buttonFont - 2
                            : buttonFont,
                        color: colourColor[currIndex]
                            ? Colors.white
                            : Colors.black,
                        fontWeight: buttonbold),
                  )),
            ),
          );
        }),
      ));
    });
    return Column(
      children: tempColourRow,
    );
  }

  Widget getClarityOptionsWidget(BuildContext context) {
    int initIndex = 0;
    List<Widget> tempClarityRow = List();
    clarityName.forEach((element) {
      tempClarityRow.add(Row(
        children: List.generate(element.length, (index) {
          int currIndex = initIndex;
          initIndex++;

          return Container(
            padding: EdgeInsets.all(1),
            width: (MediaQuery.of(context).size.width - 20) / 4,
            child: RaisedButton(
                elevation: 0.0,
                shape: _shape,
                color: clarityColor[currIndex]
                    ? Color(0XFF294EA3)
                    : Color(0XFFEBEFFA),
                onPressed: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                  setState(() {
                    clarityColor[currIndex] = !clarityColor[currIndex];
                    if (clarityResult
                        .contains(clarityValue[currIndex].toString())) {
                      clarityResult.remove(clarityValue[currIndex].toString());
                    } else {
                      clarityResult.add(clarityValue[currIndex].toString());
                    }
                  });
                  // print(buttonVlaue[index].toString());
                },
                child: Text(
                  element[index].toString(),
                  style: TextStyle(
                      fontSize: buttonFont,
                      fontWeight: buttonbold,
                      color: clarityColor[currIndex]
                          ? Colors.white
                          : Colors.black),
                )),
          );
        }),
      ));
    });
    return Column(
      children: tempClarityRow,
    );
  }

  void initiateFormValues() {
    currSavedObj = widget.currSavedObj;
    if (currSavedObj != null && isFromSaved) {
      shapesMap = currSavedObj['shapes'];
      clarityColor = currSavedObj['clarityColor'].cast<bool>();
      clarityResult = currSavedObj['clarityResult'].cast<String>();
      caratToController.text =
          currSavedObj['caratTo'] == '' ? null : currSavedObj['caratTo'];
      caratFromController.text =
          currSavedObj['caratFrom'] == '' ? null : currSavedObj['caratFrom'];
      colourColor = currSavedObj['colourColor'].cast<bool>();
      colourResult = currSavedObj['colourResult'].cast<String>();
      cutColor = currSavedObj['cutColor'].cast<bool>();
      cutResult = currSavedObj['cutResult'].cast<String>();
      polishColor = currSavedObj['polishColor'].cast<bool>();
      polishResult = currSavedObj['polishResult'].cast<String>();
      symmColor = currSavedObj['symmColor'].cast<bool>();
      symmResult = currSavedObj['symmResult'].cast<String>();
      fluoreColor = currSavedObj['fluoreColor'].cast<bool>();
      fluoreResult = currSavedObj['fluoreResult'].cast<String>();
      certificateColor = currSavedObj['certificateColor'].cast<bool>();
      certificateResult = currSavedObj['certificateResult'].cast<String>();
      lusterColor = currSavedObj['lusterColor'].cast<bool>();
      lusterResult = currSavedObj['lusterResult'].cast<String>();
      shadesColor = currSavedObj['shadesColor'].cast<bool>();
      shadesResult = currSavedObj['shadesResult'].cast<String>();
      haColor = currSavedObj['haColor'].cast<bool>();
      haResult = currSavedObj['haResult'].cast<String>();
      blackIncnColor = currSavedObj['blackIncnColor'].cast<bool>();
      blackIncnResult = currSavedObj['blackIncnResult'].cast<String>();
      whiteIncnColor = currSavedObj['whiteIncnColor'].cast<bool>();
      whiteIncnResult = currSavedObj['whiteIncnResult'].cast<String>();

      discountFromController.text = currSavedObj['discountFrom'] == ''
          ? null
          : currSavedObj['discountFrom'];

      discountToController.text =
          currSavedObj['discountTo'] == '' ? null : currSavedObj['discountTo'];
      ctFromController.text =
          currSavedObj['dollarFrom'] == '' ? null : currSavedObj['dollarFrom'];
      ctToController.text =
          currSavedObj['dollarTo'] == '' ? null : currSavedObj['dollarTo'];
      ratioFromController.text =
          currSavedObj['ratioFrom'] == '' ? null : currSavedObj['ratioFrom'];
      ratioToController.text =
          currSavedObj['ratioTo'] == '' ? null : currSavedObj['ratioTo'];
      lengthFromController.text =
          currSavedObj['lengthFrom'] == '' ? null : currSavedObj['lengthFrom'];
      lengthToController.text =
          currSavedObj['lengthTo'] == '' ? null : currSavedObj['lengthTo'];
      widthFromController.text =
          currSavedObj['widthFrom'] == '' ? null : currSavedObj['widthFrom'];
      widthToController.text =
          currSavedObj['widthTo'] == '' ? null : currSavedObj['widthTo'];
      heightFromController.text =
          currSavedObj['heightFrom'] == '' ? null : currSavedObj['heightFrom'];
      heightToController.text =
          currSavedObj['heightTo'] == '' ? null : currSavedObj['heightTo'];
      pavHeightFromController.text = currSavedObj['pavHeightFrom'] == ''
          ? null
          : currSavedObj['pavHeightFrom'];
      pavHeightToController.text = currSavedObj['pavHeightTo'] == ''
          ? null
          : currSavedObj['pavHeightTo'];
      pavAngleFromController.text = currSavedObj['pavAngleFrom'] == ''
          ? null
          : currSavedObj['pavAngleFrom'];
      pavAngleToController.text =
          currSavedObj['pavAngleTo'] == '' ? null : currSavedObj['pavAngleTo'];
      crownHeightFromController.text = currSavedObj['crownHeightFrom'] == ''
          ? null
          : currSavedObj['crownHeightFrom'];
      crownHeightToController.text = currSavedObj['crownHeightTo'] == ''
          ? null
          : currSavedObj['crownHeightTo'];
      crownAngleFromController.text = currSavedObj['crownAngleFrom'] == ''
          ? null
          : currSavedObj['crownAngleFrom'];
      crownAngleToController.text = currSavedObj['crownAngleTo'] == ''
          ? null
          : currSavedObj['crownAngleTo'];
      gridleFromController.text =
          currSavedObj['gridleFrom'] == '' ? null : currSavedObj['gridleFrom'];
      gridleToController.text =
          currSavedObj['gridleTo'] == '' ? null : currSavedObj['gridleTo'];
      tableFromController.text =
          currSavedObj['tableFrom'] == '' ? null : currSavedObj['tableFrom'];
      tableToController.text =
          currSavedObj['tableTo'] == '' ? null : currSavedObj['tableTo'];
      starLenFromController.text = currSavedObj['starLenFrom'] == ''
          ? null
          : currSavedObj['starLenFrom'];
      starLenToController.text =
          currSavedObj['starLenTo'] == '' ? null : currSavedObj['starLenTo'];
      certiNoController.text =
          currSavedObj['certiNo'] == '' ? null : currSavedObj['certiNo'];

      caratFrom =
          caratFromController.text == '' ? null : caratFromController.text;
      caratTo = caratToController.text == '' ? null : caratToController.text;
      discountFrom = discountFromController.text == ''
          ? null
          : discountFromController.text;
      discountTo =
          discountToController.text == '' ? null : discountToController.text;
      dollarFrom = ctFromController.text == '' ? null : ctFromController.text;
      dollarTo = ctToController.text == '' ? null : ctToController.text;
      ratioFrom =
          ratioFromController.text == '' ? null : ratioFromController.text;
      ratioTo = ratioToController.text == '' ? null : ratioToController.text;
      lengthFrom =
          lengthFromController.text == '' ? null : lengthFromController.text;
      lengthTo = lengthToController.text == '' ? null : lengthToController.text;
      widthFrom =
          widthFromController.text == '' ? null : widthFromController.text;
      widthTo = widthToController.text == '' ? null : widthToController.text;
      heightFrom =
          heightFromController.text == '' ? null : heightFromController.text;
      heightTo = heightToController.text == '' ? null : heightToController.text;
      pavHigFrom = pavHeightFromController.text == ''
          ? null
          : pavHeightFromController.text;
      pavHigTo =
          pavHeightToController.text == '' ? null : pavHeightToController.text;
      pavAngFrom = pavAngleFromController.text == ''
          ? null
          : pavAngleFromController.text;
      pavAngTo =
          pavAngleToController.text == '' ? null : pavAngleToController.text;
      crownHigFrom = crownHeightFromController.text == ''
          ? null
          : crownHeightFromController.text;
      crownHigTo = crownHeightToController.text == ''
          ? null
          : crownHeightToController.text;
      crownAngFrom = crownAngleFromController.text == ''
          ? null
          : crownAngleFromController.text;
      crownAngTo = crownAngleToController.text == ''
          ? null
          : crownAngleToController.text;
      gridleFrom =
          gridleFromController.text == '' ? null : gridleFromController.text;
      gridleTo = gridleToController.text == '' ? null : gridleToController.text;
      tableFrom =
          tableFromController.text == '' ? null : tableFromController.text;
      tableTo = tableToController.text == '' ? null : tableToController.text;
      starLenFrom =
          starLenFromController.text == '' ? null : starLenFromController.text;
      starLenTo =
          starLenToController.text == '' ? null : starLenToController.text;
    } else {}
    shapesWidget = shapes(
      customFunction: _syncShapeSelected,
      shapeMap: shapesMap,
      loadfromSaved: isFromSaved,
    );
  }

  @override
  void setState(fn) {
    // TODO: implement setState

    currSavedObj = widget.currSavedObj;
    initiateFormValues();

    super.setState(fn);
  }

  Set<String> caratList = Set();

  @override
  void initState() {
    // TODO: implement initState

    initiateFormValues();
    super.initState();

    caratListController = TextEditingController();
    caratToController = TextEditingController();
    caratFromController = TextEditingController();
    discountFromController = TextEditingController();
    discountToController = TextEditingController();
    ctFromController = TextEditingController();
    ctToController = TextEditingController();
    ratioFromController = TextEditingController();
    ratioToController = TextEditingController();
    lengthFromController = TextEditingController();
    lengthToController = TextEditingController();
    widthFromController = TextEditingController();
    widthToController = TextEditingController();
    heightFromController = TextEditingController();
    heightToController = TextEditingController();
    pavHeightFromController = TextEditingController();
    pavHeightToController = TextEditingController();
    pavAngleFromController = TextEditingController();
    pavAngleToController = TextEditingController();
    crownHeightFromController = TextEditingController();
    crownHeightToController = TextEditingController();
    crownAngleFromController = TextEditingController();
    crownAngleToController = TextEditingController();
    gridleFromController = TextEditingController();
    gridleToController = TextEditingController();
    tableFromController = TextEditingController();
    tableToController = TextEditingController();
    starLenFromController = TextEditingController();
    starLenToController = TextEditingController();
    certiNoController = TextEditingController();

    // if (widget.savedparam == null) {
    //   formKey.currentState.reset();
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('inside build' + widget.currSavedObj.toString());
    setState(() {});
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0XFFEBEFFA),
      body: GestureDetector(
        onTap: () {
          print(FocusScope.of(context).hasFocus);
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: KeyboardActions(
          config: _buildConfig(context),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //SearchField
                  Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Container(
                        height: (size) ? 30 : 35,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextFormField(
                            controller: certiNoController,
                            autofocus: false,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Stone ID / Cert No.',
                                hintStyle: TextStyle(
                                    fontSize: (size) ? 14 : 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      )),

                  //shape container
                  Padding(
                      padding:
                          EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                      child: Container(
                          color: Colors.white,
                          child: shapes(
                            customFunction: _syncShapeSelected,
                            shapeMap: shapesMap,
                            loadfromSaved: isFromSaved,
                          ))),

                  //Carat Field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, left: 20.0, bottom: 2.0),
                              child: Text(
                                'Carat',
                                style: TextStyle(
                                  fontSize: titleFont,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 30),
                              child: Container(
                                height: 30,
                                width: 100,
                                child: TextFormField(
                                  focusNode: _nodeText1,
                                  controller: caratFromController,
                                  inputFormatters: [
                                    DecimalTextInputFormatter()
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0XFFEBEFFA),
                                      border: InputBorder.none,
                                      hintText: 'From',
                                      hintStyle: TextStyle(
                                          fontSize: (size) ? 14 : 14)),
                                  onChanged: (value) {
                                    caratFrom = value.toString();
                                  },
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 30),
                              child: Container(
                                height: 30,
                                width: 100,
                                child: TextFormField(
                                   focusNode: _nodeText1,,
                                  controller: caratToController,
                                  // initialValue: caratTo != null ? caratTo : null,
                                  inputFormatters: [
                                    DecimalTextInputFormatter()
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0XFFEBEFFA),
                                      border: InputBorder.none,
                                      hintText: 'To',
                                      hintStyle: TextStyle(
                                          fontSize: (size) ? 14 : 14)),
                                  onChanged: (value) {
                                    caratTo = value.toString();
                                  },
                                ),
                              ),
                            ),
                            Container(
                                child: FloatingActionButton(
                              heroTag: 'addBtn',
                              backgroundColor: Color(0XFFEBEFFA),
                              mini: true,
                              onPressed: () {
                                if (!FocusScope.of(context).hasPrimaryFocus) {
                                  FocusScope.of(context).unfocus();
                                }
                                setState(() {
                                  if (caratFromController.text != null &&
                                      caratFromController.text != '' &&
                                      caratToController.text != null &&
                                      caratToController.text != '')
                                    caratList.add(caratFromController.text +
                                        '-' +
                                        caratToController.text);
                                  caratListController.text =
                                      caratList.join(',');
                                  caratFromController.text = '';
                                  caratToController.text = '';
                                });
                                if (!FocusScope.of(context).hasPrimaryFocus) {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ))

                            // Padding(
                            //     padding: EdgeInsets.all(0),
                            //     child: Container(
                            //       // padding: EdgeInsets.all(5),
                            //       // color: Colors.blueAccent,
                            //       child: MaterialButton(
                            //         color: Color(0XFFEBEFFA),
                            //         shape: CircleBorder(),
                            //         onPressed: () {  if (!FocusScope.of(context).hasPrimaryFocus) {FocusScope.of(context).unfocus();}},
                            //         child: Icon(Icons.add),
                            //         // label: Text('')),
                            //       ),
                            //     ))
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0, left: 30),
                                child: Container(
                                  height: 30,
                                  // width: MediaQuery.of(context).size.width - 100,
                                  color: Colors.black,
                                  child: TextFormField(
                                    controller: caratListController,
                                    inputFormatters: [
                                      DecimalTextInputFormatter()
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0XFFEBEFFA),
                                        border: InputBorder.none,
                                        // hintText: 'From',
                                        hintStyle: TextStyle(
                                            fontSize: (size) ? 14 : 14)),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: FloatingActionButton(
                                    heroTag: 'clearBtn',
                                    backgroundColor: Color(0XFFEBEFFA),
                                    onPressed: () {
                                      if (!FocusScope.of(context)
                                          .hasPrimaryFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      setState(() {
                                        caratListController.text = '';
                                        caratList.clear();
                                      });
                                    },
                                    mini: true,
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                    )))
                            // Padding(
                            //     padding: EdgeInsets.all(0),
                            //     child: Container(
                            //       // padding: EdgeInsets.all(5),
                            //       // color: Colors.blueAccent,
                            //       child: MaterialButton(
                            //         color: Color(0XFFEBEFFA),
                            //         shape: CircleBorder(),
                            //         onPressed: () {  if (!FocusScope.of(context).hasPrimaryFocus) {FocusScope.of(context).unfocus();}},
                            //         child: Icon(Icons.add),
                            //         // label: Text('')),
                            //       ),
                            //     ))
                          ],
                        )),
                  ),

                  //clarity field
                  Padding(
                      padding:
                          EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5),
                                child: Center(
                                  child: Text(
                                    'Clarity',
                                    style: TextStyle(
                                        fontSize: titleFont,
                                        fontWeight: titlebold),
                                  ),
                                ),
                              ),
                              getClarityOptionsWidget(context),
                            ],
                          ))),

                  //colour field
                  Padding(
                      padding:
                          EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                      child: Container(
                        color: Colors.white,
                        child: Container(
                            padding: EdgeInsets.only(top: 05, bottom: 05),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Color',
                                  style: TextStyle(
                                      fontSize: titleFont,
                                      fontWeight: titlebold),
                                ),
                                getColourOptionsWidget(context)
                              ],
                            )),
                      )),

                  //finishing field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(top: 05, bottom: 05),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Finishing',
                                style: TextStyle(
                                    fontSize: titleFont, fontWeight: titlebold),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        finishingName.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5.0, bottom: 3.0, top: 3.0),
                                        child: SizedBox(
                                          height: _height,
                                          width: (size) ? 62 : 90,
                                          child: RaisedButton(
                                              elevation: 0.0,
                                              shape: _shape,
                                              color: finishingColor[index]
                                                  ? Color(0XFF294EA3)
                                                  : Color(0XFFEBEFFA),
                                              onPressed: () {
                                                if (!FocusScope.of(context)
                                                    .hasPrimaryFocus) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                }
                                                setState(() {
                                                  finishingColor[index] =
                                                      !finishingColor[index];
                                                  if (finishingResult.contains(
                                                      finishingValue[index]
                                                          .toString())) {
                                                    finishingResult.remove(
                                                        finishingValue[index]
                                                            .toString());
                                                  } else {
                                                    finishingResult.add(
                                                        finishingValue[index]
                                                            .toString());
                                                  }

                                                  if (finishingName[index] ==
                                                      '3EX') {
                                                    cutColor[0] =
                                                        finishingColor[index];
                                                    polishColor[0] =
                                                        finishingColor[index];
                                                    symmColor[0] =
                                                        finishingColor[index];
                                                  } else if (finishingName[
                                                          index] ==
                                                      '3VG+') {
                                                    cutColor[0] =
                                                        finishingColor[index];
                                                    polishColor[0] =
                                                        finishingColor[index];
                                                    symmColor[0] =
                                                        finishingColor[index];
                                                    cutColor[1] =
                                                        finishingColor[index];
                                                    polishColor[1] =
                                                        finishingColor[index];
                                                    symmColor[1] =
                                                        finishingColor[index];
                                                  } else if (finishingName[
                                                          index] ==
                                                      '2EX') {
                                                    cutColor[0] =
                                                        finishingColor[index];
                                                    polishColor[0] =
                                                        finishingColor[index];
                                                  } else if (finishingName[
                                                          index] ==
                                                      'NOBGM') {
                                                    lusterColor[0] =
                                                        finishingColor[index];
                                                    lusterColor[1] =
                                                        finishingColor[index];
                                                    shadesColor[0] =
                                                        finishingColor[index];
                                                  }
                                                });
                                                // print(buttonVlaue[index].toString());
                                              },
                                              child: Text(
                                                finishingName[index].toString(),
                                                style: TextStyle(
                                                    fontSize: buttonFont,
                                                    color: finishingColor[index]
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: buttonbold),
                                              )),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: SizedBox(
                                        height: _height,
                                        width: 50,
                                        child: Text(
                                          'Cut',
                                          style: TextStyle(
                                              fontSize: titleFont,
                                              fontWeight: titlebold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height,
                                      //width: _swidth,
                                      child: Row(
                                        children: List.generate(cutName.length,
                                            (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 3.0),
                                            child: SizedBox(
                                              height: _height,
                                              width: (size) ? 60 : 55,
                                              child: RaisedButton(
                                                  elevation: 0.0,
                                                  shape: _shape,
                                                  color: cutColor[index]
                                                      ? Color(0XFF294EA3)
                                                      : Color(0XFFEBEFFA),
                                                  onPressed: () {
                                                    if (!FocusScope.of(context)
                                                        .hasPrimaryFocus) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                    setState(() {
                                                      cutColor[index] =
                                                          !cutColor[index];
                                                      if (cutResult.contains(
                                                          cutValue[index]
                                                              .toString())) {
                                                        cutResult.remove(
                                                            cutValue[index]
                                                                .toString());
                                                      } else {
                                                        cutResult.add(
                                                            cutValue[index]
                                                                .toString());
                                                      }
                                                    });
                                                    // print(buttonVlaue[index].toString());
                                                  },
                                                  child: Text(
                                                    cutName[index].toString(),
                                                    style: TextStyle(
                                                        fontSize: buttonFont,
                                                        color: cutColor[index]
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight: buttonbold),
                                                  )),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: SizedBox(
                                        height: _height,
                                        width: 50,
                                        child: Text(
                                          'Polish',
                                          style: TextStyle(
                                              fontSize: titleFont,
                                              fontWeight: titlebold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height,
                                      //width: _swidth,
                                      child: Row(
                                        children: List.generate(
                                            polishName.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 3.0),
                                            child: SizedBox(
                                              height: _height,
                                              width: (size) ? 60 : 55,
                                              child: RaisedButton(
                                                  elevation: 0.0,
                                                  shape: _shape,
                                                  color: polishColor[index]
                                                      ? Color(0XFF294EA3)
                                                      : Color(0XFFEBEFFA),
                                                  onPressed: () {
                                                    if (!FocusScope.of(context)
                                                        .hasPrimaryFocus) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                    setState(() {
                                                      polishColor[index] =
                                                          !polishColor[index];
                                                      if (polishResult.contains(
                                                          polishValue[index]
                                                              .toString())) {
                                                        polishResult.remove(
                                                            polishValue[index]
                                                                .toString());
                                                      } else {
                                                        polishResult.add(
                                                            polishValue[index]
                                                                .toString());
                                                      }
                                                    });
                                                    // print(buttonVlaue[index].toString());
                                                  },
                                                  child: Text(
                                                    polishName[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: buttonFont,
                                                        color:
                                                            polishColor[index]
                                                                ? Colors.white
                                                                : Colors.black,
                                                        fontWeight: buttonbold),
                                                  )),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: SizedBox(
                                        height: _height,
                                        width: 50,
                                        child: Text(
                                          'Symm',
                                          style: TextStyle(
                                              fontSize: titleFont,
                                              fontWeight: titlebold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: _height,
                                      //width: _swidth,
                                      child: Row(
                                        children: List.generate(symmName.length,
                                            (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 3.0),
                                            child: SizedBox(
                                              height: _height,
                                              width: (size) ? 60 : 55,
                                              child: RaisedButton(
                                                  elevation: 0.0,
                                                  shape: _shape,
                                                  color: symmColor[index]
                                                      ? Color(0XFF294EA3)
                                                      : Color(0XFFEBEFFA),
                                                  onPressed: () {
                                                    if (!FocusScope.of(context)
                                                        .hasPrimaryFocus) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                    setState(() {
                                                      symmColor[index] =
                                                          !symmColor[index];
                                                      if (symmResult.contains(
                                                          symmValue[index]
                                                              .toString())) {
                                                        symmResult.remove(
                                                            symmValue[index]
                                                                .toString());
                                                      } else {
                                                        symmResult.add(
                                                            symmValue[index]
                                                                .toString());
                                                      }
                                                    });
                                                    // print(buttonVlaue[index].toString());
                                                  },
                                                  child: Text(
                                                    symmName[index].toString(),
                                                    style: TextStyle(
                                                        fontSize: buttonFont,
                                                        color: symmColor[index]
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontWeight: buttonbold),
                                                  )),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),

                  //Fluorescence field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(top: 05, bottom: 05),
                          child: Column(
                            children: <Widget>[
                              Text(
                                // 'Fluorescence',
                                'Fluorescence',
                                style: TextStyle(
                                    fontSize: titleFont, fontWeight: titlebold),
                              ),
                              getFluoroOptionsWidget(context)
                            ],
                          ),
                        )),
                  ),

                  // Certificate field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 05, bottom: 05),
                              child: Text(
                                'Certificate',
                                style: TextStyle(
                                    fontSize: titleFont, fontWeight: titlebold),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(certificateName.length,
                                    (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, bottom: 3.0, top: 3.0),
                                    child: SizedBox(
                                      height: _height,
                                      width: (size) ? 60 : 65,
                                      child: RaisedButton(
                                          elevation: 0.0,
                                          shape: _shape,
                                          color: certificateColor[index]
                                              ? Color(0XFF294EA3)
                                              : Color(0XFFEBEFFA),
                                          onPressed: () {
                                            if (!FocusScope.of(context)
                                                .hasPrimaryFocus) {
                                              FocusScope.of(context).unfocus();
                                            }
                                            setState(() {
                                              certificateColor[index] =
                                                  !certificateColor[index];
                                              if (certificateResult.contains(
                                                  certificateValue[index]
                                                      .toString())) {
                                                certificateResult.remove(
                                                    certificateValue[index]
                                                        .toString());
                                              } else {
                                                certificateResult.add(
                                                    certificateValue[index]
                                                        .toString());
                                              }
                                            });
                                          },
                                          child: Text(
                                            certificateName[index].toString(),
                                            style: TextStyle(
                                                fontSize: buttonFont,
                                                color: certificateColor[index]
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: buttonbold),
                                          )),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        )),
                  ),

                  //Luster field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(top: 05, bottom: 05),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Luster',
                                style: TextStyle(
                                    fontSize: titleFont, fontWeight: titlebold),
                              ),
                              getLusterOptionsWidget(context)
                            ],
                          ),
                        )),
                  ),

                  //Shades field
                  Padding(
                    padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0),
                    child: Container(
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.only(top: 05, bottom: 05),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Shades',
                                style: TextStyle(
                                    fontSize: titleFont, fontWeight: titlebold),
                              ),
                              getShadesOptionsWidget(context)
                            ],
                          ),
                        )),
                  ),

                  Column(
                    children: <Widget>[
                      pressed
                          ? Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Container(
                                            // height: 55.0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9444,
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Text(
                                                      'H&A',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: titleFont,
                                                          fontWeight:
                                                              titlebold),
                                                    ),
                                                  ),
                                                  Center(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: List.generate(
                                                            haName.length,
                                                            (index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 8.0,
                                                                    bottom: 3.0,
                                                                    top: 3.0),
                                                            child: SizedBox(
                                                              height: _height,
                                                              width: (size)
                                                                  ? 60
                                                                  : 65,
                                                              child:
                                                                  RaisedButton(
                                                                      elevation:
                                                                          0.0,
                                                                      shape:
                                                                          _shape,
                                                                      color: haColor[
                                                                              index]
                                                                          ? Color(
                                                                              0XFF294EA3)
                                                                          : Color(
                                                                              0XFFEBEFFA),
                                                                      onPressed:
                                                                          () {
                                                                        if (!FocusScope.of(context)
                                                                            .hasPrimaryFocus) {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          haColor[index] =
                                                                              !haColor[index];
                                                                          if (haResult
                                                                              .contains(haValue[index].toString())) {
                                                                            haResult.remove(haValue[index].toString());
                                                                          } else {
                                                                            haResult.add(haValue[index].toString());
                                                                          }
                                                                        });
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        haName[index]
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                buttonFont,
                                                                            color: haColor[index]
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontWeight: buttonbold),
                                                                      )),
                                                            ),
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    // height: 55.0,
                                    width: MediaQuery.of(context).size.width *
                                        0.9444,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Black Inclusion',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: titleFont,
                                                fontWeight: titlebold),
                                          ),
                                        ),
                                        Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: List.generate(
                                                  blackIncnName.length,
                                                  (index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 3.0,
                                                          top: 3.0),
                                                  child: SizedBox(
                                                    height: _height,
                                                    width: (size) ? 60 : 70,
                                                    child: RaisedButton(
                                                        elevation: 0.0,
                                                        shape: _shape,
                                                        color: blackIncnColor[
                                                                index]
                                                            ? Color(0XFF294EA3)
                                                            : Color(0XFFEBEFFA),
                                                        onPressed: () {
                                                          if (!FocusScope.of(
                                                                  context)
                                                              .hasPrimaryFocus) {
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus();
                                                          }
                                                          setState(() {
                                                            blackIncnColor[
                                                                    index] =
                                                                !blackIncnColor[
                                                                    index];
                                                            if (blackIncnResult.contains(
                                                                blackIncnValue[
                                                                        index]
                                                                    .toString())) {
                                                              blackIncnResult.remove(
                                                                  blackIncnValue[
                                                                          index]
                                                                      .toString());
                                                            } else {
                                                              blackIncnResult.add(
                                                                  blackIncnValue[
                                                                          index]
                                                                      .toString());
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          blackIncnName[index]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  buttonFont,
                                                              color:
                                                                  blackIncnColor[
                                                                          index]
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                              fontWeight:
                                                                  buttonbold),
                                                        )),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    // height: 55.0,
                                    width: MediaQuery.of(context).size.width *
                                        0.9444,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'White Inclusion',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: titleFont,
                                                fontWeight: titlebold),
                                          ),
                                        ),
                                        getWhiteIncOptionsWidget(context)
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Discount in %',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    discountFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  discountFrom =
                                                      value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller:
                                                    discountToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  discountTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Dollar/ct ',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: ctFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  dollarFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: ctToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  dollarTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Ratio',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller: ratioFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  ratioFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: ratioToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  ratioTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Length',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    lengthFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  lengthFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: lengthToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  lengthTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Width',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller: widthFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  widthFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: widthToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  widthTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Height',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    heightFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  heightFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: heightToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  heightTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Pavilion Height',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    pavHeightFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  pavHigFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller:
                                                    pavHeightToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  pavHigTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Pavilion Angle',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    pavAngleFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  pavAngFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller:
                                                    pavAngleToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  pavAngTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Crown Height',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    crownHeightFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  crownHigFrom =
                                                      value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller:
                                                    crownHeightToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  crownHigTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Crown Angle',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    crownAngleFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  crownAngFrom =
                                                      value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller:
                                                    crownAngleToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  crownAngTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Gridle %',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    gridleFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  gridleFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: gridleToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  gridleTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Table %',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller: tableFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  tableFrom = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: tableToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  tableTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              'Star Length',
                                              style: TextStyle(
                                                  fontSize: titleFont,
                                                  fontWeight: titlebold),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 30.0),
                                            child: Container(
                                              height: 40,
                                              // width: 50,
                                              child: TextFormField(
                                                controller:
                                                    starLenFromController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'From',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  starLenFrom =
                                                      value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 20,
                                                right: 10.0),
                                            child: Container(
                                              height: 40,
                                              // width: 100,
                                              child: TextFormField(
                                                controller: starLenToController,
                                                inputFormatters: [
                                                  DecimalTextInputFormatter()
                                                ],
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0XFFEBEFFA),
                                                    border: InputBorder.none,
                                                    hintText: 'To',
                                                    hintStyle: TextStyle(
                                                        fontSize:
                                                            (size) ? 14 : 14)),
                                                onChanged: (value) {
                                                  starLenTo = value.toString();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          width: 310,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide.none),
                            color: Color(0XFF294EA3),
                            child: pressed
                                ? Text(
                                    "Hide Advance Search",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text('Show Advance Search',
                                    style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (!FocusScope.of(context).hasPrimaryFocus) {
                                FocusScope.of(context).unfocus();
                              }
                              setState(() {
                                pressed = !pressed;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                  onPressed: () {
                    if (!FocusScope.of(context).hasPrimaryFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    _check(
                        round,
                        princess,
                        oval,
                        cushion,
                        marquise,
                        pear,
                        heart,
                        radiant,
                        emerald,
                        asscher,
                        clarityResult,
                        colourResult,
                        cutResult,
                        polishResult,
                        symmResult,
                        fluoreResult,
                        certificateResult,
                        lusterResult,
                        shadesResult,
                        haResult,
                        blackIncnResult,
                        whiteIncnColor,
                        discountFrom,
                        discountTo,
                        dollarFrom,
                        dollarTo,
                        ratioFrom,
                        ratioTo,
                        caratFrom,
                        caratTo,
                        lengthFrom,
                        lengthTo,
                        widthFrom,
                        widthTo,
                        heightFrom,
                        heightTo,
                        pavHigFrom,
                        pavHigTo,
                        pavAngFrom,
                        pavAngTo,
                        crownHigFrom,
                        crownHigTo,
                        crownAngFrom,
                        crownAngTo,
                        gridleFrom,
                        gridleTo,
                        tableFrom,
                        tableTo,
                        starLenFrom,
                        starLenTo);
                    // Navigator.pop(context, true);
                    if (widget.isPair != null && widget.isPair == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PairSearchlist(fil: filquery)));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  searchlist(fil: filquery)));
                    }
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                    color: Color(0XFF294EA3),
                  ),
                  label: Text(
                    "SEARCH",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      var name;
                      final dialogKey = GlobalKey<ScaffoldState>();
                      showDialog(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Center(
                              child: SizedBox(
                                height: 150,
                                child: Scaffold(
                                  resizeToAvoidBottomPadding: false,
                                  key: dialogKey,
                                  body: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      color: Colors.transparent,
                                      // height: 400,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          TextFormField(
                                            onChanged: (val) => name = val,
                                            decoration: InputDecoration(
                                                hintText: 'Name'),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    if (!FocusScope.of(context)
                                                        .hasPrimaryFocus) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                    setState(() {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Text('Cancel')),
                                              FlatButton(
                                                  onPressed: () {
                                                    if (!FocusScope.of(context)
                                                        .hasPrimaryFocus) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    }
                                                    if (name != '' &&
                                                        name != null) {
                                                      Map shapeMap = Map();
                                                      shapeMap['all'] =
                                                          changeColorAll;
                                                      shapeMap['round'] =
                                                          changeColorRound;
                                                      shapeMap['princess'] =
                                                          changeColorPrincess;
                                                      shapeMap['cushion'] =
                                                          changeColorCushion;
                                                      shapeMap['oval'] =
                                                          changeColorOval;
                                                      shapeMap['emerald'] =
                                                          changeColorEmerald;
                                                      shapeMap['pear'] =
                                                          changeColorPear;
                                                      shapeMap['asscher'] =
                                                          changeColorAsscher;
                                                      shapeMap['heart'] =
                                                          changeColorHeart;
                                                      shapeMap['radiant'] =
                                                          changeColorRadiant;
                                                      shapeMap['marquise'] =
                                                          changeColorMarquise;
                                                      shapeMap['other'] =
                                                          changeColorOther;

                                                      Map currValues = Map();
                                                      currValues[name] = Map();

                                                      currValues[name]
                                                          ['shapes'] = shapeMap;
                                                      currValues[name]
                                                              ['clarityColor'] =
                                                          clarityColor;
                                                      currValues[name][
                                                              'clarityResult'] =
                                                          clarityResult;
                                                      currValues[name]
                                                              ['colourColor'] =
                                                          colourColor;
                                                      currValues[name]
                                                              ['colourResult'] =
                                                          colourResult;
                                                      currValues[name]
                                                              ['cutColor'] =
                                                          cutColor;
                                                      currValues[name]
                                                              ['cutResult'] =
                                                          cutResult;
                                                      currValues[name]
                                                              ['polishColor'] =
                                                          polishColor;
                                                      currValues[name]
                                                              ['polishResult'] =
                                                          polishResult;
                                                      currValues[name]
                                                              ['symmColor'] =
                                                          symmColor;
                                                      currValues[name]
                                                              ['symmResult'] =
                                                          symmResult;
                                                      currValues[name]
                                                              ['fluoreColor'] =
                                                          fluoreColor;
                                                      currValues[name]
                                                              ['fluoreResult'] =
                                                          fluoreResult;
                                                      currValues[name][
                                                              'certificateColor'] =
                                                          certificateColor;
                                                      currValues[name][
                                                              'certificateResult'] =
                                                          certificateResult;
                                                      currValues[name]
                                                              ['lusterColor'] =
                                                          lusterColor;
                                                      currValues[name]
                                                              ['lusterResult'] =
                                                          lusterResult;
                                                      currValues[name]
                                                              ['shadesColor'] =
                                                          shadesColor;
                                                      currValues[name]
                                                              ['shadesResult'] =
                                                          shadesResult;
                                                      currValues[name]
                                                          ['haColor'] = haColor;
                                                      currValues[name]
                                                              ['haResult'] =
                                                          haResult;
                                                      currValues[name][
                                                              'blackIncnColor'] =
                                                          blackIncnColor;
                                                      currValues[name][
                                                              'blackIncnResult'] =
                                                          blackIncnResult;
                                                      currValues[name][
                                                              'whiteIncnColor'] =
                                                          whiteIncnColor;
                                                      currValues[name][
                                                              'whiteIncnResult'] =
                                                          whiteIncnResult;
                                                      currValues[name]
                                                          ['caratTo'] = caratTo;
                                                      currValues[name]
                                                              ['caratFrom'] =
                                                          caratFrom;
                                                      currValues[name]
                                                              ['discountFrom'] =
                                                          discountFromController
                                                              .text;
                                                      currValues[name]
                                                              ['discountTo'] =
                                                          discountToController
                                                              .text;
                                                      currValues[name]
                                                              ['dollarFrom'] =
                                                          ctFromController.text;
                                                      currValues[name]
                                                              ['dollarTo'] =
                                                          ctToController.text;
                                                      currValues[name]
                                                              ['ratioFrom'] =
                                                          ratioFromController
                                                              .text;
                                                      currValues[name]
                                                              ['ratioTo'] =
                                                          ratioToController
                                                              .text;
                                                      currValues[name]
                                                              ['lengthFrom'] =
                                                          lengthFromController
                                                              .text;
                                                      currValues[name]
                                                              ['lengthTo'] =
                                                          lengthToController
                                                              .text;
                                                      currValues[name]
                                                              ['widthFrom'] =
                                                          widthFromController
                                                              .text;
                                                      currValues[name]
                                                              ['widthTo'] =
                                                          widthToController
                                                              .text;
                                                      currValues[name]
                                                              ['heightFrom'] =
                                                          heightFromController
                                                              .text;
                                                      currValues[name]
                                                              ['heightTo'] =
                                                          heightToController
                                                              .text;
                                                      currValues[name][
                                                              'pavHeightFrom'] =
                                                          pavHeightFromController
                                                              .text;
                                                      currValues[name]
                                                              ['pavHeightTo'] =
                                                          pavHeightToController
                                                              .text;
                                                      currValues[name]
                                                              ['pavAngleFrom'] =
                                                          pavAngleFromController
                                                              .text;
                                                      currValues[name]
                                                              ['pavAngleTo'] =
                                                          pavAngleToController
                                                              .text;
                                                      currValues[name][
                                                              'crownHeightFrom'] =
                                                          crownHeightFromController
                                                              .text;
                                                      currValues[name][
                                                              'crownHeightTo'] =
                                                          crownHeightToController
                                                              .text;
                                                      currValues[name][
                                                              'crownAngleFrom'] =
                                                          crownAngleFromController
                                                              .text;
                                                      currValues[name]
                                                              ['crownAngleTo'] =
                                                          crownAngleToController
                                                              .text;
                                                      currValues[name]
                                                              ['gridleFrom'] =
                                                          gridleFromController
                                                              .text;
                                                      currValues[name]
                                                              ['gridleTo'] =
                                                          gridleToController
                                                              .text;
                                                      currValues[name]
                                                              ['tableFrom'] =
                                                          tableFromController
                                                              .text;
                                                      currValues[name]
                                                              ['tableTo'] =
                                                          tableToController
                                                              .text;
                                                      currValues[name]
                                                              ['starLenFrom'] =
                                                          starLenFromController
                                                              .text;
                                                      currValues[name]
                                                              ['starLenTo'] =
                                                          starLenToController
                                                              .text;
                                                      currValues[name]
                                                              ['certiNo'] =
                                                          certiNoController
                                                              .text;

                                                      if (savedSearch != null) {
                                                        // savedSearch.add(
                                                        //     json.encode(
                                                        //         currValues));

                                                        // pref.setStringList(
                                                        //     'savedSearch',
                                                        //     savedSearch);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                        saveSearchCriteria(
                                                            json.encode(
                                                                currValues),
                                                            name);
                                                      }
                                                    } else {
                                                      dialogKey.currentState
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  'Please enter the name for saving.')));
                                                    }
                                                  },
                                                  child: Text('Save'))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                    icon: Icon(Icons.save_alt,
                        size: 30.0, color: Color(0XFF294EA3)),
                    label: Text(
                      "SAVE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))),

            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      if (!FocusScope.of(context).hasPrimaryFocus) {
                        FocusScope.of(context).unfocus();
                      }
                      print('pressed reset');
                      changeColorAll = false;
                      changeColorAsscher = false;
                      changeColorCushion = false;
                      changeColorEmerald = false;
                      changeColorHeart = false;
                      changeColorMarquise = false;
                      changeColorOther = false;
                      changeColorOval = false;
                      changeColorPear = false;
                      changeColorPrincess = false;
                      changeColorRadiant = false;
                      changeColorRound = false;

                      Map shapeMap = Map();
                      shapeMap['all'] = changeColorAll;
                      shapeMap['round'] = changeColorRound;
                      shapeMap['princess'] = changeColorPrincess;
                      shapeMap['cushion'] = changeColorCushion;
                      shapeMap['oval'] = changeColorOval;
                      shapeMap['emerald'] = changeColorEmerald;
                      shapeMap['pear'] = changeColorPear;
                      shapeMap['asscher'] = changeColorAsscher;
                      shapeMap['heart'] = changeColorHeart;
                      shapeMap['radiant'] = changeColorRadiant;
                      shapeMap['marquise'] = changeColorMarquise;
                      shapeMap['other'] = changeColorOther;

                      caratListController.text = "";
                      caratToController.text = "";
                      caratFromController.text = "";
                      discountFromController.text = "";
                      discountToController.text = "";
                      ctFromController.text = "";
                      ctToController.text = "";
                      ratioFromController.text = "";
                      ratioToController.text = "";
                      lengthFromController.text = "";
                      lengthToController.text = "";
                      widthFromController.text = "";
                      widthToController.text = "";
                      heightFromController.text = "";
                      heightToController.text = "";
                      pavHeightFromController.text = "";
                      pavHeightToController.text = "";
                      pavAngleFromController.text = "";
                      pavAngleToController.text = "";
                      crownHeightFromController.text = "";
                      crownHeightToController.text = "";
                      crownAngleFromController.text = "";
                      crownAngleToController.text = "";
                      gridleFromController.text = "";
                      gridleToController.text = "";
                      tableFromController.text = "";
                      tableToController.text = "";
                      starLenFromController.text = "";
                      starLenToController.text = "";
                      certiNoController.text = "";
                      clarityColor.forEach((element) {
                        clarityColor[clarityColor.indexOf(element)] = false;
                      });
                      colourColor.forEach((element) {
                        colourColor[colourColor.indexOf(element)] = false;
                      });
                      cutColor.forEach((element) {
                        cutColor[cutColor.indexOf(element)] = false;
                      });
                      polishColor.forEach((element) {
                        polishColor[polishColor.indexOf(element)] = false;
                      });
                      symmColor.forEach((element) {
                        symmColor[symmColor.indexOf(element)] = false;
                      });
                      fluoreColor.forEach((element) {
                        fluoreColor[fluoreColor.indexOf(element)] = false;
                      });
                      certificateColor.forEach((element) {
                        certificateColor[certificateColor.indexOf(element)] =
                            false;
                      });
                      lusterColor.forEach((element) {
                        lusterColor[lusterColor.indexOf(element)] = false;
                      });
                      shadesColor.forEach((element) {
                        shadesColor[shadesColor.indexOf(element)] = false;
                      });
                      haColor.forEach((element) {
                        haColor[haColor.indexOf(element)] = false;
                      });
                      blackIncnColor.forEach((element) {
                        blackIncnColor[blackIncnColor.indexOf(element)] = false;
                      });
                      whiteIncnColor.forEach((element) {
                        whiteIncnColor[whiteIncnColor.indexOf(element)] = false;
                      });

                      setState(() {
                        shapesMap = shapeMap;
                        isFromSaved = true;
                      });
                    },
                    icon: Icon(Icons.restore,
                        size: 30.0, color: Color(0XFF294EA3)),
                    label: Text(
                      "RESET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))),
            // IconButton(
            //   icon: Icon(Icons.search,size: 30.0,color: Color(0XFF294EA3)),
            //   onPressed: () {  if (!FocusScope.of(context).hasPrimaryFocus) {FocusScope.of(context).unfocus();}
            //     _check(
            //         clarityResult,
            //         colourResult,
            //         cutResult,
            //         polishResult,
            //         symmResult,
            //         fluoreResult,
            //         certificateResult,
            //         lusterResult,
            //         shadesResult,
            //         haResult,
            //         blackIncnResult,
            //         whiteIncnColor,
            //         discountFrom,
            //         discountTo,
            //         dollarFrom,
            //         dollarTo,
            //         ratioFrom,
            //         ratioTo,
            //         caratFrom,
            //         caratTo,
            //         lengthFrom,
            //         lengthTo,
            //         widthFrom,
            //         widthTo,
            //         heightFrom,
            //         heightTo,
            //         pavHigFrom,
            //         pavHigTo,
            //         pavAngFrom,
            //         pavAngTo,
            //         crownHigFrom,
            //         crownHigTo,
            //         crownAngFrom,
            //         crownAngTo,
            //         gridleFrom,
            //         gridleTo,
            //         tableFrom,
            //         tableTo,
            //         starLenFrom,
            //         starLenTo);
            //     Navigator.pop(context, true);
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (BuildContext context) =>
            //                 searchlist(fil: filquery)));
            //   },
            // )
          ],
        ),
      ),
    ));
  }

  getvalue(arr) {
    String s = '';
    for (int i = 0; i < arr.length; i++) {
      if (i == 0) s += arr[i];
      if (i > 0) s += "," + arr[i];
    }
    return s;
  }

  saveSearchCriteria(String searchJson, String name) async {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saving...')));
    var saveMap = Map();
    saveMap['Token'] = token;
    saveMap['SaveName'] = name;
    saveMap['SearchCriteria'] = searchJson;
    saveMap['TransType'] = 'INSERT';
    Map<String, String> aheaders = {
      'Content-Type': 'application/json; charset=utf-8',
    };
    http.Response response = await http.post(
        'http://ozonediam.com/MObAppService.SVC/SaveSearch',
        headers: aheaders,
        body: json.encode(saveMap));
    var responseJson = json.decode(response.body);
    log('result ' + responseJson.toString());
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Saved')));
    MySearchPageState.loadSavedSearchList();
  }

  _check(
      round,
      princess,
      oval,
      cushion,
      marquise,
      pear,
      heart,
      radiant,
      emerald,
      asscher,
      clarityResult,
      colourResult,
      cutResult,
      polishResult,
      symmResult,
      fluoreResult,
      certificateResult,
      lusterResult,
      shadesResult,
      haResult,
      blackIncnResult,
      whiteIncnColor,
      discountFrom,
      discountTo,
      dollarFrom,
      dollarTo,
      ratioFrom,
      ratioTo,
      caratFrom,
      caratTo,
      lengthFrom,
      lengthTo,
      widthFrom,
      widthTo,
      heightFrom,
      heightTo,
      pavHigFrom,
      pavHigTo,
      pavAngFrom,
      pavAngTo,
      crownHigFrom,
      crownHigTo,
      crownAngFrom,
      crownAngTo,
      gridleFrom,
      gridleTo,
      tableFrom,
      tableTo,
      starLenFrom,
      starLenTo) {
    if (clarityResult.length == 0 &&
        colourResult.length == 0 &&
        cutResult.length == 0 &&
        polishResult.length == 0 &&
        symmResult.length == 0 &&
        fluoreResult.length == 0 &&
        certificateResult.length == 0 &&
        lusterResult.length == 0 &&
        shadesResult.length == 0 &&
        caratFrom == null &&
        caratTo == null &&
        haResult.length == 0 &&
        blackIncnResult.length == 0 &&
        whiteIncnColor.length == 0 &&
        discountFrom == null &&
        discountTo == null &&
        dollarFrom == null &&
        dollarTo == null &&
        ratioFrom == null &&
        ratioTo == null &&
        lengthFrom == null &&
        lengthTo == null) {
      print("null");
      //print(passs);
      // passsall;

      filquery = "AND PURITY_SEQ IN (1,2,3,4,5,6,7,8,9,10,11,12) ";
      //print(result);
    } else {
      filquery = "";
      List tempSelColorList = List();
      if (changeColorAll) {
        tempSelColorList.addAll([1, 2, 3, 4, 6, 7, 9, 13, 15, 28]);
      } else {
        if (changeColorRound) tempSelColorList.add(1);
        if (changeColorAsscher) tempSelColorList.add(28);
        if (changeColorCushion) tempSelColorList.add(9);
        if (changeColorEmerald) tempSelColorList.add(4);
        if (changeColorHeart) tempSelColorList.add(15);
        if (changeColorMarquise) tempSelColorList.add(3);
        if (changeColorOval) tempSelColorList.add(7);
        if (changeColorPear) tempSelColorList.add(6);
        if (changeColorPrincess) tempSelColorList.add(2);
        if (changeColorRadiant) tempSelColorList.add(13);
      }
      if (tempSelColorList.length > 0) {
        String val = tempSelColorList.join(',');
        filquery += 'AND SHAPE_SEQ IN (${val})';
      }

      if (clarityResult.length > 0) {
        String val = getvalue(clarityResult);
        var result = "AND PURITY_SEQ IN ($val)";
        filquery += '$result';
        print(result);
      }
      if (colourResult.length > 0) {
        String val = getvalue(colourResult);
        var result = "AND COLOR_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      // if(round!=null || princess!=null || marquise!=null || emerald!=null || pear!=null
      // || oval!=null || cushion!=null || radiant!=null || heart!=null || asscher!=null){
      //   var result = "AND SHAPE_SEQ IN ($round, $cushion,$princess,$marquise,$emerald,$pear,$oval,$radiant,$heart,$asscher)";
      //     filquery+= '$result';
      // }
      if (cutResult.length > 0) {
        String val = getvalue(cutResult);
        var result = "AND CUT_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      if (polishResult.length > 0) {
        String val = getvalue(polishResult);
        var result = "AND POLISH_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      if (symmResult.length > 0) {
        String val = getvalue(symmResult);
        var result = "AND SYMM_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      if (fluoreResult.length > 0) {
        String val = getvalue(fluoreResult);
        var result = "AND FLS_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      if (certificateResult.length > 0) {
        String val = getvalue(certificateResult);
        var result = "AND LAB_SEQ IN ($val) ";
        filquery += '$result';
        print(result);
      }
      if (shadesResult.length > 0) {
        String val = getvalue(shadesResult);
        var result = "AND SHADE IN ($val)";
        filquery += '$result';
        print(result);
      }
      if (caratList.length == 0) {
        if (caratFrom != null && caratTo != null) {
          String valfrom = caratFrom;
          String valTo = caratTo;
          var result =
              "AND WGT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
          filquery += '$result';
        }
      } else {
        List<String> caratQueryList = List();
        if (caratFrom != null && caratTo != null) {
          String valfrom = caratFrom;
          String valTo = caratTo;
          caratQueryList
              .add("WGT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}");
        }
        caratList.forEach((element) {
          caratQueryList.add(
              "WGT BETWEEN ${element.split('-')[0]} AND ${element.split('-')[1]}");
        });
        filquery += 'AND (${caratQueryList.join(" OR ")})';
      }
      if (haResult.length > 0) {
        String val = getvalue(haResult);
        var result = "AND HA IN($val)";
        filquery += '$result';
      }
      if (discountFrom != null && discountTo != null) {
        String valfrom = discountFrom;
        String valTo = discountTo;
        var result =
            "AND DISC_PER BETWEEN - ${valfrom.toString()} AND - ${valTo.toString()}";
        filquery += '$result';
      }
      if (ratioFrom != null && ratioTo != null) {
        String valfrom = ratioFrom;
        String valTo = ratioTo;
        var result =
            "AND RATIO BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (lengthFrom != null && lengthTo != null) {
        String valfrom = lengthFrom;
        String valTo = lengthTo;
        var result =
            "AND LENGTH BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (widthFrom != null && widthTo != null) {
        String valfrom = widthFrom;
        String valTo = widthTo;
        var result =
            "AND WIDTH BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (heightFrom != null && heightTo != null) {
        String valfrom = heightFrom;
        String valTo = heightTo;
        var result =
            "AND DEPTH BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (pavHigFrom != null && pavHigTo != null) {
        String valfrom = pavHigFrom;
        String valTo = pavHigTo;
        var result =
            "AND PAVILLION_HEIGHT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (pavAngFrom != null && pavAngTo != null) {
        String valfrom = pavAngFrom;
        String valTo = pavAngTo;
        var result =
            "AND PAVILLION_HEIGHT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (crownHigFrom != null && crownHigTo != null) {
        String valfrom = crownHigFrom;
        String valTo = crownHigTo;
        var result =
            "AND CROWN_HEIGHT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (crownAngFrom != null && crownAngTo != null) {
        String valfrom = crownAngFrom;
        String valTo = crownAngTo;
        var result =
            "AND CROWN_ANGLE BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (gridleFrom != null && gridleTo != null) {
        String valfrom = gridleFrom;
        String valTo = gridleTo;
        var result =
            "AND GIRDLE_PER BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (tableFrom != null && tableTo != null) {
        String valfrom = tableFrom;
        String valTo = tableTo;
        var result =
            "AND  TABLE_PER BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (starLenFrom != null && starLenTo != null) {
        String valfrom = starLenFrom;
        String valTo = starLenTo;
        var result =
            "AND  STAR BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
      }
      if (certiNoController.text != '' && certiNoController.text != null) {
        var result =
            'AND (REPORT_NO IN (\"${certiNoController.text}\") or VPACKET_NO IN(\"${certiNoController.text}\"))';
        filquery += '$result';
      }
    }
    print(filquery);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
