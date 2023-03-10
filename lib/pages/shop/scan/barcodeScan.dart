import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_recook/gen/assets.gen.dart';
import 'package:new_recook/models/home/scan_result_model.dart';
import 'package:new_recook/pages/shop/scan/fail_barcode_page.dart';
import 'package:new_recook/pages/shop/scan/input_barcode_page.dart';
import 'package:new_recook/pages/shop/scan/photos_fail_barcode_page.dart';
import 'package:new_recook/pages/shop/scan/qr_scaner_result_page.dart';
import 'package:new_recook/utils/alert.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/utils/image_utils.dart';
import 'package:new_recook/utils/permission_tool.dart';
import 'package:new_recook/utils/text_utils.dart';
import 'package:new_recook/widget/recook_back_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scan/scan.dart';



class BarcodeScanPage extends StatefulWidget {
  @override
  State<BarcodeScanPage> createState() {
    return _BarcodeScanPageState();
  }
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  String barcode = "";
  final player = AudioPlayer();
  final picker = ImagePicker();
  ScanController controller = ScanController();
  // String _platformVersion = 'Unknown';

  bool _openLight = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  Future<void> initPlatformState() async {
    //String platformVersion;
    try {
      //platformVersion = await Scan.platformVersion;
    } on PlatformException {
      //platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      //_platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context, {store}) {
    num width = MediaQuery.of(context).size.width;
    num height = MediaQuery.of(context).size.height;
    //Color lineColor = Color(0xffe53636).withAlpha(200);
    return new Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[



          ScanView(
            controller: controller,
            scanAreaScale: .8,
            scanLineColor: Colors.red,
            onCapture: (data) {
              onScan(data);
            },
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            leading: RecookBackButton(
              white: true,
            ),
            elevation: 0,
          ),

          Positioned(
              top:  height/2  - (width/2),
              child: Text("?????????????????????????????????")),
          Positioned(
              bottom: height/2  - 0.8*(width/2),

              child: Center(
                child:   GestureDetector(
                  child:Image.asset(!_openLight?Assets.icons.toolFlashlightClose.path: Assets.icons.toolFlashlightOpen.path,color: Colors.white,width: 90.w,height: 90.w,),
                  onTap: () {
                    controller.toggleTorchMode();
                    _openLight = !_openLight;
                    setState(() {

                    });

                  },
                ),
              )),


          Positioned(
              bottom: height/2  - (width/2)-150.w,

              child: Center(
                child:   Row(
                  children: [
                    GestureDetector(
                      child:Column(
                        children: [
                          Image.asset(Assets.icons.toolImg.path,color: Colors.white.withOpacity(0.6),width: 60.w,height: 60.w,),
                          30.hb,
                          Text('??????',style: TextStyle(
                              color: Colors.white.withOpacity(0.6),fontSize: 28.sp
                          ),)
                        ],
                      ),
                      onTap: () async{

                        if (Platform.isIOS) {
                          var image =
                          await picker.pickImage(source:  ImageSource.gallery);
                          if (image == null) {
                            //controller.toggleTorchMode();
                            return;
                          }
                          File? cropFile = await ImageUtils.cropImage(File(image.path));
                          if (cropFile == null) {
                            //controller.toggleTorchMode();
                            return;
                          }
                          File imageFile = cropFile;


                          final rest = await Scan.parse(image.path);

                          if (TextUtils.isEmpty(rest)) {
                            BotToast.showText(text: '??????????????????...');
                            //controller.toggleTorchMode();

                          } else {
                            onScan(rest, image: imageFile);
                          }
                          return;
                        }
                        bool permission = await Permission.storage.isGranted;
                        if(!permission){
                          Alert.show(
                            context,
                            NormalContentDialog(
                              title: '??????????????????????????????',
                              content:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Image.asset(R.ASSETS_LOCATION_PER_PNG,width: 44.rw,height: 44.rw,),
                                  Expanded(
                                    child: Text('????????????????????????????????????????????????', style: TextStyle(
                                        color: Color(0xFF666666), fontSize: 28.sp),),
                                  ),
                                ],
                              ),
                              items: ["????????????"],
                              listener: (index) {
                                Alert.dismiss(context);
                                //controller.toggleTorchMode();

                              },
                              deleteItem: "????????????",
                              deleteListener: () async {
                                Alert.dismiss(context);

                                bool  canUsePhoto = await PermissionTool.havePhotoPermission();

                                if (!canUsePhoto) {
                                  PermissionTool.showOpenPermissionDialog(
                                      context, "????????????????????????,?????????????????????????????????");
                                  return;
                                } else {
                                  var image =
                                  await picker.pickImage(source: ImageSource.gallery);
                                  if (image == null) {
                                    //controller.toggleTorchMode();
                                    return;
                                  }
                                  File? cropFile = await ImageUtils.cropImage(File(image.path));
                                  if (cropFile == null) {
                                    //controller.toggleTorchMode();
                                    return;
                                  }
                                  File imageFile = cropFile;


                                  final rest = await Scan.parse(image.path);

                                  if (TextUtils.isEmpty(rest)) {
                                    BotToast.showText(text: '??????????????????...');
                                   // controller.toggleTorchMode();
                                  } else {
                                    onScan(rest, image: imageFile);
                                  }
                                  return;
                                }
                              },
                              type: NormalTextDialogType.delete,
                            ),
                          );
                        }
                        else{


                          var image =
                          await picker.pickImage(source: ImageSource.gallery);
                          if (image == null) {
                            //controller.toggleTorchMode();
                            return;
                          }
                          File? cropFile = await ImageUtils.cropImage(File(image.path));
                          if (cropFile == null) {
                            //controller.toggleTorchMode();
                            return;
                          }


                          File imageFile = cropFile;
                          final rest = await Scan.parse(image.path);

                          if (TextUtils.isEmpty(rest)) {
                            BotToast.showText(text: '??????????????????...');
                            //controller.toggleTorchMode();
                          } else {
                            onScan(rest, image: imageFile);
                          }
                          return;
                        }


                      },
                    ),
                    200.wb,
                    GestureDetector(
                      child:Column(
                        children: [
                          Image.asset(Assets.icons.toolImgInput.path,color: Colors.white.withOpacity(0.6),width: 60.w,height: 60.w,),
                          30.hb,
                          Text('????????????',style: TextStyle(
                              color: Colors.white.withOpacity(0.6),fontSize: 28.sp
                          ),)
                        ],
                      ),
                      onTap: () {
                        Get.off(()=>InputBarcodePage());
                      },
                    ),
                  ],
                ),
              )),



        ],
      ),
    );
  }

  Future onScan(String? data, {File? image}) async {
    if (!TextUtils.isEmpty(data)) {
      _playSound();
      //_key.currentState.stopScan();
      Future.delayed(Duration(milliseconds: 500), () async {
        await _getGoodsWithCode(data, image: image);
      });
    } else {
      //_key.currentState.startScan();
    }
  }

  _playSound() async {
    player.setAsset('assets/sound/recook_scan.mp3');
    player.play();
  }

  _getGoodsWithCode(String? code, {File? image}) async {
    // ResultData resultData =
    // await HttpManager.post(APIV2.userAPI.getScanResult, {
    //   "skuCode": code,
    // });
    // if (!resultData.result) {
    //   pushToFailPage(code, resultData.msg, image);
    //   return;
    // }
    // BaseModel model = BaseModel.fromJson(resultData.data);
    // if (model.code != HttpStatus.SUCCESS) {
    //   pushToFailPage(code, model.msg, image);
    //   return;
    // }
    // // String goodsId = resultData.data['data']['goodsId'].toString();
    // // if (TextUtils.isEmpty(goodsId)) {
    // //   return;
    // // }
    // ScanResultModel scanResultModel =
    // ScanResultModel.fromMap(resultData.data['data']);
    // if (scanResultModel == null) {
    //   pushToFailPage(code, model.msg, image);
    //   return;
    // }
    // Get.off(
    //       () => QRScarerResultPage(
    //     model: scanResultModel,
    //   ),
    // );
    // return;

    Get.off(
          () => QRScarerResultPage(
        model: ScanResultModel(
          0,'','?????????500ml','???????????????','','???????????????',0,0,'',50,0
        ),
      )
    );
  }

  pushToFailPage(String? code, String? message, File? image) {
    if (image != null) {
      Get.off(()=>PhotosFailBarcodePage(code: code,message: message,image: image,));
    } else {
      Get.off(()=>FailBarcodePage(code: code,message: message,));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
