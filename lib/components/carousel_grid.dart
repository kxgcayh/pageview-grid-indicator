import 'package:flutter/material.dart';
import 'package:pageview_grid_indicator/carousel_grid_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselGrid extends StatefulWidget {
  const CarouselGrid({
    Key? key,
    required this.data,
    required this.height,
    this.backgroundDecoration,
    this.onPageChanged,
    this.pageItemBuilder,
  }) : super(key: key);

  final double height;
  final ValueChanged<int>? onPageChanged;
  final List<dynamic> data;
  final Decoration? backgroundDecoration;
  final IndexedWidgetBuilder? pageItemBuilder;

  @override
  State<CarouselGrid> createState() => _CarouselGridState();
}

class _CarouselGridState extends State<CarouselGrid> {
  int defaultIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: widget.backgroundDecoration ??
              BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.2),
              ),
          height: widget.height,
          child: PageView.builder(
            allowImplicitScrolling: true,
            pageSnapping: false,
            onPageChanged:
                widget.onPageChanged ?? (value) => _defaultPageChanged(value),
            itemCount: CarouselGridHelper().tryCount(
              Count.slider,
              rows: Length.eight,
              data: widget.data,
            ),
            itemBuilder: widget.pageItemBuilder ??
                (context, pageIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: GridView.builder(
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      addSemanticIndexes: false,
                      cacheExtent: 0.0,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        // mainAxisExtent: 110,
                      ),
                      itemCount: countGridData(widget.data, pageIndex),
                      itemBuilder: (context, gridIndex) {
                        final gridData = CarouselGridHelper().gridData(
                          data: widget.data,
                          sliderIndex: pageIndex,
                          indexItem: gridIndex,
                        );
                        return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(gridData),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: defaultIndex,
            count: countIndicator(widget.data),
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotColor: Colors.grey,
              spacing: 16,
              radius: 20,
              activeDotColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  void _defaultPageChanged(int value) {
    setState(() => defaultIndex = value);
  }
}

countIndicator(List<dynamic> data) {
  return CarouselGridHelper().tryCount(
    Count.slider,
    rows: Length.eight,
    data: data,
  );
}

countGridData(List<dynamic> data, int pageIndex) {
  return CarouselGridHelper().tryCount(
    Count.grid,
    rows: Length.eight,
    data: data,
    sliderIndex: pageIndex,
  );
}
