/// 在main方法初始化
/// void main() async {
//   await DatabaseFactory.forFeature();
//   runApp(const MyApp());
// }
class DatabaseDaoFactory {
  static forFeature() async {
    var list = [
      // ...其他的表实体类
    ];
    for (int i = 0; i < list.length; i++) {
      var entity = list[i];

      // 是否还记得基类中定义的 exists 字段,这是用来判断表是否创建完成
      while (!entity.exists) {
        //等待数据表创建完成
        await Future.delayed(const Duration(milliseconds: 60), () {});
      }
    }
  }
}
