import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/blocs/favorite_bloc.dart';
import 'package:flutter_tube/models/video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import '../api_key.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    return GestureDetector(
      onTap: () {
        FlutterYoutube.playYoutubeVideoById(
          apiKey: API_KEY,
          videoId: video.id,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  initialData: {},
                  stream: bloc.outFav,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border,
                        ),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          bloc.toggleFavorite(video);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
