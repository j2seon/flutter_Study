import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_players/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video ==null ? renderEmpty() : renderVideo(),
    );
  }

  // 영상이 선택되지 않았을때 보여질 화면
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTap: onNewVideoPressed,),
          SizedBox(
            height: 30.0,
          ),
          _AppName(),
        ],
      ),
    );
  }

  //영상이 선택되었을때 보여질 화면 (video가 null 이 아닐때!!)
  // 위에서 선언한 XFile의 video를 알아겠지?그럼 그걸 받도록 설계하자
  Widget renderVideo(){
    return Center(
      child: CustomVideoPlayer(
        video: video!,
        onNewVideoPressed: onNewVideoPressed,
      ),
    );
  }

  //갤러리에서 이미지를 고를때까지 기다려야한다.
  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source:ImageSource.gallery,
    );
   if(video != null){ // 비디오가 null이 아니면
     setState(() { // state에 저장된 비디오변수에 선택된 비디오를 넣어준다.
       this.video = video;
     });
   }


  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter, // 색깔이 어디서부터시작할지
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap ;

  const _Logo({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
