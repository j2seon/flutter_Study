import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video; //imagePicker에서 사용하는 타입.> XFile
  final VoidCallback onNewVideoPressed;

  const CustomVideoPlayer({required this.video, required this.onNewVideoPressed, Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? videoController; // 생성될때 사용하도록하려면? init
  Duration currentPosition = Duration(); // 현재위치
  bool showControls = false;


  @override
  void initState() {
    super.initState(); //VideoPlayerController에서 사용되는 file은 플러터에서 사용하는 File 타입
    //XFile 타입을 플러터에서 사용하는 타입으로 변형시켜서 넣어줘야한다.
    initalizeController();
  }

  @override
  void didUpdatedWidget(covariant CustomVideoPlayer oldWidget){
    super.didUpdateWidget(oldWidget);
    if(oldWidget.video.path != widget.video.path){
      initalizeController();
    }
  }

  //initState()에서는 async를 사용할 수 없다.. 따라서 따로 함수로 만들어야한다.
  initalizeController() async {
    currentPosition = Duration();

    videoController = VideoPlayerController.file(
      File(widget.video.path),
    );
    await videoController!.initialize(); //initialize는 초기화를 뜻한다.

    //addListener는 함수를 넣게되는데 이 함수는 값이 변경될때마다 실행된다!!
    // 즉 여기에 값이 변경될때마다 바꾸고싶은 걸 넣으면됨.
    videoController!.addListener(() {
      //현재위치를 가져와서
      final currentPosition = videoController!.value.position;
      //state에 저장된 값으로 현재 위치를 바꿔줄거다.
      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //null 처리를 해주는 이유?
    //따로 initalizeController함수로 만들어서 initState에 사용했기때문에 videoController가 null값이 나올수있다.
    if (videoController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
      //비율을 맞춰주기 위해
      aspectRatio: videoController!.value.aspectRatio,
      child: GestureDetector(
        onTap: (){
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          // stack 위젯을 버튼 모양들을 위에 쌓아준다.
          children: [
            VideoPlayer(videoController!),
            if(showControls)
              _Controls(
                onPlayPressed: onPlayPressed,
                onReversePressed: onReversePressed,
                onForwardPressed: onForwardPressed,
                isPlaying: videoController!.value.isPlaying,
              ),
            if(showControls)
              _NewVideo(
                onPressed: widget.onNewVideoPressed,
              ),
            _SliderBottom(
              currentPosition: currentPosition,
              maxPosition: videoController!.value.duration,
              onSlideChanged: onSlideChanged
            ),
          ],
        ),
      ),
    );
  }

  void onSlideChanged(double val){
    videoController!.seekTo(
      Duration(
        seconds: val.toInt(),
      ),
    );
  }


  void onReversePressed() {
    //현재 어디가 실행중인지 알아야한다.
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); //0초

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    //이미 실행중이면 중지 아니면 실행
    setState(() {
      if (videoController!.value.isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
    });
  }

  void onForwardPressed() {
    //최대 실행위치(전체길이)
    final maxPosition = videoController!.value.duration;
//현재 어디가 실행중인지 알아야한다.
    final currentPosition = videoController!.value.position;

    Duration position = Duration(); //0초

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }
}

class _Controls extends StatelessWidget {
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _Controls(
      {required this.onPlayPressed,
      required this.onReversePressed,
      required this.onForwardPressed,
      required this.isPlaying,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      height: MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
              onPressed: onReversePressed, iconData: Icons.rotate_left),
          renderIconButton(
              onPressed: onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow),
          renderIconButton(
              onPressed: onForwardPressed, iconData: Icons.rotate_right),
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(iconData // 여기에 들어가는게 IconData임.
          ),
      color: Colors.white,
      iconSize: 30.0,
    );
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // 스택에서 자주사용하는 위젯 (위치지정)
      right: 0,
      child: IconButton(
        onPressed: onPressed,
        color: Colors.white,
        iconSize: 30.0,
        icon: Icon(Icons.photo_camera_back),
      ),
    );
  }
}

class _SliderBottom extends StatelessWidget {
  final Duration currentPosition;
  final Duration maxPosition;
  final ValueChanged<double> onSlideChanged;

  const _SliderBottom({required this.currentPosition, required this.maxPosition, required this.onSlideChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Text(
              '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                //최대 최소 길이정해줘야함.
                max: maxPosition.inSeconds.toDouble(),
                min: 0,
                value: currentPosition.inSeconds.toDouble(),
                onChanged: onSlideChanged,
              ),
            ),
            Text(
              '${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

