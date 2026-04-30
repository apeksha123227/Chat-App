import 'package:get/get.dart';

class DashBoard_Controller extends GetxController{

  RxInt selectedTabIndex=0.obs;

  void changeTab(int index){
    selectedTabIndex.value=index;
  }

}