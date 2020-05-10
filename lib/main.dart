import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carouseldemo/FirstView.dart';
import 'package:carouseldemo/Size_Config.dart';
import 'package:carouseldemo/custom_icons_icons.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'FadeIn.dart';
import 'FourthVIew.dart';
import 'Profile.dart';
import 'SecondPage.dart';
import 'SecondView.dart';
import 'Stats.dart';
import 'ThirdView.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,statusBarIconBrightness: Brightness.dark
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(CarouselDemo());
}

class CarouselDemo extends StatefulWidget {
  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}


class _CarouselDemoState extends State<CarouselDemo> {


  @override
  void initState() {
    // adjust the provider based on the image type
    precacheImage(new AssetImage('images/image1.gif'),context);
    precacheImage(new AssetImage('images/image1.jpg'),context);
    precacheImage(new AssetImage('images/image2.jpg'),context);
    precacheImage(new AssetImage('images/image3.jpg'),context);
    precacheImage(new AssetImage('images/image4.jpg'),context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: frontpage(),
    );
  }
}

class frontpage extends StatefulWidget {
  @override
  _frontpageState createState() => _frontpageState();
}
class _frontpageState extends State<frontpage> {
  int _currentIndex = 0;
  PanelController _pc = new PanelController();
  PageController _pgc = new PageController(initialPage: 0);
  void changePage(int index) {
    setState(() {
      bool delta;
      int time;
      if ( _currentIndex > index) {
        _currentIndex - index == 1 ? delta = true : delta = false; }
       else if ( index > _currentIndex) {
          index - _currentIndex == 1 ? delta = true : delta = false;
      }
      delta ? time = 400 : time = 800;
         _currentIndex = index;
      _pgc.animateToPage(_currentIndex, duration: Duration(milliseconds: time), curve: Curves.easeInOut);

    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Size_Config().init(context);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pgc,
        children: <Widget>[
          SlidingUpPanel(
            controller: _pc,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            minHeight: Size_Config.blockSizeVertical * 50,
            maxHeight: Size_Config.blockSizeVertical * 65,
           // parallaxEnabled: true,
           // parallaxOffset: 0.2,
            defaultPanelState: PanelState.OPEN,

            body: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Container(
                  width: Size_Config.screenWidth,
                  height: Size_Config.screenHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/imagebg.png'),
                      colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                      fit: BoxFit.cover
                    ),gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.red, Colors.purple])
                      ),
                  child: Container(
                    margin: EdgeInsets.only(top: Size_Config.blockSizeVertical * 30,bottom: Size_Config.blockSizeVertical * 60,left: Size_Config.blockSizeHorizontal * 2,right: Size_Config.blockSizeHorizontal * 20),
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      monthTextStyle: TextStyle(fontFamily: 'Montserrat',color: Colors.white54),
                      dateTextStyle: TextStyle(fontFamily: 'MontSerrat',fontSize: Size_Config.blockSizeHorizontal * 5,fontWeight: FontWeight.bold,color: Colors.white54),
                      dayTextStyle: TextStyle(fontFamily: 'Montserrat',color: Colors.white54),
                      onDateChange:(date) => _pc.open(),
                    ),
                  ),
                ),
                Container(

                  height: Size_Config.screenHeight,
                  width: Size_Config.blockSizeHorizontal * 20,
                  color: Colors.black12,
                ),
                Container(

                  height: Size_Config.blockSizeVertical * 25,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        //Spacer(),
                        Expanded(
                          flex: 8,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(CustomIcons.plus),
                                  color: Colors.white54,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(transitionDuration: Duration(milliseconds: 600),  pageBuilder: (_,__,___) => SecondPage()));
                                  },
                                  //iconSize: 25,
                                ),
                              ),
                              //Expanded(flex: 1, child: SizedBox()),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () => _pc.close(),
                                  icon: Icon(CustomIcons.filter),
                                  color: Colors.white54,
                                  //iconSize: 40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                Positioned(
                  top: Size_Config.blockSizeVertical * 15,
                  left: Size_Config.blockSizeHorizontal * 10,
                  child: FadeIn(1.66,Text(
                    'Hi Amith!',
                    style: TextStyle(
                        fontSize: Size_Config.blockSizeHorizontal * 9,
                        fontFamily: 'Pacifico',
                        color: Colors.white),
                  ),)
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: Size_Config.screenWidth,
                  child: FadeIn(1,GestureDetector(
                    onTap: () {
                      changePage(2);

                    },
                    child: TweenAnimationBuilder(
                      duration: Duration(seconds: 3),
                      tween: Tween<double>(begin: 0.1,end: 1),
                      curve: Curves.elasticOut,
                      builder: (context,value,child){
                        return Transform.scale(scale: value,child: AvatarGlow(
                          glowColor: Colors.white,
                          repeat: true,
                          repeatPauseDuration: Duration(seconds: 3),
                          duration: Duration(seconds: 3),
                          endRadius: Size_Config.blockSizeHorizontal * 15,
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(Size_Config.blockSizeHorizontal * 7),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                  'images/image1.gif'),
                              radius: Size_Config.blockSizeHorizontal * 7,
                            ),
                          ),
                        ),);
                      },
                    ),
                  ),)
                ),
              ],
            ),
            panel: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              child: Container(
                alignment: Alignment.center,
                height: Size_Config.screenHeight,
                width: Size_Config.screenWidth,
                //color: Colors.grey[100],
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/imagebg.png'),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                  ),


                  color: Colors.grey[100]
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: FadeIn(2.33,CarouselSlider(
                              options: CarouselOptions(
                                height: Size_Config.screenHeight,
                                //aspectRatio: 16/9,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.7,
                                enlargeCenterPage: true,
                              ),
                              items: <Widget>[
                                Container(
                                    alignment: Alignment.centerLeft,
                                    width: Size_Config.screenWidth,
                                    child: Container(
                                      height: Size_Config.screenHeight,
                                      width: Size_Config.blockSizeHorizontal *  60,
                                      //color: Colors.red,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'Try Something new today!',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w700,
                                                fontSize: Size_Config.blockSizeHorizontal * 10),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'if you do something consistently for 21 days, it becomes a habit! Are you ready to start a new habit?',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w200,
                                                fontSize: Size_Config.blockSizeHorizontal * 5),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(bottom: Size_Config.blockSizeVertical * 5,top: Size_Config.blockSizeVertical * 5),
                                  child: Hero(
                                    tag: "Var1",
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration: Duration(milliseconds: 800),
                                                pageBuilder: (_,__,___)
                                                =>
                                                    FirstView()));
                                      },
                                      child: Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(25),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: Size_Config.screenWidth,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(25),
                                                  color: Colors.red,
                                                  image: DecorationImage(
                                                      image: AssetImage('images/image1.jpg'),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              Positioned(left: 20,bottom: 30,child: Text('Do Anytime', style: TextStyle(fontFamily: 'Montserrat',fontSize: Size_Config.blockSizeHorizontal * 8,color: Colors.white),))
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(bottom: Size_Config.blockSizeVertical * 5,top: Size_Config.blockSizeVertical * 5),
                                  child: Hero(
                                    tag: "Var2",
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration: Duration(milliseconds: 800),
                                                pageBuilder: (_,__,___)
                                                =>
                                                    SecondView()));
                                      },
                                      child: Material(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          borderRadius: BorderRadius.circular(25),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: Size_Config.screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    color: Colors.blue,
                                                    image: DecorationImage(
                                                      image: AssetImage('images/image2.jpg'),fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Positioned(left: 20,bottom: 30,child: Text('Morning', style: TextStyle(fontFamily: 'Montserrat',fontSize: Size_Config.blockSizeHorizontal * 10,color: Colors.white),))

                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(bottom: Size_Config.blockSizeVertical * 5,top: Size_Config.blockSizeVertical *5),
                                  child: Hero(
                                    tag: "Var3",
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration: Duration(milliseconds: 800),
                                                pageBuilder: (_,__,___)
                                                =>
                                                    ThirdView()));
                                      },
                                      child: Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(25),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: Size_Config.screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    color: Colors.green,
                                                    image: DecorationImage(
                                                        image: AssetImage('images/image3.jpg'),fit: BoxFit.cover)),
                                              ),
                                              Positioned(left: 20,bottom: 30,child: Text('Afternoon', style: TextStyle(fontFamily: 'Montserrat',fontSize: Size_Config.blockSizeHorizontal * 10,color: Colors.white),))

                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(bottom: Size_Config.blockSizeVertical * 5 ,top: Size_Config.blockSizeVertical * 5),
                                  child: Hero(
                                    tag: "Var4",
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                transitionDuration: Duration(milliseconds: 800),
                                                pageBuilder: (_,__,___)
                                                =>
                                                    FourthView()));
                                      },
                                      child: Material(
                                          elevation: 10,
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(25),
                                          child: Stack(
                                            children: <Widget>[
                                              Container(
                                                width: Size_Config.screenWidth,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                    color: Colors.green,
                                                    image: DecorationImage(
                                                        image: AssetImage('images/image4.jpg'),fit: BoxFit.cover)),
                                              ),
                                              Positioned(left: 20,bottom: 30,child: Text('Evening', style: TextStyle(fontFamily: 'Montserrat',fontSize: Size_Config.blockSizeHorizontal * 10,color: Colors.white),))

                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ]),)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Stats(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 15,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                CustomIcons.home,
                color: Colors.black,
              ),
              activeIcon: Icon(
                CustomIcons.home,
                color: Colors.red,
              ),
              title: Text("Home",style: TextStyle(fontFamily: 'Montserrat'),)),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                CustomIcons.bar_chart,
                color: Colors.black,
              ),
              activeIcon: Icon(
                CustomIcons.bar_chart,
                color: Colors.red,
              ),
              title: Text("Stats",style: TextStyle(fontFamily: 'Montserrat'))),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                CustomIcons.user,
                color: Colors.black,
              ),
              activeIcon: Icon(
                CustomIcons.user,
                color: Colors.red,
              ),
              title: Text("Profile",style: TextStyle(fontFamily: 'Montserrat'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          CustomIcons.plus,
          color: Colors.white,
          size: 20,
        ),
        heroTag: "demoTag",
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
              context, PageRouteBuilder(transitionDuration: Duration(milliseconds: 600),  pageBuilder: (_,__,___) => SecondPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}


//collapsed: Container(
//              alignment: Alignment.topCenter,
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.only(
//                      topRight: Radius.circular(25),
//                      topLeft: Radius.circular(25)),
//                  color: Colors.white),
//              //color: Colors.white,
//              child: IconButton(
//                icon: Icon(Icons.keyboard_arrow_up),
//                iconSize: 40,
//                color: Colors.grey,
//                onPressed: () {
//                  setState(() {
//                    _pc.open();
//                  });
//                },
//              ),
//            ),