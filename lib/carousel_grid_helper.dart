class CarouselGridHelper {
  CarouselGridHelper._privateConstructor();
  static final CarouselGridHelper _instance =
      CarouselGridHelper._privateConstructor();
  factory CarouselGridHelper() => _instance;

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

  countSlider2(data) {
    double slider = data.length / 4 + 0.45;
    var rounded = (slider.round());
    return rounded;
  }

  countGridview2(data, indexSlider) {
    return data.sublist(4 * indexSlider).length;
  }

  getDataGrid2(data, indexSlider, indexItem) {
    return data.sublist(4 * indexSlider)[indexItem];
  }

  countSlider3(data) {
    double slider = data.length / 3 + 0.45;
    var rounded = (slider.round());
    return rounded;
  }

  countGridview3(data, indexSlider) {
    return data.sublist(3 * indexSlider).length;
  }

  getDataGrid3(data, indexSlider, indexItem) {
    return data.sublist(3 * indexSlider)[indexItem];
  }

  tryCount(
    Count type, {
    int? sliderIndex,
    required Length rows,
    required List<dynamic> data,
  }) {
    late int items;
    if (rows == Length.four) items = 4;
    if (rows == Length.eight) items = 8;
    double slider = data.length / items + 0.45;
    final rounded = (slider.round());
    if (type == Count.slider) return rounded;
    if (type == Count.grid) return data.sublist(items * sliderIndex!).length;
  }

  dynamic gridData({
    required List<dynamic> data,
    required int sliderIndex,
    required int indexItem,
  }) =>
      data.sublist(4 * sliderIndex)[indexItem];
}

enum Count { slider, grid }
enum Length { four, eight }
