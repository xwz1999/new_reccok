import 'package:flutter/cupertino.dart';
import 'package:new_recook/constants/styles.dart';
import 'package:new_recook/models/home/address_model.dart';
import 'package:new_recook/widget/no_data_widget.dart';
import 'package:new_recook/widget/recook_scaffold.dart';
import 'package:new_recook/widget/refresh_widget.dart';

import '../../utils/headers.dart';
import 'add_address_page.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({Key? key}) : super(key: key);

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  List<AddressModel> _addressList = [
    AddressModel(
        name: '阿三',
        mobile: '1239238643',
        province: '浙江省',
        city: '宁波市',
        district: '海曙区',
        address: 'xx街道xx路xx楼xx室',
        isDefault: 1),
    AddressModel(
        name: '阿4',
        mobile: '12392386343',
        province: '浙江省',
        city: '宁波市',
        district: '海曙区',
        address: 'xx街道xx路xx楼xx室',
        isDefault: 0),
  ];
  bool _onLoad = true;

  GSRefreshController _refreshController =
      GSRefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '我的地址',
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 30.w),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.to(()=>AddAddressPage());
              },
              child: Text(
                '添加收货地址',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 28.sp,
                ),
              ),
            ),
          ),
        )
      ],
      body: _addressList.isNotEmpty
          ? _listWidget()
          : NoDataWidget(
              text: '还未添加地址～快去添加吧',
            ),
    );
  }

  _listWidget() {
    return Container(
      padding: EdgeInsets.only(top: 16.w),
      child: RefreshWidget(
          controller: _refreshController,
          color: AppColor.themeColor,
          onRefresh: () async {
            _onLoad = false;
            setState(() {});
            _refreshController.refreshCompleted();
          },
          onLoadMore: () async {
            _refreshController.loadComplete();
          },
          body: _onLoad ? SizedBox() : _buildList()),
    );
  }

  _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: 0, top: 0, right: 0, bottom: ScreenUtil().bottomBarHeight),
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {},
            child: Padding(child: _addressWidget(_addressList[index], index),padding: EdgeInsets.only(bottom: 24.w),) );
      },
      itemCount: _addressList.length,
    );
  }

  _addressWidget(AddressModel model, int index) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          24.hb,
          Row(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Text(
                model.name ?? '',
                style: TextStyle(color: Color(0xFF333333), fontSize: 30.sp,fontWeight: FontWeight.w500),
              ),
              24.wb,
              Text(
                model.mobile ?? '',
                style: TextStyle(color: Color(0xFF333333), fontSize: 30.sp,fontWeight: FontWeight.w500,height: 1.5),
              ),
            ],
          ),
          12.hb,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${(model.province ?? "") + (model.city ?? "") + (model.district ?? "")}',
                  style: TextStyle(color: Color(0xFF333333), fontSize: 30.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          24.hb,
          Divider(
            height: 1.w,
            thickness: 1.w,
            color: Colors.grey[200],
          ),
          GestureDetector(
            onTap: (){
            },
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.w),
                  child: AnimatedContainer(
                    height: 40.w,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(model.isDefault == 1 ? 1 : 0),
                      border: Border.all(
                        color: (model.isDefault == 1
                            ? themeColor
                            : Color(0xFF979797)),
                        width: 3.w,
                      ),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    alignment: Alignment.center,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                      opacity: model.isDefault == 1 ? 1 : 0,
                      child: Icon(
                        CupertinoIcons.checkmark,
                        color: Colors.white,
                        size: 28.w,
                      ),
                    ),
                  ),
                ),
                12.wb,
                Text(
                  model.isDefault == 1?'默认地址':'设为默认地址',
                  style: TextStyle(
                    color: model.isDefault == 1?Color(0xFFC92219):Color(0xFF333333),
                    fontSize: 28.sp,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '编辑',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '删除',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 30.sp,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
