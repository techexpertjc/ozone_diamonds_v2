import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ozone_diamonds/search.dart';
import 'package:ozone_diamonds/shape.dart';
import 'DashBoard.dart';
import 'inputformator.dart';

class StoneSearch extends StatefulWidget {
  @override
  _StoneSearchState createState() => _StoneSearchState();
}

class _StoneSearchState extends State<StoneSearch> {
  final _height = 26.0;
  final _shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(color: Colors.grey));
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
  final titleFont = 16.0; //font of title
  final titlebold = FontWeight.w400; //title font width
  final buttonFont = 12.0; //font size of button font
  final buttonbold = FontWeight.w400; //font bold of button font
  //clarity Field
  List<String> clarityName = [
    'FL',
    'IF',
    'VVS1',
    'VVS2',
    'VS1',
    'VS2',
    'SI1',
    'SI2',
    'SI3',
    'I1',
    'I2',
    'I3'
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
  List<bool> clarityColor = [
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
  List<String> colourName = [
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'l',
    'M',
    'N'
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
    '11'
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
    false
  ];
  List<String> colourResult = [];

  //finishing field
  List<String> finishingName = ['3EX', '3VG+', '2EX', 'NOBGM'];
  List<String> finishingValue = ['1', '2', '3', '4'];
  List<bool> finishingColor = [false, false, false, false];
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
  List<String> fluoreName = ['NON', 'FNT', 'MED', 'STG', 'VST', 'SL', 'VSL'];
  List<String> fluoreValue = ['1', '2', '3', '4', '5', '6', '7'];
  List<bool> fluoreColor = [false, false, false, false, false, false, false];
  List<String> fluoreResult = [];

  //Certificate field
  List<String> certificateName = ['GIA', 'IGI', 'HRD'];
  List<String> certificateValue = ['1', '2', '3'];
  List<bool> certificateColor = [false, false, false];
  List<String> certificateResult = [];

  //Luster field
  List<String> lusterName = [
    'EXCELLENT',
    'VERY GOOD',
    'GOOD',
    'MILKY 1',
    'MILKY 2'
  ];
  List<String> lusterValue = ['1', '2', '3', '4', '5', '6'];
  List<bool> lusterColor = [false, false, false, false, false, false];
  List<String> lusterResult = [];

  //Shades Field
  List<String> shadesName = ['NONE', 'BROWN', 'GREEN', 'MIX TINGE'];
  List<String> shadesValue = [
    "''NONE''",
    "''BROWN''",
    "''GREEN''",
    "''MIX TINGE''"
  ];
  List<bool> shadesColor = [false, false, false, false];
  List<String> shadesResult = [];

  //H&A field
  List<String> haName = ['EX', 'VG', 'GD'];
  List<String> haValue = [
    "''EX''",
    "''VG''",
    "''GD''",
  ];
  List<bool> haColor = [false, false, false];
  List<String> haResult = [];

  //black Inclustion field
  List<String> blackIncnName = ['CBL-0', 'CBL-1', 'CBL-2', 'SBL-0', 'SBL-1'];
  List<String> blackIncnValue = ['1', '2', '3', '4', '5'];
  List<bool> blackIncnColor = [false, false, false, false, false];
  List<String> blackIncnResult = [];

  //white Inclustion field
  List<String> whiteIncnName = [
    'CW-0',
    'CW-1',
    'CW-2',
    'SW-0',
    'SW-1',
    'SW-2',
    'SW-4'
  ];
  List<String> whiteIncnValue = ['1', '2', '3', '4', '5', '6', '7'];
  List<bool> whiteIncnColor = [false, false, false, false, false, false, false];
  List<String> whiteIncnResult = [];

  //shape value
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            //SearchField
            Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Container(
                  height: (size) ? 30 : 35,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: TextFormField(
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
                padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                child: Container(color: Colors.white, child: shapes())),

            //Carat Field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 20.0, bottom: 5.0),
                        child: Text(
                          'Carat',
                          style: TextStyle(
                              fontSize: titleFont, fontWeight: titlebold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 30),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: TextFormField(
                            inputFormatters: [DecimalTextInputFormatter()],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: InputBorder.none,
                                hintText: 'From',
                                hintStyle:
                                    TextStyle(fontSize: (size) ? 14 : 14)),
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
                            inputFormatters: [DecimalTextInputFormatter()],
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: InputBorder.none,
                                hintText: 'To',
                                hintStyle:
                                    TextStyle(fontSize: (size) ? 14 : 14)),
                            onChanged: (value) {
                              caratTo = value.toString();
                            },
                          ),
                        ),
                      )
                    ],
                  )),
            ),

            //clarity field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Clarity',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(clarityName.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 3.0, top: 3.0),
                              child: SizedBox(
                                height: _height,
                                width: (size) ? 62 : 75,
                                child: RaisedButton(
                                    elevation: 0.0,
                                    shape: _shape,
                                    color: clarityColor[index]
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        clarityColor[index] =
                                            !clarityColor[index];
                                        if (clarityResult.contains(
                                            clarityValue[index].toString())) {
                                          clarityResult.remove(
                                              clarityValue[index].toString());
                                        } else {
                                          clarityResult.add(
                                              clarityValue[index].toString());
                                        }
                                      });
                                      // print(buttonVlaue[index].toString());
                                    },
                                    child: Text(
                                      clarityName[index].toString(),
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          fontWeight: buttonbold,
                                          color: clarityColor[index]
                                              ? Colors.white
                                              : Colors.black),
                                    )),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  )),
            ),

            //colour field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Colour',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(colourName.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 3.0, top: 3.0),
                              child: SizedBox(
                                height: _height,
                                width: (size) ? 35 : 40,
                                child: RaisedButton(
                                    elevation: 0.0,
                                    shape: _shape,
                                    color: colourColor[index]
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        colourColor[index] =
                                            !colourColor[index];
                                        if (colourResult.contains(
                                            colourValue[index].toString())) {
                                          colourResult.remove(
                                              colourValue[index].toString());
                                        } else {
                                          colourResult.add(
                                              colourValue[index].toString());
                                        }
                                      });
                                      // print(buttonVlaue[index].toString());
                                    },
                                    child: Text(
                                      colourName[index].toString(),
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          color: colourColor[index]
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

            //finishing field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Finishing',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(finishingName.length, (index) {
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
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        finishingColor[index] =
                                            !finishingColor[index];
                                        if (finishingResult.contains(
                                            finishingValue[index].toString())) {
                                          finishingResult.remove(
                                              finishingValue[index].toString());
                                        } else {
                                          finishingResult.add(
                                              finishingValue[index].toString());
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
                                children:
                                    List.generate(cutName.length, (index) {
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
                                              ? Colors.indigo[800]
                                              : Colors.grey[100],
                                          onPressed: () {
                                            setState(() {
                                              cutColor[index] =
                                                  !cutColor[index];
                                              if (cutResult.contains(
                                                  cutValue[index].toString())) {
                                                cutResult.remove(
                                                    cutValue[index].toString());
                                              } else {
                                                cutResult.add(
                                                    cutValue[index].toString());
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
                                children:
                                    List.generate(polishName.length, (index) {
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
                                              ? Colors.indigo[800]
                                              : Colors.grey[100],
                                          onPressed: () {
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
                                            polishName[index].toString(),
                                            style: TextStyle(
                                                fontSize: buttonFont,
                                                color: polishColor[index]
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
                                children:
                                    List.generate(symmName.length, (index) {
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
                                              ? Colors.indigo[800]
                                              : Colors.grey[100],
                                          onPressed: () {
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
                                                symmResult.add(symmValue[index]
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
                  )),
            ),

            //Fluorescence field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Fluorescence',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(fluoreName.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 3.0, top: 3.0),
                              child: SizedBox(
                                height: _height,
                                width: (size) ? 62 : 75,
                                child: RaisedButton(
                                    elevation: 0.0,
                                    shape: _shape,
                                    color: fluoreColor[index]
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        fluoreColor[index] =
                                            !fluoreColor[index];
                                        if (fluoreResult.contains(
                                            fluoreValue[index].toString())) {
                                          fluoreResult.remove(
                                              fluoreValue[index].toString());
                                        } else {
                                          fluoreResult.add(
                                              fluoreValue[index].toString());
                                        }
                                      });
                                      // print(buttonVlaue[index].toString());
                                    },
                                    child: Text(
                                      fluoreName[index].toString(),
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          color: fluoreColor[index]
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

            // Certificate field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Certificate',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(certificateName.length, (index) {
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
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
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
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Luster',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(lusterName.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 3.0, top: 3.0),
                              child: SizedBox(
                                height: _height,
                                width: (size) ? 62 : 120,
                                child: RaisedButton(
                                    elevation: 0.0,
                                    shape: _shape,
                                    color: lusterColor[index]
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        lusterColor[index] =
                                            !lusterColor[index];
                                        if (lusterResult.contains(
                                            lusterValue[index].toString())) {
                                          lusterResult.remove(
                                              lusterValue[index].toString());
                                        } else {
                                          lusterResult.add(
                                              lusterValue[index].toString());
                                        }
                                      });
                                    },
                                    child: Text(
                                      lusterName[index].toString(),
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          color: lusterColor[index]
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

            //Shades field
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
              child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Shades',
                        style: TextStyle(
                            fontSize: titleFont, fontWeight: titlebold),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(shadesName.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, bottom: 3.0, top: 3.0),
                              child: SizedBox(
                                height: _height,
                                width: (size) ? 62 : 110,
                                child: RaisedButton(
                                    elevation: 0.0,
                                    shape: _shape,
                                    color: shadesColor[index]
                                        ? Colors.indigo[800]
                                        : Colors.grey[100],
                                    onPressed: () {
                                      setState(() {
                                        shadesColor[index] =
                                            !shadesColor[index];
                                        if (shadesResult.contains(
                                            shadesValue[index].toString())) {
                                          shadesResult.remove(
                                              shadesValue[index].toString());
                                        } else {
                                          shadesResult.add(
                                              shadesValue[index].toString());
                                        }
                                      });
                                    },
                                    child: Text(
                                      shadesName[index].toString(),
                                      style: TextStyle(
                                          fontSize: buttonFont,
                                          color: shadesColor[index]
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
                                        top: 5.0, left: 10.0, right: 10.0),
                                    child: Container(
                                      height: 55.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.9444,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'H&A',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: titleFont,
                                                fontWeight: titlebold),
                                          ),
                                          Center(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: List.generate(
                                                    haName.length, (index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0,
                                                            bottom: 3.0,
                                                            top: 3.0),
                                                    child: SizedBox(
                                                      height: _height,
                                                      width: (size) ? 60 : 65,
                                                      child: RaisedButton(
                                                          elevation: 0.0,
                                                          shape: _shape,
                                                          color: haColor[index]
                                                              ? Colors
                                                                  .indigo[800]
                                                              : Colors
                                                                  .grey[100],
                                                          onPressed: () {
                                                            setState(() {
                                                              haColor[index] =
                                                                  !haColor[
                                                                      index];
                                                              if (haResult.contains(
                                                                  haValue[index]
                                                                      .toString())) {
                                                                haResult.remove(
                                                                    haValue[index]
                                                                        .toString());
                                                              } else {
                                                                haResult.add(haValue[
                                                                        index]
                                                                    .toString());
                                                              }
                                                            });
                                                          },
                                                          child: Text(
                                                            haName[index]
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    buttonFont,
                                                                color: haColor[
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
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, left: 10.0, right: 10.0),
                            child: Container(
                              height: 55.0,
                              width: MediaQuery.of(context).size.width * 0.9444,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Black Inclusion',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: titleFont,
                                        fontWeight: titlebold),
                                  ),
                                  Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            blackIncnName.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 3.0,
                                                top: 3.0),
                                            child: SizedBox(
                                              height: _height,
                                              width: (size) ? 60 : 70,
                                              child: RaisedButton(
                                                  elevation: 0.0,
                                                  shape: _shape,
                                                  color: blackIncnColor[index]
                                                      ? Colors.indigo[800]
                                                      : Colors.grey[100],
                                                  onPressed: () {
                                                    setState(() {
                                                      blackIncnColor[index] =
                                                          !blackIncnColor[
                                                              index];
                                                      if (blackIncnResult
                                                          .contains(
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
                                                        fontSize: buttonFont,
                                                        color: blackIncnColor[
                                                                index]
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
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, left: 10.0, right: 10.0),
                            child: Container(
                              height: 55.0,
                              width: MediaQuery.of(context).size.width * 0.9444,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'White Inclusion',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: titleFont,
                                        fontWeight: titlebold),
                                  ),
                                  Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            whiteIncnName.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                bottom: 3.0,
                                                top: 3.0),
                                            child: SizedBox(
                                              height: _height,
                                              width: (size) ? 60 : 65,
                                              child: RaisedButton(
                                                  elevation: 0.0,
                                                  shape: _shape,
                                                  color: whiteIncnColor[index]
                                                      ? Colors.indigo[800]
                                                      : Colors.grey[100],
                                                  onPressed: () {
                                                    setState(() {
                                                      whiteIncnColor[index] =
                                                          !whiteIncnColor[
                                                              index];
                                                      if (whiteIncnResult
                                                          .contains(
                                                              whiteIncnValue[
                                                                      index]
                                                                  .toString())) {
                                                        whiteIncnResult.remove(
                                                            whiteIncnValue[
                                                                    index]
                                                                .toString());
                                                      } else {
                                                        whiteIncnResult.add(
                                                            whiteIncnValue[
                                                                    index]
                                                                .toString());
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    whiteIncnName[index]
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: buttonFont,
                                                        color: whiteIncnColor[
                                                                index]
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
                                          onChanged: (value) {
                                            discountFrom = value.toString();
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Text(
                                        'Dollar/ct %',
                                        style: TextStyle(
                                            fontSize: titleFont,
                                            fontWeight: titlebold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 100,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
                                          onChanged: (value) {
                                            crownHigFrom = value.toString();
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
                                          onChanged: (value) {
                                            crownAngFrom = value.toString();
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
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
                                          top: 5.0, bottom: 5.0, left: 30.0),
                                      child: Container(
                                        height: 40,
                                        // width: 50,
                                        child: TextFormField(
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'From',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
                                          onChanged: (value) {
                                            starLenFrom = value.toString();
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
                                          inputFormatters: [
                                            DecimalTextInputFormatter()
                                          ],
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: InputBorder.none,
                                              hintText: 'To',
                                              hintStyle: TextStyle(
                                                  fontSize: (size) ? 14 : 14)),
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
                      child: pressed
                          ? Text("Hide Advance Search")
                          : Text('Show Advance Search'),
                      onPressed: () {
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
      bottomNavigationBar: new BottomAppBar(
        elevation: 20.0,
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                  onPressed: () {
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
                    Navigator.pop(context, true);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                searchlist(fil: filquery)));
                  },
                  icon: Icon(
                    Icons.search,
                    size: 30.0,
                    color: Colors.indigo[800],
                  ),
                  label: Text(
                    "SEARCH",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
                child: FlatButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.save_alt,
                        size: 30.0, color: Colors.indigo[800]),
                    label: Text(
                      "SAVE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.restore,
                        size: 30.0, color: Colors.indigo[800]),
                    label: Text(
                      "RESET",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))),
            // IconButton(
            //   icon: Icon(Icons.search,size: 30.0,color: Colors.indigo[800]),
            //   onPressed: () {
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
      if (caratFrom != null && caratTo != null) {
        String valfrom = caratFrom;
        String valTo = caratTo;
        var result =
            "AND WGT BETWEEN ${valfrom.toString()} AND ${valTo.toString()}";
        filquery += '$result';
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
    }
    print(filquery);
  }
}
