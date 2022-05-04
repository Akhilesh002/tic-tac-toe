import 'package:get/get.dart';

class BoardController extends GetxController {
  RxBool isVsBot = false.obs;
  RxList<String> board = ['', '', '', '', '', '', '', '', ''].obs;
  RxInt currentMoves = 0.obs;
  RxBool loading = false.obs;
  RxString turn = "First Move: X".obs;
}
