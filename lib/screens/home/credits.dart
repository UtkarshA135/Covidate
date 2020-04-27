import 'package:covidate/screens/home/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Credits extends StatefulWidget {
  @override
  _CreditsState createState() => _CreditsState();
}

class _CreditsState extends State<Credits> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
   void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

 Widget toolsUsed(){
   return Wrap(
    direction: Axis.horizontal,
     children: <Widget>[
       Container(
         padding: EdgeInsets.all(10.0),
         margin: EdgeInsets.only(bottom: 10.0),
         width: MediaQuery.of(context).size.width*0.4,
         height: 100.0,
         child: SvgPicture.network('https://cdn.worldvectorlogo.com/logos/flutter.svg') ,
       ),
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 10.0),
         height: 100.0,
         width: MediaQuery.of(context).size.width*0.4,
         child: SvgPicture.network('https://www.svgrepo.com/show/303670/firebase-1-logo.svg') ,
       ),
       Container(
         padding: EdgeInsets.all(10.0),
         margin: EdgeInsets.only(bottom: 10.0),
         height: 100.0,
         width: MediaQuery.of(context).size.width*0.4,
         child: SvgPicture.network('https://cdn.worldvectorlogo.com/logos/visual-studio-code.svg', color: Colors.blue[500],) ,
       ),
       Container(
         padding: EdgeInsets.all(10.0),
         margin: EdgeInsets.only(bottom: 10.0),
         height: 100.0,
         width: MediaQuery.of(context).size.width*0.4,
         child: SvgPicture.network('https://www.svgrepo.com/show/303615/github-icon-1-logo.svg',) ,
       ),
       
     ],
   );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits', 
        style: TextStyle(
          fontFamily: 'Lobster',
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
      ),
      body: SingleChildScrollView(
              child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             SlideTransition(
               position: _offsetAnimation,
               child: Stack(
                 children: <Widget>[
                   Stack(
                   children: <Widget>[
                       Container(
                           alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.06 , 
                      // vertical: ScreenUtil().setHeight(135.0)
                      ),
                         color: Colors.yellow,
                         width: ScreenUtil().setWidth(30.0) ,
                         height: ScreenUtil().setHeight(335.0)
                         ),
                     CredCircleYellow(),
                     Container(
                     alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0) , top: ScreenUtil().setHeight(320.0)),
                     child: SvgPicture.network('https://cdn.worldvectorlogo.com/logos/flutter.svg', height: ScreenUtil().setHeight(200.0),),
                        //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                     ),
                         
                       
                   ],
                       ),
                  Stack(
                  children: <Widget>[
                      Container(
                          alignment: Alignment.topCenter,
                     margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.19 , 
                     // vertical: ScreenUtil().setHeight(135.0)
                     ),
                        color: Colors.pink,
                        width: ScreenUtil().setWidth(30.0) ,
                        height: ScreenUtil().setHeight(265.0)
                        ),
                     CredCirclePink(),
                   Container(
                   alignment: Alignment.topLeft,
                   
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(317.0) , top: ScreenUtil().setHeight(247.0)),
                   child: SvgPicture.network('https://www.svgrepo.com/show/303670/firebase-1-logo.svg', height: ScreenUtil().setHeight(200.0),),
                    // child: SvgPicture.network('https://www.svgrepo.com/show/303615/github-icon-1-logo.svg', height: ScreenUtil().setHeight(200.0),),
                   //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                    ),
                    
                        
                      
                  ],
                 ),
                 ],
               ),
             ),
              Container(
                margin:EdgeInsets.only(top: 30.0),
               padding: EdgeInsets.all(16.0),
               child: Text(
                 'Hey! Thanks for downloading Covidate ;) \n This app is developed by Utkarsh Agarwal and Prasanthi Gandham \n ',
                 style: TextStyle(
                   fontSize: ScreenUtil().setSp(50.0),
                   letterSpacing: 1.0,
                  //  fontFamily: 'Signatra',
                 ),
               ),
                ),
                Text(
                  'Tools Used :',
                  style: TextStyle(
                   fontSize: ScreenUtil().setSp(65.0) , 
                   fontFamily: 'Lobster'
                  ),
                ),
                SizedBox(height: 10.0,),
              toolsUsed(),
              SizedBox(height: 20.0,),
              Text(
              'Github Repo :',
                style: TextStyle(
                 fontSize: ScreenUtil().setSp(65.0) , 
                 fontFamily: 'Lobster'
               ),
              ),
        SizedBox(height: 10.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: RaisedButton(
                  onPressed: _githubUrl,
                  color: Colors.white,
                   child: ListTile(
                    leading:  CircleAvatar(child: SvgPicture.network('https://www.svgrepo.com/show/303615/github-icon-1-logo.svg'), backgroundColor: Colors.white,),
                    title: Text('Github Link',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(55.0) ,
                        ),
                    ),
                    subtitle: Text('Tap here'),
                  ),
                ),
              ),
              LinkedIn()
           ],
          ),
        ),
      )
    );
  }
}



class LinkedIn extends StatefulWidget {
  @override
  _LinkedInState createState() => _LinkedInState();
}

class _LinkedInState extends State<LinkedIn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Contact Us :',
          style: TextStyle(
           fontSize: ScreenUtil().setSp(65.0) , 
           fontFamily: 'Lobster'
          ),
        ),
        SizedBox(height: 10.0,),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 26.0),
           child: RaisedButton(onPressed: _instaUrl,
                color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(child: SvgPicture.network('https://www.svgrepo.com/show/13639/instagram.svg'), backgroundColor: Colors.white,),
                title: Text('Utkarsh\'s Instagram',
                style: TextStyle(
                          fontSize: ScreenUtil().setSp(55.0) ,
                        ),
                ),
                subtitle: Text('Tap here'),
              )
              ),
         ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: RaisedButton(
                    color: Colors.white,
              onPressed: _launchURL,
              child:ListTile(
                leading: CircleAvatar(child: SvgPicture.network('https://www.svgrepo.com/show/158420/linkedin.svg'), backgroundColor: Colors.white,),
                title: Text('Prasanthi\'s LinkedIn',
                style: TextStyle(
                          fontSize: ScreenUtil().setSp(55.0) ,
                        ),
                ),
                subtitle: Text('Tap here'),
              ) ),
        ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: RaisedButton(
                color: Colors.white,
          onPressed: _launchURL1,
          child: ListTile(
              leading: CircleAvatar(child: SvgPicture.network('https://www.svgrepo.com/show/158420/linkedin.svg'), backgroundColor: Colors.white,),
              title: Text('Utkarsh\'s LinkedIn',
              style: TextStyle(
                        fontSize: ScreenUtil().setSp(55.0) ,
                      ),
              ),
              subtitle: Text('Tap here'),
            ),
          ),
        )],
    );
  }
}


_instaUrl() async {
  const url = 'https://www.instagram.com/utkarsh_0601/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}
_githubUrl() async {
  const url = 'https://github.com/UtkarshA135/Covidate';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}
_launchURL() async {
  const url = 'https://in.linkedin.com/in/prasanthi-gandham-437353195';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}
_launchURL1() async {
  const url = 'https://in.linkedin.com/in/utkarsh-agarwal-654470191';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}
