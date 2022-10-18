import 'package:cached_network/cached_network.dart' as cache;
import 'package:flutter/material.dart';

class CachedView extends StatelessWidget {
  const CachedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const cache.CacheView();
  }
}
