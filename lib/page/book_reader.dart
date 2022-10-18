import 'package:book_reader/book_reader.dart';
import 'package:flutter/material.dart';

class BookReaderDemo extends StatefulWidget {
  const BookReaderDemo({super.key});

  @override
  State<BookReaderDemo> createState() => _BookReaderDemoState();
}

class _BookReaderDemoState extends State<BookReaderDemo> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return BookReader(
      author: '作者',
      cover: Image.network(
        'https://images-cn.ssl-images-amazon.cn/images/I/51k6CY+4PUL._SY346_.jpg',
        height: 64,
      ),
      future: fetchChapter,
      name: '测试书籍',
      title: '第${current + 1}章',
      total: 50,
      onCatalogueNavigated: showCatalogue,
      onChapterChanged: (index) => setState(() => current = index),
    );
  }

  Future<String> fetchChapter(int index) async {
    var paragrah = List.generate(5, (i) => '这是第${index + 1}章的内容。').join('');
    var content = List.generate(50, (i) => paragrah).join('\n');
    return Future.value(content);
  }

  void showCatalogue() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CataloguePage(),
    ));
  }
}

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort_outlined),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text('第${index + 1}章'),
        ),
        itemCount: 50,
      ),
    );
  }
}
