import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/video.dart';
import 'api_key.dart';

class Api {
  search(String search) async {
    var url = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'part': 'snippet',
      'q': '$search',
      'type': 'video',
      'key': '$API_KEY',
      'maxResults': '10'
    });

    http.Response response = await http.get(url);
    decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      List<Video> videos = decoded['items'].map<Video>((video) {
        return Video.fromJson(video);
      }).toList();
      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
