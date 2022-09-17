import '../gen/assets.gen.dart';
import '../utils/headers.dart';

enum OrderType {
  NORMAL,///综合
  SALES_HIGH,///销量高到低
  SALES_LOW,///销量低--
  PRICE_HIGH,///价格高--
  PRICE_LOW,///价格低--
}



class GoodsSortWidget extends StatefulWidget {
  final Function(OrderType type) onTap;
  final Widget? trialing;
  const GoodsSortWidget({Key? key, required this.onTap, this.trialing}) : super(key: key);

  @override
  _GoodsSortWidgetState createState() => _GoodsSortWidgetState();
}

class _GoodsSortWidgetState extends State<GoodsSortWidget> {
  OrderType _orderType = OrderType.NORMAL;



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.w,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[200]!, width: 0.5),
              bottom: BorderSide(color: Colors.grey[200]!, width: 0.5))),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                _orderType = OrderType.NORMAL;
                widget.onTap(_orderType);
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  '综合',
                  style: TextStyle(
                    color: _orderType == OrderType.NORMAL ? Theme.of(context).primaryColor : Color(0xFF333333),
                    fontSize: 28.sp,
                  ),
                ),
              ),
            ),
          ),


          Expanded(
            child: GestureDetector(
              onTap: (){
                switch (_orderType) {
                  case OrderType.SALES_LOW:
                  case OrderType.SALES_HIGH:
                  case OrderType.NORMAL:
                    _orderType = OrderType.PRICE_LOW;
                    setState(() {
                    });
                    break;
                  case OrderType.PRICE_HIGH:
                    _orderType = OrderType.PRICE_LOW;
                    setState(() {
                    });
                    break;
                  case OrderType.PRICE_LOW:
                    _orderType = OrderType.PRICE_HIGH;
                    setState(() {
                    });
                    break;
                }
                widget.onTap(_orderType);
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '价格',
                      style: TextStyle(
                        color: (_orderType == OrderType.PRICE_HIGH||_orderType == OrderType.PRICE_LOW) ? Theme.of(context).primaryColor : Color(0xFF333333),
                        fontSize: 28.sp,
                      ),
                    ),
                    _rightIcon(_orderType == OrderType.PRICE_HIGH?1:_orderType == OrderType.PRICE_LOW?2:0)
                  ],
                ),
              ),
            ),
          ),


          Expanded(
            child: GestureDetector(
              onTap: (){
                switch (_orderType) {
                  case OrderType.PRICE_LOW:
                  case OrderType.PRICE_HIGH:
                  case OrderType.NORMAL:
                    _orderType = OrderType.SALES_LOW;
                    setState(() {
                    });
                    break;
                  case OrderType.SALES_HIGH:
                    _orderType = OrderType.SALES_LOW;
                    setState(() {
                    });
                    break;
                  case OrderType.SALES_LOW:
                    _orderType = OrderType.SALES_HIGH;
                    setState(() {
                    });
                    break;
                }
                widget.onTap(_orderType);
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '销量',
                      style: TextStyle(
                        color: (_orderType == OrderType.SALES_HIGH||_orderType == OrderType.SALES_LOW) ? Theme.of(context).primaryColor : Color(0xFF333333),
                        fontSize: 28.sp,
                      ),
                    ),
                    _rightIcon(_orderType == OrderType.SALES_HIGH?1:_orderType == OrderType.SALES_LOW?2:0)
                  ],
                ),
              ),
            ),
          ),
          widget.trialing!=null?widget.trialing!:SizedBox(),
        ],
      ),
    );
  }


  _rightIcon(int index){
    if(index==0){
      return Padding(
        padding:  EdgeInsets.only(top: 5.w),
        child: Row(
          children: [
            10.wb,
            Image.asset(Assets.icons.upDown.path,width: 15.w,height: 15.w,),
            5.wb,
          ],
        ),
      );
    }else if(index==1){
      return      Padding(
        padding:  EdgeInsets.only(top: 5.w),
        child: Icon(
          Icons.arrow_drop_up,
          size:  30.w,
          color: Theme.of(context).primaryColor
        ),
      );
    }else{
      return      Padding(
        padding:  EdgeInsets.only(top: 5.w),
        child: Icon(
          Icons.arrow_drop_down,
          size:  30.w,
          color: Theme.of(context).primaryColor
        ),
      );
    }
  }


}
