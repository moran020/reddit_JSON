import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String title;
  final String thumbnail;
  final int ups;
  final String selftext;

  Post(
      {required this.title,
      required this.thumbnail,
      required this.ups,
      required this.selftext});
}

Future<List<Post>> getPostsList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<Post> posts = [];
    for (var i in jsonResponse['data']['children']) {
      Post post = Post(
          title: i['data']['title'],
          thumbnail: i['data']['thumbnail'],
          ups: i['data']['ups'],
          selftext: i['data']['selftext']);
      posts.add(post);
    }
    return posts;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
