import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class PlatformRefreshIndicator extends StatelessWidget {
  final int count;
  final Future<void> Function() onRefresh;
  final IndexedWidgetBuilder itemBuilder;

  const PlatformRefreshIndicator({
    super.key,
    required this.count,
    required this.onRefresh,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final Widget column = Column(
      children: List.generate(
        count,
            (index) => itemBuilder(context, index),
      ),
    );

    return Platform.isIOS
        ? CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: onRefresh),
        SliverToBoxAdapter(child: column),
      ],
    )
        : RefreshIndicator(
      onRefresh: onRefresh,
      child: column,
    );
  }
}






