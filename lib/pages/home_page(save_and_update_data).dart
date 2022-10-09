// import 'package:flutter/material.dart';
// import '../helpers/get_posts_list.dart';
// import '../helpers/get_title_list.dart';
// import '../helpers/get_thumbnail_list.dart';
// import '../helpers/get_ups_list.dart';
// import '../helpers/get_selftext_list.dart';
// import '../helpers/data_to_detail_page.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late Future<List<Post>> postsList;
//   late Future<List<Post>> updatePostsList;
//   late Future<List<String>> titleList;
//   late Future<List<String>> thumbnailList;
//   late Future<List<int>> upsList;
//   late Future<List<String>> selftextList;

//   @override
//   void initState() {
//     super.initState();
//     postsList = getPostsList();
//     titleList = getTitleList();
//     thumbnailList = getThumbnailList();
//     upsList = getUpsList();
//     selftextList = getSelftextList();
//   }

//   // функция обновления страницы
//   Future refresh() async {
//     compareTitlesFromLists();
//     setState(() {
//       postsList = updatePostsList;
//     });
//   }
//   
//   // сравнение заголовков и обновление списка
//   Future compareTitlesFromLists() async {
//     // старый список постов
//     titleList.then((title) {
//       Future<List<String>> newTitleList = getTitleList();
//       for (var n in title) {
//         // новый список постов
//         newTitleList.then((newTitleList) {
//           for (var m in newTitleList) {
//             // если title из нового списка присутствует в старом списке, то
//             if (title.contains(m)) {
//               if (n == m) {
//                 // обновление списка с изображениями
//                 thumbnailList.then((thumbnailList) {
//                   Future<List<String>> newThumbnailList = getThumbnailList();
//                   for (var a in thumbnailList) {
//                     newThumbnailList.then((newthumbnailList) {
//                       for (var b in newthumbnailList) {
//                         if (a != b) {
//                           a == b;
//                         }
//                       }
//                     });
//                   }
//                   return thumbnailList;
//                 });
//                 // обновление списка с плюсами
//                 upsList.then((upsList) {
//                   Future<List<int>> newUpsList = getUpsList();
//                   for (var a in upsList) {
//                     newUpsList.then((newupsList) {
//                       for (var b in newupsList) {
//                         if (a != b) {
//                           a == b;
//                         }
//                       }
//                     });
//                   }
//                   return upsList;
//                 });
//                 // обновление списка с описанием
//                 selftextList.then((selftextList) {
//                   Future<List<String>> newSelftextList = getSelftextList();
//                   for (var a in selftextList) {
//                     newSelftextList.then((newselftextList) {
//                       for (var b in newselftextList) {
//                         if (a != b) {
//                           a == b;
//                         }
//                       }
//                     });
//                   }
//                   return selftextList;
//                 });
//               }
//               // TODO: добавить данные titleList[index], thumbnailList[index], upsList[index], selftextList[index] в класс Post, а затем элементы Post в Future<List<Post>> updatePostsList
//               return updatePostsList;
//             }
//             // если в новом списке появился title, которого не было в старом, то
//             else {
//               // пока новый список title не будет полностью соответствовать старому списку title, выполняется цикл
//               do {
//                 // обновление списка с заголовками (создание пустого элемента в конце списка, копирование элементов с конца с шагом назад)
//                 titleList.then((titleList) {
//                   titleList.add('');
//                   for (int i = titleList.length; i == 0; i--) {
//                     titleList[i] = titleList[i--];
//                   }
//                   // добавление нового title в начало списка
//                   titleList[0] = newTitleList.first;
//                   return titleList;
//                 });
//                 // обновление списка с изображениями
//                 thumbnailList.then((thumbnailList) {
//                   thumbnailList.add('');
//                   for (int i = thumbnailList.length; i == 0; i--) {
//                     thumbnailList[i] = thumbnailList[i--];
//                   }
//                   thumbnailList[0] = newThumbnailList.first;
//                   return thumbnailList;
//                 });
//                 // обновление списка с плюсами
//                 upsList.then((upsList) {
//                   upsList.add(0);
//                   for (int i = upsList.length; i == 0; i--) {
//                     upsList[i] = upsList[i--];
//                   }
//                   upslList[0] = newUpsList.first;
//                   return upsList;
//                 });
//                 // обновление списка с описанием
//                 selftextList.then((selftextList) {
//                   selftextList.add('');
//                   for (int i = selftextList.length; i == 0; i--) {
//                     selftextList[i] = selftextList[i--];
//                   }
//                   selftextList[0] = newSelftextList.first;
//                   return selftextList;
//                 });

//                 // TODO: добавить данные из списков titleList[index], thumbnailList[index], upsList[index], selftextList[index] в класс Post, а затем элементы Post в Future<List<Post>> updatePostsList

//               } while (n == m);

//               return updatePostsList;
//             }
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
//         body: RefreshIndicator(
//           onRefresh: refresh,
//           child: FutureBuilder<List<Post>>(
//             future: postsList,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return ListView.builder(
//                     itemCount: snapshot.data?.length,
//                     itemBuilder: (context, index) {
//                       // функция вывода изображения
//                       getImage() {
//                         if (snapshot.data![index].thumbnail == "self") {
//                           return Container();
//                         } else if (snapshot.data![index].thumbnail ==
//                             "default") {
//                           return Container();
//                         } else {
//                           return Container(
//                             margin: const EdgeInsets.only(top: 8),
//                             child: Image.network(
//                               snapshot.data![index].thumbnail,
//                               scale: 0.1,
//                             ),
//                           );
//                         }
//                       }

//                       return GestureDetector(
//                         onTap: () => {
//                           // передача данных на следующий экран
//                           Navigator.pushNamed(context, '/detail_page',
//                               arguments: DataToDetailPage(
//                                   title: snapshot.data![index].title,
//                                   thumbnail: snapshot.data![index].thumbnail,
//                                   selftext: snapshot.data![index].selftext,
//                                   ups: snapshot.data![index].ups))
//                         },
//                         child: Card(
//                           margin: const EdgeInsets.symmetric(
//                               vertical: 8, horizontal: 16),
//                           child: Padding(
//                             padding: const EdgeInsets.all(10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(snapshot.data![index].title,
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                       letterSpacing: 0.5,
//                                     )),
//                                 Center(child: getImage()),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     });
//               } else if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               }
//               return const Center(child: CircularProgressIndicator());
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
