import 'package:courier_app/api/model/task_map/buttons.dart';
import 'package:courier_app/features/task_map/mock.dart';
import 'package:courier_app/features/task_map/providers/task_map_provider.dart';
import 'package:courier_app/features/task_map/widgets/area_sort.dart';
import 'package:courier_app/features/task_map/widgets/handle_buttons.dart';
import 'package:courier_app/features/task_map/widgets/header_search.dart';
import 'package:courier_app/features/task_map/widgets/status_buttons.dart';
import 'package:courier_app/features/task_map/widgets/summary_count.dart';
import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/utils/dialog_utils.dart';
import 'package:courier_app/utils/maps_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as tools;

class TaskMapPage extends ConsumerStatefulWidget {
  const TaskMapPage({super.key});

  @override
  ConsumerState<TaskMapPage> createState() => TaskMapPageState();
}

class TaskMapPageState extends ConsumerState<TaskMapPage> {
  GoogleMapController? _controller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-26.20818660603836, 28.05702258995325),
    zoom: 10,
  );

  // 缓存地图上绘制的坐标
  List<LatLng> _touchList = [];

  // 多边线
  Polyline? _polyline;

  // 多边形;
  Polygon? _polygon;

  String _polygonName = '';

  final List<Polyline> _polylineArr = [];

  final List<Polygon> _polygonArr = [];

  // 标记
  final List<Marker> _markers = [];

  // 已圈画的集合 eg: {G1: MockTaskItem}
  final Map<String, List<MockTaskItem>> circleCollect = {};

  bool currentPositionIsReady = false;

  @override
  Widget build(BuildContext context) {
    bool buttonsVisible = ref.watch(mapButtonsVisbleProvider);

    final positionOnStatus = ref.watch(mapPositionStatusProvider);

    // 是否拦截地图上的手势 当地图状态等于draw
    bool isBlock = ref.watch(mapStatusProvider) == MapStatusEnum.draw;

    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // 预加载背景图片
    MapUtils.preloadImages(context);

    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Listener(
              onPointerDown: (pointEvent) async {
                if (!isBlock || _controller == null) return;
                // 手指按下回调
                debugPrint('onPointerDown: $pointEvent');

                // 清理之前的多边形
                _polygon = null;

                // 屏幕坐标转换为经纬度
                final latLan = await _controller!.getLatLng(
                  ScreenCoordinate(
                    x: (pointEvent.position.dx * devicePixelRatio).toInt(),
                    y: (pointEvent.position.dy * devicePixelRatio).toInt(),
                  ),
                );
                _touchList = [latLan];

                _polyline = Polyline(
                  polylineId: PolylineId(_polygonName),
                  points: _touchList,
                  width: 2,
                  color: const Color.fromRGBO(188, 141, 77, 0.6),
                  geodesic: true,
                );

                _polylineArr.add(_polyline!);

                setState(() {});
              },
              onPointerMove: (pointEvent) async {
                if (!isBlock || _controller == null) return;
                debugPrint('onPointerMove: $pointEvent');
                // 手指移动回调
                _touchList.add(
                  await _controller!.getLatLng(
                    ScreenCoordinate(
                      x: (pointEvent.position.dx * devicePixelRatio).toInt(),
                      y: (pointEvent.position.dy * devicePixelRatio).toInt(),
                    ),
                  ),
                );

                setState(() {});
              },
              onPointerUp: (pointEvent) {
                if (!isBlock || _controller == null) return;
                debugPrint('onPointerUp: $pointEvent');
                // 手指抬起回调
                onPointerUp(pointEvent, devicePixelRatio);
              },
              onPointerCancel: (pointEvent) {
                if (!isBlock || _controller == null) return;
                debugPrint('onPointerCancel: $pointEvent');
                // 触摸事件取消回调
                onPointerUp(pointEvent, devicePixelRatio);
              },
              child: AbsorbPointer(
                absorbing: isBlock,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  polygons: Set.from(_polygonArr),
                  polylines: Set.from(_polylineArr),
                  markers: Set.from(_markers),
                  onMapCreated: (controller) {
                    debugPrint('onMapCreated: $controller');
                    _controller = controller;

                    // 初始化订单marker
                    getInitMarkes(devicePixelRatio);

                    setState(() {});
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,  
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  onCameraIdle: () async {
                    // 移动后将当前定位标记初始化
                    if (positionOnStatus && currentPositionIsReady) {
                      ref.read(mapPositionStatusProvider.notifier).state = false;
                    }

                    currentPositionIsReady = _markers.any((element) => element.markerId.value == "current_location");
                  } 
                ),
              ),
            ),
            // 头部搜索 
            const Positioned(
              left: 15.0,
              top: 44.0,
              child: HeaderSearch()
            ),
            // 操作按钮 draw / cancel / confirm / redraw  
            if (buttonsVisible)
              Positioned(
                left: 0,
                top: 103.0,
                child: StatusButtons(
                  handleReDraw: handleReDraw,
                  handleConfirm: handleConfirm,
                  handleRemoveAll: () => handleRemoveAll(devicePixelRatio)
                )
              ),
            // 汇总数据 
            if (!buttonsVisible)
              const Positioned(
                right: 15.0,
                top: 103.0,
                child: SummaryCount()
              ),
            // 右下角操作按钮 
            if (!buttonsVisible)
              Positioned(
                right: 15.0,
                bottom: 78.0,
                child: HandleButtons(
                  getCurrentLocation: () => getCurrentLocation(devicePixelRatio)
                )
              ),
            // 区域排序
            // TODO: 判断有数组的时候才会显示
            // const Positioned(left: 0, right: 0, bottom: 0, child: AreaSort()),
          ],
        ),
      )
    );
  }

  void onPointerUp(PointerEvent pointEvent, double devicePixelRatio) async {
    _touchList.add(
      await _controller!.getLatLng(
        ScreenCoordinate(
          x: (pointEvent.position.dx * devicePixelRatio).toInt(),
          y: (pointEvent.position.dy * devicePixelRatio).toInt(),
        ),
      ),
    );

    if (!tools.PolygonUtil.isClosedPolygon(
        _touchList.map((e) => tools.LatLng(e.latitude, e.longitude)).toList())) {
      // 如果不是闭合区间，则链接起始点和终点
      _touchList.add(_touchList.first);
    }

    var polygonName = "G${_polygonArr.length + 1}";

    _polygon = Polygon(
      polygonId: PolygonId(polygonName),
      points: _touchList,
      fillColor: const Color.fromRGBO(188, 141, 77, 0.6),
      strokeColor: Colours.primaryColor,
      geodesic: true,
      strokeWidth: 1
    );
 
    // 判断是否有已画过的圈内的点包含  
    if (_polygonArr.isNotEmpty) {
      bool intersect = MapUtils.isDotInOldCircle(circleCollect, _touchList);
      
      if (intersect) {
        // 提示
        DialogUtils.showToast("Repeat Drop");

        _polylineArr.removeLast();

        setState(() {});
        return;
      }
    }

    final polygonPoints =  MapUtils.getPolygonPoints(MockTask.listArr, _polygon!.points);

    circleCollect[polygonName] = polygonPoints;

    _polygonArr.add(_polygon!);

    // 改变状态1
    ref.read(mapStatusProvider.notifier).state = MapStatusEnum.redraw;

    // 计算多边形中心点
    LatLng polygonCenter = MapUtils.calculatePolygonCenter(_touchList);

    // 当前添加的是第几个多边形
    debugPrint("polygonName: $polygonName");

    final byteData = await MapUtils.getByteData(polygonName, devicePixelRatio);

    final marker = Marker(
      markerId: MarkerId(polygonName),
      position: polygonCenter,
      zIndex: 2.0,
      icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()),
      onTap:() {
        debugPrint('marker tap, current index: $polygonName');
      },
    );

   _markers.add(marker);
      
    setState(() {
      _polygon = null;
      _polyline = null;
      _polygonName = polygonName;
    });
  }

  // 初始化订单大头针 
  Future<void> getInitMarkes(double devicePixelRatio) async {
    final data = MockTask.listArr;

    for (int i = 0; i < data.length; i++) {
      final element = data[i];
      // 区分类型 图标不同
      MarkerIconType type = element.tasktype == 1 ? MarkerIconType.dispatch : MarkerIconType.delivery;
      final byteData = await MapUtils.getMarkerImg(type, (i + 1).toString(), devicePixelRatio);

      _markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(element.latitude, element.longitude),
        zIndex: 2.0,
        icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()),
      ));
    }

    setState(() {});
  }

  // 获取当前位置 添加当前位置的marker
  void getCurrentLocation(double devicePixelRatio) async {
    final position = await MapUtils.getCurrentLocation();
    final byteData = await MapUtils.getCurrentPositionImg(devicePixelRatio);

    await _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 10.0,
      ),
    ));

    // 先移除当前位置标记
    _markers.removeWhere((element) => element.markerId.value == "current_location");

    // 创建marker
    final marker = Marker(
      markerId: const MarkerId("current_location"),
      position: LatLng(position.latitude, position.longitude),
      icon: BitmapDescriptor.fromBytes(byteData.buffer.asUint8List()),
    );
 
    // 添加当前位置标记
    setState(() {
      currentPositionIsReady = false;
      _markers.add(marker);
    });
  }

  /// 重新画圈 清空当前多边形
  void handleReDraw() {
    _polylineArr.removeLast();
    _polygonArr.removeLast();
    _markers.removeWhere((item) => item.markerId.value == _polygonName);

    setState(() {
      _polygonName = '';
    });
  }

  /// 重新画圈 清空当前多边形
  void handleRemoveAll(devicePixelRatio) {
    _polylineArr.clear();
    _polygonArr.clear();
    _markers.clear();

    getInitMarkes(devicePixelRatio);

    setState(() {
      _polygonName = '';
    });
  }

  /// 多边形确认
  void handleConfirm() {
    debugPrint("handleConfirm---");
    // 必须选择一个圈内终点
    // 先确认当前graph 起点和终点 第一个起点为快递员当前位置 第二个起点为第一个终点
    // 有起点 终点 graph包括的点 调用api对包括的点进行重新排序 
    // 排序成功后 保存到临时的全局数据中
  }
}
