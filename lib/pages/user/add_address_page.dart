import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:new_recook/models/home/address_model.dart';
import 'package:new_recook/utils/headers.dart';
import 'package:new_recook/widget/edit_tile.dart';
import 'package:new_recook/widget/recook_scaffold.dart';

import '../../utils/text_utils.dart';


class AddAddressPage extends StatefulWidget {
  final AddressModel? addressModel;

  const AddAddressPage({Key? key, this.addressModel}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  AddressModel _address = AddressModel.empty();
  bool isDefault = false;
  late StateSetter _addressStateSetter;
  @override
  void initState() {
    super.initState();
    if(widget.addressModel!=null){
      _address = widget.addressModel!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RecookScaffold(
      title: '添加收货地址',
      body: _body()
    );
  }

  _body(){
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView(
            children: <Widget>[
              Container(
                height: 10,
              ),
              EditTile(
                constraints: BoxConstraints.tight(Size(double.infinity, 45)),
                title: "收货人",
                value: _address.name,
                hint: "请填写收货人姓名",
                textChanged: (value) {
                  _address.name = value;
                },
              ),
              Container(
                height: 3,
              ),
              EditTile(
                constraints: BoxConstraints.tight(Size(double.infinity, 45)),
                title: "手机号码",
                value: _address.mobile,
                hint: "请填写收货人手机号码",
                maxLength: 11,
                textChanged: (value) {
                  _address.mobile = value;
                },
              ),
              Container(
                height: 3,
              ),
              _addressView(),
              Container(
                height: 3,
              ),
              EditTile(
                title: "详细地址",
                hint: "街道门牌号等",
                value: _address.address,
                maxLength: 100,
                maxLines: 3,
                direction: Axis.vertical,
                constraints: BoxConstraints(maxHeight: 100),
                textChanged: (value) {
                  _address.address = value;
                },
              ),
              30.hb,
              _defaultAddressTile(),
              100.hb,
              _saveButton(context)
            ],
          ),
        ),
      ),
    );
  }


  _addressView() {
    return GestureDetector(
      onTap: () {
        Pickers.showAddressPicker(context,
          initProvince: _address.province??'',
          initCity: _address.city??'',
          initTown: _address.district??'',
          onConfirm: (p,c,d){
            _address.province = p;
            _address.city = c;
            _address.district = d;
            _addressStateSetter(() {

            });
          }
        );
      },
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setSta) {
          _addressStateSetter = setSta;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.grey[200]!, width: 0.5))),
            child: Row(
              children: <Widget>[
                Container(
                  width: 160.w,
                  child: Text(
                    "所在地区",
                    style:
                    TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w300),
                  ),
                ),
                Expanded(
                    child: Text(
                      TextUtils.isEmpty(_address.province)
                          ? "选择地址"
                          : "${_address.province}-${_address.city}${!TextUtils.isEmpty(_address.district) ? "-${_address.district}" : ""}",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w300),
                    )),
                Icon(
                  Icons.navigate_next,
                  size: 32.w,
                  color: Colors.black,
                )
              ],
            ),
          );
        },
      ),
    );
  }


  Container _saveButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: GestureDetector(
        onTap: () {
          _saveAddress();
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(40.w), right: Radius.circular(40.w)),
          ),
          height: 80.w,
          padding: EdgeInsets.symmetric(vertical: 8.w),
          child: Text(
            "保存并使用",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
            ),
          ),
        ),
      ),
    );
  }

  _saveAddress(){
    Get.back(result: true);
  }

  _defaultAddressTile() {


    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(20.w),
      padding:
      EdgeInsets.only(top: 24.w, bottom: 24.w, left: 24.w, right: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(24.w)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              '设置为默认地址'.text.size(28.sp).color(Color(0xFF333333)).make(),
              5.hb,
              '提醒：每次下单会默认推荐使用该地址'
                  .text
                  .size(24.sp)
                  .color(Color(0xFFBBBBBB))
                  .make(),
            ],
          ),
          Spacer(),
          CupertinoSwitch(
              value: isDefault,
              onChanged: (value) {
                if (value) {
                  isDefault = value;
                  _address.isDefault = 1;
                  print(1);
                } else {
                  isDefault = value;
                  _address.isDefault = 0;
                  print(0);
                }
                setState(() {});
              })
        ],
      ),
    );
  }
}
