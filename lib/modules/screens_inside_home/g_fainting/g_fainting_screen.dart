
import 'package:accidents/modules/screens_inside_home/a_chock/screens/b__screen.dart';
import 'package:accidents/modules/screens_inside_home/a_chock/screens/c__screen.dart';
import 'package:accidents/modules/screens_inside_home/a_chock/screens/d__screen.dart';
import 'package:accidents/modules/screens_inside_home/g_fainting/screens/a__screen.dart';
import 'package:accidents/modules/screens_inside_home/g_fainting/screens/b__screen.dart';
import 'package:accidents/modules/screens_inside_home/g_fainting/screens/c__screen.dart';
import 'package:accidents/modules/screens_inside_home/g_fainting/screens/d__screen.dart';
import 'package:accidents/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../layout/doc_app/cubit/cubit.dart';
import '../../../layout/doc_app/cubit/states.dart';

class ag_FaintingScreen extends StatefulWidget {
  const ag_FaintingScreen({Key? key}) : super(key: key);

  @override
  State<ag_FaintingScreen> createState() => _ag_FaintingScreenState();
}
  class _ag_FaintingScreenState extends State<ag_FaintingScreen>{
  late bool isPlaying  , isMute ;
  final String url='https://youtu.be/FhoCH1uxiH0';
  late YoutubePlayer youtubePlayer;
  late YoutubePlayerController _controller;
  late String id;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isMute = false;
    id=YoutubePlayer.convertUrlToId(url)!;
    _controller=YoutubePlayerController(initialVideoId: id,
    flags: YoutubePlayerFlags(autoPlay: false,)
    );
    youtubePlayer = YoutubePlayer(controller: _controller);
    isPlaying = _controller.value.isPlaying;

  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  alignment: Alignment.topCenter,

                      height: size.height * .3,

                  child: youtubePlayer,
                  //child: BookInfo(size: size,)
              ),
            ),


            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, a_FaintingScreen());
                      },
                      child: Container(
                        child: ChapterCard(
                          name: "تعريف الإغماء",
                          press: () {
                            navigateTo(context, a_FaintingScreen());
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, b_FaintingScreen());
                      },
                      child: ChapterCard(
                        name: "الاعراض ",
                        press: () {navigateTo(context, b_FaintingScreen());},
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, c_FaintingScreen());
                      },
                      child: ChapterCard(
                        name: "الوقاية",
                        press: () {navigateTo(context, c_FaintingScreen());},
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navigateTo(context, d_FaintingScreen());
                      },
                      child: ChapterCard(

                        name: "الإسعافات الأولية",
                        press: () {navigateTo(context, d_FaintingScreen());},
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }

  textBuilder(String string, {double fontSize = 17, FontWeight weight = FontWeight.normal, Color color = Colors.black})
  {
    return Container(
        margin: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Text(
              string,
              style: TextStyle(fontSize: fontSize,
              fontWeight: weight,
              color: color,
              ),
        ));
  }





  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

}

class ChapterCard extends StatelessWidget {
  final String name;
  final VoidCallback? press;
  const ChapterCard({
  //  required Key key,
    required this.name,
    required this.press,
  }) ;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<DocCubit , DocStates>(
        listener: (context, state){},
    builder: (context, state) {
      var cubit = DocCubit.get(context);
      Color colorText = cubit.isDark ? Colors.white : Colors.black;
      Color colorContainer = cubit.isDark ? Colors.grey : Colors.white;

      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: EdgeInsets.only(bottom: 16),
        width: size.width *.95,
        decoration: BoxDecoration(
          color: colorContainer,
          borderRadius: BorderRadius.circular(38.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 33,
              color: cubit.isDark ? Color(0xFFD3D3D3).withOpacity(.3) : Color(0xFFD3D3D3).withOpacity(.99),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left_sharp,
                size: size.width *0.05,
                color: colorText,
              ),
              onPressed: press,
            ),
            Spacer(),
            Center(
              child: Expanded(
                child: Text(
                  "${name}",
                  style: TextStyle(
                    fontSize: size.width * .04,
                    color: colorText,
                    fontWeight: FontWeight.w800,


                  ),


                ),
              ),

            ),


          ],

        ),
      );
    }
    );
  }
}

