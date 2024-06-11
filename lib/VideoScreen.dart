import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String searchQuery;

  VideoScreen({required this.searchQuery});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String apiKey = "AIzaSyBFfGQjefDdDQ-GYOKIU72PRZ97pQdPgT0"; // Replace with your API key
  late YoutubeAPI ytApi;
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    ytApi = YoutubeAPI(apiKey);
    searchQuery = widget.searchQuery;
  }

  Future<List<YT_API>> fetchVideos(String searchQuery) async {
    try {
      var query = await ytApi.search(searchQuery);
      return query;
    } catch (e) {
      print("Error fetching videos: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Related YouTube Videos"),
          backgroundColor: Color(0xFFA063EF),
        ),
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background-classi.jpg'), // Path to your background image
                  fit: BoxFit.cover, // Adjust as needed
                ),
              ),
            ),
            // Content
            FutureBuilder<List<YT_API>>(
              future: fetchVideos(searchQuery),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No videos found."));
                } else {
                  final videos = snapshot.data!;
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos.elementAt(index);
                      return ListTile(
                        title: Text(video.title,
                          style: TextStyle(
                          color: Colors.white,)
                        ),

                        subtitle: Text(video.channelTitle,
                            style: TextStyle(
                              color: Colors.white,)
                        ),
                        leading: Image.network(video.thumbnail?['high']['url']),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                              videoId: video.id ?? "default_video_id",
                              apiKey: apiKey,
                            ),
                          ));
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoId;
  final String apiKey;

  VideoPlayerScreen({required this.videoId, required this.apiKey});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Video Player"),
          backgroundColor: Color(0xFFA063EF),
        ),
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background-classi.jpg'), // Path to your background image
                  fit: BoxFit.cover, // Adjust as needed
                ),
              ),
            ),
            // YoutubePlayer widget
            Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
