import 'package:flutter/material.dart';
import 'main.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DataToDetailPage;

    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromRGBO(235, 235, 235, 1),
          body: SingleChildScrollView(
            child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 40,
                    child: Column(children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Image.asset('assets/image/arrow_up.png',
                            height: 30),
                      ),
                      Text(
                        args.ups.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Image.asset('assets/image/arrow_down.png',
                            height: 30),
                      ),
                    ]),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 15),
                      child: Column(
                        children: [
                          Text(
                            args.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            args.selftext,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
          //     Column(children: [
          //   Text(args.title),
          //   Text(args.ups.toString()),
          // ])
          ),
    );
  }
}
