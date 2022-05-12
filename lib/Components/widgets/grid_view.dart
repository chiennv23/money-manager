import 'package:flutter/material.dart';

class WGridView extends StatefulWidget {
  final List<Widget> list;
  final int col;
  final bool carousel;
  final bool isPhysics;
  final double height;
  final double ratio;
  final EdgeInsets padding;

  WGridView(
      {this.list,
      this.col = 1,
      this.height,
      this.ratio,
      this.carousel = false,
      this.isPhysics = true,
      this.padding = const EdgeInsets.only(bottom: 1, top: 5)});

  @override
  _WGridViewState createState() => _WGridViewState();
}

class _WGridViewState extends State<WGridView> {
  final GlobalKey key = GlobalKey();
  double height;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = key.currentContext.findRenderObject();
      if (height == null) {
        setState(() {
          height = renderBox.size.height;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - (widget.col + 1) * 16) *
        (0.9 / widget.col);
    return Container(
      height: widget.height,
      key: key,
      child: GridView.builder(
        cacheExtent: 150,
        padding: widget.padding,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.carousel ? 1 : widget.col,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: widget.carousel
              ? (widget.height ?? height ?? width) / width
              : widget.ratio,
        ),
        physics: widget.isPhysics
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),
        scrollDirection: widget.carousel ? Axis.horizontal : Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (context, index) => Container(
          alignment: Alignment.center,
          child: widget.list[index],
          width: widget.carousel ? width : null,
        ),
      ),
    );
  }
}
