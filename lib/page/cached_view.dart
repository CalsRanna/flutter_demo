import 'package:cached_network/cached_network.dart';
import 'package:flutter/material.dart';

class CachedView extends StatefulWidget {
  const CachedView({super.key});
  @override
  State<CachedView> createState() {
    return _CachedViewState();
  }
}

class _CachedViewState extends State<CachedView> {
  String? cachedContent;
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.download_for_offline_outlined),
            onPressed: navigate,
          )
        ],
        title: const Text('Cached Network'),
      ),
      body: Center(child: Builder(builder: (context) {
        if (loading) {
          return const CircularProgressIndicator();
        } else {
          if (error != null) {
            return SingleChildScrollView(child: Text(error!));
          } else {
            return SingleChildScrollView(child: Text(cachedContent ?? '暂无内容'));
          }
        }
      })),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => fetch(reacquire: true),
        child: const Icon(Icons.refresh_outlined),
      ),
    );
  }

  void navigate() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CacheView()),
    );
  }

  void fetch({bool reacquire = false}) async {
    try {
      setState(() {
        loading = true;
      });
      var content = await CachedNetwork().request(
        'https://flutter.dev',
        reacquire: reacquire,
      );
      setState(() {
        cachedContent = content;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }
}
