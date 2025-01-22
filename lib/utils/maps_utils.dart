import 'dart:async';
import 'dart:ui' as ui;

import 'package:courier_app/api/model/task_map/buttons.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MarkerIconType {
  dispatch,
  delivery,
  dispatchOff,
  deliveryOff,
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class MapUtils {
  /// 计算多边形中心点
  static LatLng calculatePolygonCenter(List<LatLng> points) {
    double latitude = 0;
    double longitude = 0;

    for (var point in points) {
      latitude += point.latitude;
      longitude += point.longitude;
    }

    return LatLng(latitude / points.length, longitude / points.length);
  }

  /// widgetToImage
  static Future<ByteData> widgetToImage(
    Widget widget, {
    Alignment alignment = Alignment.center,
    Size size = const Size(double.maxFinite, double.maxFinite),
    double devicePixelRatio = 1.0,
    double pixelRatio = 1.0,
  }) async {
    RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    RenderView renderView = RenderView(
      child: RenderPositionedBox(alignment: alignment, child: repaintBoundary),
      configuration: ViewConfiguration(
        size: size,
        devicePixelRatio: devicePixelRatio,
      ),
      view: WidgetsBinding.instance.platformDispatcher.views.first,
    );

    PipelineOwner pipelineOwner = PipelineOwner();
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    RenderObjectToWidgetElement rootElement = RenderObjectToWidgetAdapter(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);
    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    ui.Image image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!;
  }

  /// 获取绘制当前多边形标记的图片  
  static Future<ByteData> getByteData(polygonName, devicePixelRatio) async {
    return await MapUtils.widgetToImage(Container(
      width: 40.0,
      height: 27.0,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(Res.map_dingwei), fit: BoxFit.fill),
      ),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Texts.smallBold(polygonName, color: Colours.cardColor),
              const SizedBox(height: 4.0,)
            ],
          )
        )
      ),
    ), size: const Size(40.0, 27.0), devicePixelRatio: devicePixelRatio, pixelRatio: devicePixelRatio);
  }

  /// 获取当前位置的图片
  static Future<ByteData> getCurrentPositionImg(devicePixelRatio) async {
    return await MapUtils.widgetToImage(const SizedBox(
      width: 30.0,
      height: 30.0,
      child: Image(image:AssetImage(Res.map_current_position),fit: BoxFit.fill),
    ), size: const Size(30.0, 30.0), devicePixelRatio: devicePixelRatio, pixelRatio: devicePixelRatio);
  }

  /// 获取标记的图标
  static Future<ByteData> getMarkerImg(MarkerIconType type, String name, devicePixelRatio) async {
    String icon = "";

    switch(type) {
      case MarkerIconType.dispatch:
        icon = Res.map_dispatch_icon;
        break;
      case MarkerIconType.delivery:
        icon = Res.map_delivery_icon;
        break;
      case MarkerIconType.dispatchOff:
        icon = Res.map_dispatch_icon;
        break;
      case MarkerIconType.deliveryOff:
        icon = Res.map_delivery_icon;
        break;
      default:
        icon = Res.map_dispatch_icon;
    }

    return await MapUtils.widgetToImage(Container(
      width: 34.0,
      height: 40.0,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(icon), fit: BoxFit.fill),
      ),
      child: Center(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Texts.smallBold(name, color: Colours.cardColor),
              const SizedBox(height: 5.0,)
            ],
          )
        )
      ),
    ), size: const Size(34.0, 40.0), devicePixelRatio: devicePixelRatio, pixelRatio: devicePixelRatio);
  }

  /// Add more images to preload as needed
  static void preloadImages(BuildContext context) {
    precacheImage(const AssetImage(Res.map_dingwei), context);
    precacheImage(const AssetImage(Res.map_dingwei_off), context);
    precacheImage(const AssetImage(Res.map_current_position), context);
    precacheImage(const AssetImage(Res.map_dispatch_icon), context);
    precacheImage(const AssetImage(Res.map_delivery_icon), context);
  }

  static bool checkOverlap(List<Polygon> polygons, String polygon1, String polygon2) {
    final p1 = polygons.firstWhere((element) => element.polygonId.value == polygon1);
    final p2 = polygons.firstWhere((element) => element.polygonId.value == polygon2);


    if (_isPolygonOverlap(p1, p2) || _isPolygonOverlap(p2, p1)) {
      return true;
    } else {
      return false;
    }
  }

  static bool _isPolygonOverlap(Polygon polygon1, Polygon polygon2) {
    for (LatLng point in polygon1.points) {
      if (isPointInsidePolygon(point, polygon2.points)) {
        return true;
      }
    }
    return false;
  }

  /// 判断点是否在多边形内
  static bool isPointInsidePolygon(LatLng point, List<LatLng> polygon) {
    int crossings = 0;

    for (int i = 0; i < polygon.length; i++) {
      LatLng vertex1 = polygon[i];
      LatLng vertex2 = polygon[(i + 1) % polygon.length];

      if (vertex1.longitude <= point.longitude && vertex2.longitude > point.longitude ||
          vertex2.longitude <= point.longitude && vertex1.longitude > point.longitude) {
        double edgeTest = (point.longitude - vertex1.longitude) / (vertex2.longitude - vertex1.longitude);

        if (point.latitude < vertex1.latitude + edgeTest * (vertex2.latitude - vertex1.latitude)) {
          crossings++;
        }
      }
    }

    return crossings % 2 != 0;
  }

  /// 计算当前多边形中的点的集合
  static List<MockTaskItem> getPolygonPoints(List<MockTaskItem> taskItem, List<LatLng> polygonPoints) {
    List<MockTaskItem> result = [];

    for (MockTaskItem item in taskItem) {
      final point = LatLng(item.latitude, item.longitude);
      if (isPointInsidePolygon(point, polygonPoints)) {
        result.add(item);
      }
    }

    return result;
  }

  /// 判断是否有圈内的点
  static bool isDotInOldCircle(Map<String, List<MockTaskItem>> circleCollect, List<LatLng> polygonPoints) {
    for (var entry in circleCollect.entries) {
      final List<MockTaskItem> taskItems = entry.value;
      for (MockTaskItem item in taskItems) {
        final point = LatLng(item.latitude, item.longitude);
        if (isPointInsidePolygon(point, polygonPoints)) {
          return true;
        }
      }
    }
    
    return false;
  }

  /// 获取当前位置
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    return position;
  }
}