import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:videocallchat/const/agora.dart';

// 화면에 띄우기위해 import
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class CamScreen extends StatefulWidget {
  const CamScreen({Key? key}) : super(key: key);

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  //아고라 api를 쓰기 위한 설정
  // RtcEngine은 아고라 api를 쓸 때 컨트롤러처럼 쓰는 것!
  RtcEngine? engine;
  int? uid;
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          //권한이 없는 상태일때
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          //에러가 없는데 데이터가 없는 경우 --> 처음실행했을때!!
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (engine != null) {
                      await engine!.leaveChannel();
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('채널 나가기'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget renderSubView() {
    if (otherUid == null) {
      return Center(
        child: Text('채널에 유저가 없습니다.'),
      );
    } else {
      return RtcRemoteView.SurfaceView(
        uid: otherUid!,
        channelId: CHANNEL_NAME,
      );
    }
  }

  Widget renderMainView() {
    //아무채널에도 들어가있지 않은 상황
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요'),
      );
    } else {
      return RtcLocalView.SurfaceView();
    }
  }

  //권한을 받아서 비디오 화면을 띄우기 위한 준비-->권한요청
  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    //맵처럼 가져올 수 있다.
    final camerPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (camerPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      //카메라랑 마이크의 권한이 없는 상태라면!
      throw '카메라 또는 마이크 권한이 없습니다';
    }
    //RtcEngine이 null일때만 생성되도록 설정
    if (engine == null) {
      //RtcEngineContext를 정의해서 아고라에서 설정한 APP_ID를 가져온다.
      RtcEngineContext context = RtcEngineContext(APP_ID);
      //RtcEngineContext를 정의하면 RtcEngine을 만들수 있다.
      engine = await RtcEngine.createWithContext(context);

      //비디오 활성화
      await engine!.enableAudio();

      //setEventHandler를 이용해서 joinChannel 시에 콜백함수를 지정한다.
      // stream과 같은 기능! 특정기능이 수행됐을때 특정함수들을실행!
      engine!.setEventHandler(
        RtcEngineEventHandler(
          //join해서 성공적으로 들어갔을 경우! (3개 파라미터: 채널,uid(아고라에서 지정된 id))
          joinChannelSuccess: (channel, uid, elapsed) {
            print('채널에 입장했습니다. uid : $uid');
            //uid를 지정해줌 --> 내 핸드폰이 채널에 참여했을때 실행이 되는 부분이다.
            setState(() {
              this.uid = uid;
            });
          },
          //내가 나갔을때 --> uid를 잃어야하니까 null지정해주기
          leaveChannel: (stats) {
            print('채널 퇴장');
            setState(() {
              uid = null;
            });
          },
          //반대로 상대가 조인을 했을 때 실행되는 부분
          userJoined: (int uid, int elapsed) {
            print('상대가 채널에 입장했습니다');
            setState(() {
              otherUid = uid;
            });
          },
          //상대가 나갔을때 --> UserOfflineReason은 유저가 나가게된 이유
          userOffline: (uid, UserOfflineReason reason) {
            //dropped는 자기가나간거 quit는 나가진거
            print('상대가 채널에서 나갔습니다 uid: $uid');
            setState(() {
              otherUid = null;
            });
          },
        ),
      );

      //채널에 들어가기
      await engine!.joinChannel(
        TEMP_TOKEN,
        CHANNEL_NAME,
        null,
        //      //optionalUid에는 int 값을 넣어주면 되고 절대 중복이 있으면 안된다.
        //      //0으로 지정하면 아고라에서 자동으로 중복이 없는 값들로 id를 지정해준다.
        //      //그러면 id 값을 콜백함수로 id를 받아야한다.(특정이벤트가 실행이 됐을때)
        0,
      );
    }

    return true;
  }
}
