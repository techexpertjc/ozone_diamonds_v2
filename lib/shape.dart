import 'package:flutter/material.dart';
import 'ozone_diaicon_icons.dart';
import 'package:ozone_diamonds/StoneSearch.dart';

class shapes extends StatefulWidget {
  final customFunction, shapeMap, loadfromSaved;
  shapes({Key key, this.customFunction, this.shapeMap, this.loadfromSaved})
      : super(key: key);
  @override
  shapesState createState() => shapesState();
}

class shapesState extends State<shapes> {
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
  bool size = false;
  static String all,
      round,
      princess,
      cushion,
      oval,
      emerald,
      pear,
      asscher,
      heart,
      radiant,
      marquise,
      other;
  bool loadFromSaved = false;
  @override
  void initState() {
    // TODO: implement initState
    loadFromSaved = (widget.loadfromSaved == true);
    if (widget.shapeMap != null && loadFromSaved) {
      Map tempMap = widget.shapeMap;
      print(tempMap);

      loadFromSaved = false;
    }

    super.initState();
    widget.customFunction(
      changeColorAll,
      changeColorRound,
      changeColorPrincess,
      changeColorCushion,
      changeColorOval,
      changeColorEmerald,
      changeColorPear,
      changeColorAsscher,
      changeColorHeart,
      changeColorRadiant,
      changeColorMarquise,
      changeColorOther,
    );
  }

