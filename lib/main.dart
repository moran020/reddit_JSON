import 'dart:convert';

import 'package:flutter/material.dart';
import 'posts.dart';
import 'detail_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/detail_page': (context) => const DetailPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> postsList;

  @override
  void initState() {
    super.initState();
    postsList = getPostsList();
  }

  Future refresh() async {
    postsList.then((listPosts) {
      for (var all in listPosts) {
        Future<List<Post>> newPostsList = getPostsList();
        newPostsList.then((newListPosts) {
          for (var n in newListPosts) {
            if (all.name == n.name) {
              if (all.title != n.title) {
                all.title == n.title;
              } else if (all.thumbnail != n.thumbnail) {
                all.thumbnail == n.thumbnail;
              } else if (all.ups != n.ups) {
                all.ups == n.ups;
              } else if (all.selftext != n.selftext) {
                all.selftext == n.selftext;
              }
            } else if (all.name != n.name) {
              do {
                listPosts.add(Post(
                    name: '', title: '', thumbnail: '', ups: 0, selftext: ''));
                for (int i = listPosts.length; i == 0; i--) {
                  listPosts[i] = listPosts[i--];
                }
                listPosts[0] = Post(
                    name: n.name,
                    title: n.title,
                    thumbnail: n.thumbnail,
                    ups: n.ups,
                    selftext: n.selftext);
              } while (all.name == n.name);
            }
          }
        });
      }
      return postsList;
    });
    postsList.then((value) => print('Длина списка 2: ${value.length}'));
    postsList.then((value) => print('Первый элемент 2: ${value.first.title}'));
    postsList
        .then((value) => print('Последний элемент 2: ${value.last.title}'));

    setState(() {
      postsList = this.postsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder<List<Post>>(
            future: postsList,
            builder: (context, snapshot) {
              postsList
                  .then((value) => print('Длина списка 1: ${value.length}'));
              postsList.then(
                  (value) => print('Первый элемент 1: ${value.first.title}'));
              postsList.then(
                  (value) => print('Последний элемент 1: ${value.last.title}'));

              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      // функция вывода изображения
                      getImage() {
                        if (snapshot.data![index].thumbnail == "self") {
                          return Container();
                        } else if (snapshot.data![index].thumbnail ==
                            "default") {
                          return Container();
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Image.network(
                              snapshot.data![index].thumbnail,
                              scale: 0.1,
                            ),
                          );
                        }
                      }

                      return GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/detail_page',
                              arguments: DataToDetailPage(
                                  title: snapshot.data![index].title,
                                  thumbnail: snapshot.data![index].thumbnail,
                                  selftext: snapshot.data![index].selftext,
                                  ups: snapshot.data![index].ups))
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.5,
                                    )),
                                Center(child: getImage()),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class DataToDetailPage {
  final String title;
  final String thumbnail;
  final int? ups;
  final String selftext;

  DataToDetailPage({
    required this.title,
    required this.thumbnail,
    required this.ups,
    required this.selftext,
  });
}


                    // // добавление полученных постов в отдельный map
                    // Map<String, dynamic> posts = {};
                    // posts.addAll({
                    //   '$index': { 
                    //     '${snapshot.data?.children[index].name}': {
                    //       'title': '${snapshot.data?.children[index].title}',
                    //       'thumbnail':
                    //           '${snapshot.data?.children[index].thumbnail}',
                    //       'selftext':
                    //           '${snapshot.data?.children[index].selftext}',
                    //       'ups': snapshot.data?.children[index].ups
                    //     }
                    //   }
                    // });
                    // print(posts);
                    // print('Длина: ${snapshot.data?.children.length}');
