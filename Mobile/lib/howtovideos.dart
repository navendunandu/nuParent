import 'package:flutter/material.dart';
import 'package:nu_parent/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

class HowToVideos extends StatelessWidget {
  const HowToVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Screen'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoPlayerWidget(
                  videoUrl: videos[index]['videoUrl'],
                  videoTitle: videos[index]['videoTitle'],
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchVideos() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('uploadVideo').get();

    return snapshot.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
      return doc.data()!;
    }).toList();
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;

  VideoPlayerWidget({required this.videoUrl, required this.videoTitle});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.videoTitle),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
