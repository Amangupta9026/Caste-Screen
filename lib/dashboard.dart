import 'package:cast_demo/casting_video.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayerPage extends StatefulWidget {
  @override
  _MyVideoPlayerPageState createState() => _MyVideoPlayerPageState();
}

class _MyVideoPlayerPageState extends State<MyVideoPlayerPage> {
  VideoPlayerController? videoPlayerController;
  Future<void>? videoPlayerFuture;
  VideoPlayerController? videoPlayerController2;
  Future<void>? videoPlayerFuture2;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4');
    videoPlayerFuture = videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);

    videoPlayerController2 = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    videoPlayerFuture2 = videoPlayerController2!.initialize();
    videoPlayerController2!.setLooping(true);
  }

  //http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                FutureBuilder(
                  future: videoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController!),
                      );
                    } else {
                      return const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              videoPlayerController!.value.isPlaying
                                  ? videoPlayerController!.pause()
                                  : videoPlayerController!.play();
                            });
                          },
                          child: Icon(
                            videoPlayerController!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: const Icon(
                            Icons.cast,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),

            // For Second Video

            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                FutureBuilder(
                  future: videoPlayerFuture2,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: videoPlayerController2!.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController2!),
                      );
                    } else {
                      return const SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
                Container(
                  color: Colors.black.withOpacity(0.2),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              videoPlayerController2!.value.isPlaying
                                  ? videoPlayerController2!.pause()
                                  : videoPlayerController2!.play();
                            });
                          },
                          child: Icon(
                            videoPlayerController2!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage()));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: const Icon(
                            Icons.cast,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }
}
