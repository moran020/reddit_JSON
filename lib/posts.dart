import 'dart:convert';
import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
part 'posts.g.dart';

// @JsonSerializable()
// class PostsList {
//   List<Post> children;
//   PostsList({required this.children});

//   factory PostsList.fromJson(Map<String, dynamic> json) =>
//       _$PostsListFromJson(json);
// }

// @JsonSerializable()
class Post {
  final String name;
  final String title;
  final String thumbnail;
  final int ups;
  final String selftext;

  Post(
      {required this.name,
      required this.title,
      required this.thumbnail,
      required this.ups,
      required this.selftext});

  // factory Post.fromJson(Map<String, dynamic> json) => Post(
  //       name: json['data']['children']['data']['name'] as String,
  //       title: json['data']['children']['data']['title'] as String,
  //       thumbnail: json['data']['children']['data']['thumbnail'] as String,
  //       ups: json['data']['children']['data']['ups'] as int,
  //       selftext: json['data']['children']['data']['selftext'] as String,
  //     );

}

// Future<PostsList> getPostsList() async {
//   const url = 'https://reddit.com/r/flutterdev/new.json';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return PostsList.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }

Future<List<Post>> getPostsList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<Post> posts = [];
    for (var i in jsonResponse['data']['children']) {
      Post post = Post(
          name: i['data']['name'],
          title: i['data']['title'],
          thumbnail: i['data']['thumbnail'],
          ups: i['data']['ups'],
          selftext: i['data']['selftext']);
      posts.add(post);
      // for (var n in posts) {
      //   print('${n.title} - ${n.name}');
      // }
    }
    // print(posts[1].title);
    return posts;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}

// Future<List<Post>> getNewPostsList() async {
//   const url = 'https://reddit.com/r/flutterdev/new.json';
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     List<Post> newPosts = [];
//     for (var i in jsonResponse['data']['children']) {
//       Post post = Post(
//           name: i['data']['name'],
//           title: i['data']['title'],
//           thumbnail: i['data']['thumbnail'],
//           ups: i['data']['ups'],
//           selftext: i['data']['selftext']);
//       newPosts.add(post);
//     }
//     return newPosts;
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }


      // Map<String, dynamic> postsMap = {};
      // for (var e in posts) {



      // // print(posts[1].title);

      // // Map<String, dynamic> toMap() {
      // //   return {
      // //     'name': post.name,
      // //     'title': post.title,
      // //     'thumbnail': post.thumbnail,
      // //     'ups': post.ups,
      // //     'selftext': post.selftext,
      // //   };
      // // }

      // toMap() {
      //   for (var e in posts) {
      //     return {
      //       'name': e.name,
      //       'title': e.title,
      //       'thumbnail': e.thumbnail,
      //       'ups': e.ups,
      //       'selftext': e.selftext,
      //     };
      //   }
      // }


      // Map map = posts.asMap();
      // print(map.keys);


      // Map<String, dynamic> toMap() {
      //   return {
      //     'name': post.name,
      //     'title': post.title,
      //     'thumbnail': post.thumbnail,
      //     'ups': post.ups,
      //     'selftext': post.selftext,
      //   };
      // }