import 'package:flutter/material.dart';
import '../helpers/get_posts_list.dart';
import '../helpers/data_to_detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> postsList;
  late Future<List<Post>> updatePostsList;

  @override
  void initState() {
    super.initState();
    // загрузка списка постов
    postsList = getPostsList();
  }

  // функция обновления страницы (без сохранения старых данных)
  Future refresh() async {
    updatePostsList = getPostsList();
    setState(() {
      postsList = updatePostsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('FlutterDev'),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: FutureBuilder<List<Post>>(
            future: postsList,
            builder: (context, snapshot) {
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
                          // передача данных на следующий экран
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
