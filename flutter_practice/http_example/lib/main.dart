import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//309a98e741da0adad6f469369cd6497a

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent &&
      !_scrollController!.position.outOfRange){
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: '검색어를 입력하세요',
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: data!.length == 0
              ? Text(
                  '데이터가 없습니다.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, int index) {
                    return Card(
                      child: Container(
                        child: Row(
                          children: [
                            Image.network(
                              data![index]['thumbnail'],
                              height: 100,
                              width: 100,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Text(
                                    data![index]['title'],
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text('저자 : ${data![index]['authors']}'),
                                Text('가격 : ${data![index]['sale_price']}'),
                                Text('판매 : ${data![index]['status']}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: data!.length,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          page=1;
          data!.clear();
          getJSONData();
        },
        child: Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    String url =
        'https://dapi.kakao.com/v3/search/book?target=title&page=${page}&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK 309a98e741da0adad6f469369cd6497a"});

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      print(result[0]['status']);
      data!.addAll(result);
    });
    return response.body;
  }
}
