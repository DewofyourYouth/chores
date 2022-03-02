import 'package:chores/database/queries.dart';
import 'package:get/get.dart';

class KidController extends GetxController {
  final kids = [].obs;

  @override
  void onInit() async {
    var kidsFromMongo = await getKidsMongo(DateTime.now());
    for (var kid in kidsFromMongo) {
      kids.add(kid);
    }
    super.onInit();
  }
}