  void mySetState() {
    loadFromSaved = (widget.loadfromSaved == true);
    setState(() {});
    if (widget.shapeMap != null && isFromSaved) {
      Map tempMap = widget.shapeMap;
      print(tempMap);
      print('inside shhapes ' + tempMap['all'].toString());

      changeColorAll = tempMap['all'];
      changeColorAsscher = tempMap['asscher'];
      changeColorCushion = tempMap['cushion'];
      changeColorEmerald = tempMap['emerald'];
      isFromSaved = false;
      setState(() {});
    }
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    loadFromSaved = (widget.loadfromSaved == true);
    if (widget.shapeMap != null && isFromSaved) {
      Map tempMap = widget.shapeMap;
      print(tempMap);
      print('inside shhapes ' + tempMap['all'].toString());

      changeColorAll = tempMap['all'];
      changeColorAsscher = tempMap['asscher'];
      changeColorCushion = tempMap['cushion'];
      changeColorEmerald = tempMap['emerald'];
      changeColorHeart = tempMap['heart'];
      changeColorMarquise = tempMap['marquise'];
      changeColorOther = tempMap['other'];
      changeColorOval = tempMap['oval'];
      changeColorPear = tempMap['pear'];
      changeColorPrincess = tempMap['princess'];
      changeColorRadiant = tempMap['radiant'];
      changeColorRound = tempMap['round'];

      isFromSaved = false;
    }

    super.setState(fn);

    widget.customFunction(
      changeColorAll,
      changeColorRound,
      changeColorPrincess,
      changeColorCushion,
      changeColorOval,
      changeColorEmerald,
      changeColorPear,
      changeColorAsscher,
      changeColorHeart,
      changeColorRadiant,
      changeColorMarquise,
      changeColorOther,
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  //  width: MediaQuery.of(context).size.width * 0.16,
                  //  height: MediaQuery.of(context).size.height * 0.10,

                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: changeColorAll ? Colors.grey : Colors.grey),
                    color: changeColorAll
                        ? Colors.indigo[800]
                        : Colors.transparent,
                    // gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: [Colors.blue[100], Colors.indigo[200]])
                  ),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.all,
                          size: 30.0,
                        ),
                        color: changeColorAll ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorAll == false) {
                              changeColorAll = !changeColorAll;
                              round = "1";
                              princess = "2";
                              marquise = "3";
                              emerald = "4";
                              pear = "6";
                              oval = "7";
                              cushion = "9";
                              radiant = "13";
                              heart = "15";
                              asscher = "28";
                              if (changeColorRound == true) {
                                changeColorRound = changeColorRound;
                              } else {
                                changeColorRound = !changeColorRound;
                              }
                              if (changeColorPrincess == true) {
                                changeColorPrincess = changeColorPrincess;
                              } else {
                                changeColorPrincess = !changeColorPrincess;
                              }
                              if (changeColorCushion == true) {
                                changeColorCushion = changeColorCushion;
                              } else {
                                changeColorCushion = !changeColorCushion;
                              }
                              if (changeColorOval == true) {
                                changeColorOval = changeColorOval;
                              } else {
                                changeColorOval = !changeColorOval;
                              }
                              if (changeColorEmerald == true) {
                                changeColorEmerald = changeColorEmerald;
                              } else {
                                changeColorEmerald = !changeColorEmerald;
                              }
                              if (changeColorPear == true) {
                                changeColorPear = changeColorPear;
                              } else {
                                changeColorPear = !changeColorPear;
                              }
                              if (changeColorAsscher == true) {
                                changeColorAsscher = changeColorAsscher;
                              } else {
                                changeColorAsscher = !changeColorAsscher;
                              }
                              if (changeColorHeart == true) {
                                changeColorHeart = changeColorHeart;
                              } else {
                                changeColorHeart = !changeColorHeart;
                              }
                              if (changeColorRadiant == true) {
                                changeColorRadiant = changeColorRadiant;
                              } else {
                                changeColorRadiant = !changeColorRadiant;
                              }
                              if (changeColorMarquise == true) {
                                changeColorMarquise = changeColorMarquise;
                              } else {
                                changeColorMarquise = !changeColorMarquise;
                              }
                              if (changeColorOther == true) {
                                changeColorOther = changeColorOther;
                              } else {
                                changeColorOther = !changeColorOther;
                              }
                            } else {
                              changeColorAll = !changeColorAll;
                              if (changeColorRound == true) {
                                changeColorRound = !changeColorRound;
                              }
                              if (changeColorPrincess == true) {
                                changeColorPrincess = !changeColorPrincess;
                              }
                              if (changeColorCushion == true) {
                                changeColorCushion = !changeColorCushion;
                              }
                              if (changeColorOval == true) {
                                changeColorOval = !changeColorOval;
                              }
                              if (changeColorEmerald == true) {
                                changeColorEmerald = !changeColorEmerald;
                              }
                              if (changeColorPear == true) {
                                changeColorPear = !changeColorPear;
                              }
                              if (changeColorAsscher == true) {
                                changeColorAsscher = !changeColorAsscher;
                              }
                              if (changeColorHeart == true) {
                                changeColorHeart = !changeColorHeart;
                              }
                              if (changeColorRadiant == true) {
                                changeColorRadiant = !changeColorRadiant;
                              }
                              if (changeColorMarquise == true) {
                                changeColorMarquise = !changeColorMarquise;
                              }
                              if (changeColorOther == true) {
                                changeColorOther = !changeColorOther;
                              }
                            }
                          });
                        },
                      ),
                      Text(
                        'All',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorAll ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: changeColorRound ? Colors.grey : Colors.grey),
                      color: changeColorRound
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.round,
                          size: 30.0,
                        ),
                        color: changeColorRound ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorRound == false) {
                              round = "1";
                            } else {
                              round = null;
                            }
                            changeColorRound = !changeColorRound;
                          });
                        },
                      ),
                      Text(
                        'Round',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorRound ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorPrincess ? Colors.grey : Colors.grey),
                      color: changeColorPrincess
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.princess,
                          size: 30.0,
                        ),
                        color:
                            changeColorPrincess ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorPrincess == false) {
                              princess = "2";
                            } else {
                              princess = null;
                            }

                            changeColorPrincess = !changeColorPrincess;
                          });
                        },
                      ),
                      Text(
                        'Princess',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorPrincess ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorCushion ? Colors.grey : Colors.grey),
                      color: changeColorCushion
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.cushion,
                          size: 30.0,
                        ),
                        color: changeColorCushion ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorCushion == false) {
                              cushion = "9";
                            } else {
                              cushion = null;
                            }
                            changeColorCushion = !changeColorCushion;
                          });
                        },
                      ),
                      Text(
                        'Cushion',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorCushion ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: changeColorOval ? Colors.grey : Colors.grey),
                      color: changeColorOval
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.oval,
                          size: 30.0,
                        ),
                        color: changeColorOval ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorOval == false) {
                              oval = "7";
                            } else {
                              oval = null;
                            }
                            changeColorOval = !changeColorOval;
                          });
                        },
                      ),
                      Text(
                        'Oval',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorOval ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorEmerald ? Colors.grey : Colors.grey),
                      color: changeColorEmerald
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.emerald,
                          size: 30.0,
                        ),
                        color: changeColorEmerald ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorEmerald == false) {
                              emerald = "4";
                            } else {
                              emerald = null;
                            }
                            changeColorEmerald = !changeColorEmerald;
                          });
                        },
                      ),
                      Text(
                        'Emerald',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorEmerald ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 0.0, right: 0.0),
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: changeColorPear ? Colors.grey : Colors.grey),
                      color: changeColorPear
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.pear,
                          size: 30.0,
                        ),
                        color: changeColorPear ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorPear == false) {
                              pear = "6";
                            } else {
                              pear = null;
                            }
                            changeColorPear = !changeColorPear;
                          });
                        },
                      ),
                      Text(
                        'Pear',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorPear ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorAsscher ? Colors.grey : Colors.grey),
                      color: changeColorAsscher
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.asscher,
                          size: 30.0,
                        ),
                        color: changeColorAsscher ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorAsscher == false) {
                              asscher = "28";
                            } else {
                              asscher = null;
                            }
                            changeColorAsscher = !changeColorAsscher;
                          });
                        },
                      ),
                      Text(
                        'Asscher',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorAsscher ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: changeColorHeart ? Colors.grey : Colors.grey),
                      color: changeColorHeart
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.heart,
                          size: 30.0,
                        ),
                        color: changeColorHeart ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorHeart == false) {
                              heart = "15";
                            } else {
                              heart = null;
                            }
                            changeColorHeart = !changeColorHeart;
                          });
                        },
                      ),
                      Text(
                        'Heart',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorHeart ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorRadiant ? Colors.grey : Colors.grey),
                      color: changeColorRadiant
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.radiant,
                          size: 30.0,
                        ),
                        color: changeColorRadiant ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorRadiant == false) {
                              radiant = "13";
                            } else {
                              radiant = null;
                            }
                            changeColorRadiant = !changeColorRadiant;
                          });
                        },
                      ),
                      Text(
                        'Radiant',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorRadiant ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              changeColorMarquise ? Colors.grey : Colors.grey),
                      color: changeColorMarquise
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.marquise,
                          size: 30.0,
                        ),
                        color:
                            changeColorMarquise ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            if (changeColorMarquise == false) {
                              marquise = "3";
                            } else {
                              marquise = null;
                            }
                            changeColorMarquise = !changeColorMarquise;
                          });
                        },
                      ),
                      Text(
                        'Marquise',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              changeColorMarquise ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(bottom: 1.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: changeColorOther ? Colors.grey : Colors.grey),
                      color: changeColorOther
                          ? Colors.indigo[800]
                          : Colors.transparent),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          OzoneDiaicon.other,
                          size: 30.0,
                        ),
                        color: changeColorOther ? Colors.white : Colors.black,
                        onPressed: () {
                          setState(() {
                            changeColorOther = !changeColorOther;
                          });
                        },
                      ),
                      Text(
                        'Other',
                        style: TextStyle(
                          fontSize: 10,
                          color: changeColorOther ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
