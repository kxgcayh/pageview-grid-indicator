// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pageview_grid_indicator/carousel_grid_helper.dart';
import 'package:pageview_grid_indicator/components/carousel_grid.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: true,
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Home 2',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CarouselGridIndicator(title: 'HOME 1');
          case 1:
            return CarouselGridIndicator(title: 'HOME 2');
          default:
            return CarouselGridIndicator(title: 'PRIMARY');
        }
      },
    );
  }
}

class CarouselGridIndicator extends StatefulWidget {
  const CarouselGridIndicator({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<CarouselGridIndicator> createState() => _CarouselGridIndicatorState();
}

class _CarouselGridIndicatorState extends State<CarouselGridIndicator> {
  int _croppedCarouselGridIdx = 0;
  int _uncroppedCarouselIdx = 0;
  final stringList = List<String>.generate(10, (index) => 'STRING-${index}');

  countSlider(data) {
    double slider = data.length / 8 + 0.45;
    var rounded = (slider.round());
    return rounded;
  }

  countGridview(data, indexSlider) {
    return data.sublist(8 * indexSlider).length;
  }

  getDataGrid(data, indexSlider, indexItem) {
    return data.sublist(8 * indexSlider)[indexItem];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CarouselGrid(
              data: stringList,
              height: 320,
              pageItemBuilder: (context, pageIndex) {
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
                    itemCount: CarouselGridHelper().tryCount(
                      Count.grid,
                      rows: Length.eight,
                      data: stringList,
                      sliderIndex: pageIndex,
                    ),
                    itemBuilder: (context, gridIndex) {
                      final gridData = CarouselGridHelper().gridData(
                        data: stringList,
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
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Text('Data Grid Sebenarnya'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  height: 320,
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    pageSnapping: false,
                    onPageChanged: (i) {
                      setState(() => _uncroppedCarouselIdx = i);
                    },
                    itemCount: CarouselGridHelper().tryCount(
                      Count.slider,
                      rows: Length.eight,
                      data: stringList,
                    ),
                    itemBuilder: (context, int _pageIndex) {
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
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // mainAxisExtent: 110,
                          ),
                          itemCount: CarouselGridHelper().tryCount(
                            Count.grid,
                            rows: Length.eight,
                            data: stringList,
                            sliderIndex: _pageIndex,
                          ),
                          itemBuilder: (context, int _gridIndex) {
                            final _data = getDataGrid(
                              stringList,
                              _pageIndex,
                              _gridIndex,
                            );
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(_data),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 6),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: _uncroppedCarouselIdx,
                    count: countSlider(stringList),
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
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Text('Data Grid yang dipotong'),
                ),
                Container(
                  height: 212,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.withOpacity(0.2),
                  ),
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    pageSnapping: false,
                    onPageChanged: (i) {
                      setState(() => _croppedCarouselGridIdx = i);
                    },
                    itemBuilder: (context, int _pageIndex) {
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
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            // mainAxisExtent: 110,
                          ),
                          itemCount: countGridview(
                            stringList,
                            _pageIndex,
                          ),
                          itemBuilder: (context, int _gridIndex) {
                            final _data = getDataGrid(
                              stringList,
                              _pageIndex,
                              _gridIndex,
                            );
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
                                ),
                                child: Text(_data),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    itemCount: countSlider(stringList),
                  ),
                ),
                SizedBox(height: 6),
                Center(
                  child: AnimatedSmoothIndicator(
                    activeIndex: _croppedCarouselGridIdx,
                    count: countSlider(stringList),
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
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class Spacer extends StatelessWidget {
  const Spacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(child: Text('Hanya Syarat agar bisa Scroll')),
      ),
    );
  }
}
