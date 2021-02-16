import 'package:flutter/material.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/popup.dart';
import 'package:flutter_vant/component/toast.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/HexColor.dart';
import 'package:rlstyles/Component/StylesMap.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:flutter_daydart/flutter_daydart.dart';

enum VanCalendarType {
  single,
  multiple,
  range
}

typedef onConfirmCallBack = void Function(List<String>);
typedef onSelectCallBack = void Function(List<String>);

class VanCalendarOption {
    // 选择类型:
  // single表示选择单个日期，
  // multiple表示选择多个日期，
  // range表示选择日期区间
  final VanCalendarType type;
  // 控制是否显示
  final bool show;
  // 日历标题
  final String title;
  // 主题色，对底部按钮和选中日期生效
  final dynamic color;
  // 可选择的最小日期
  final dynamic minDate;
  // 可选择的最大日期
  final dynamic maxDate;
  // 默认日期
  final List<String> defaultDate;
  // 日期行高
  // final dynamic rowHeight;
  // 格式化函数
  final dynamic formatter;
  // 是否以弹层的形式展示日历
  final bool poppable;
  // 是否只渲染可视区域的内容
  // final bool lazyRender;
  // 是否显示月份背景水印
  final bool showMark;
  // 是否展示日历标题
  final bool showTitle;
  // 	是否展示日历副标题（年月）
  final bool showSubtitle;
  // 是否展示确认按钮
  final bool showConfirm;
  // 是否为只读状态，只读状态下不能选择日期	
  final bool readonly;
  // 确认按钮的文字
  final String confirmText;
  // 确认按钮处于禁用状态时的文字
  final String confirmDisabledText;
  // 设置周起始日
  final int firstDayWeek;
  // 确认事件
  final onConfirmCallBack onConfirm;
  // 点击事件
  final onSelectCallBack onSelect;
  // 当日历组件的 type 为 multiple 时，取消选中日期时触发	
  final onSelectCallBack onUnselect;

  const VanCalendarOption({
    this.type = VanCalendarType.single, 
    this.title, 
    this.color = '#ee0a24', 
    this.minDate, 
    this.maxDate, 
    this.defaultDate, 
    // this.rowHeight, 
    this.formatter, 
    this.poppable, 
    // this.lazyRender, 
    this.showMark = true, 
    this.showTitle = true, 
    this.showSubtitle = true,
    this.onSelect, 
    this.onConfirm,
    this.onUnselect,
    this.readonly, 
    this.confirmText, 
    this.confirmDisabledText, 
    this.firstDayWeek,
    this.show = true,
    this.showConfirm = true, 
  });
}

class VanCalendar extends StatefulWidget {

  // 参数
  final VanCalendarOption option;
  const VanCalendar({
    this.option = const VanCalendarOption()
  });
  @override
  _VanCalendarState createState() => _VanCalendarState();

  static show({BuildContext context,VanCalendarOption option}) {
    VanPopup.show(
      context: context,
      option:VanPopupOption(
        round: true,
        overlay:true,
        isShowHeader: true,
        position: 'bottom',
        title: option.showTitle ? option.title : '',
        overlayStyle: {
          CssRule.height:500
        },
        child: VanCalendar(option: option)
      )
    );
  }

  static remove() {
    VanPopup.remove();
  }
  
  static close() {
    VanPopup.close();
  }
}

class _VanCalendarState extends State<VanCalendar> {

  List<Map<String,dynamic>> list = [];
  Set<String> select = new Set();

  getStyles() {
    return {
      'main':{
        CssRule.flex:1,
      },
      'header':{
        CssRule.width:double.infinity,
        CssRule.height:30,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.fontSize:12,
        CssRule.color:'#333333',
      },
      'week':{
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        CssRule.height:30,
        CssRule.width:double.infinity,
        CssRule.borderBottomColor:Colors.black.withOpacity(0.2),
        CssRule.borderBottomWidth:0.5,
        CssRule.borderBottomStyle:'solid'
      },
      'week-item':{
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.flex:1,
        CssRule.fontSize:12
      },
      'list-view':{
        CssRule.flexDirection:"column-reverse",
        CssRule.flex:1,
        // CssRule.backgroundColor:'red'
      },
      'list-item':{
        CssRule.minHeight:270,
        CssRule.width:double.infinity,
        CssRule.zIndex:99
      },
      'list-item-title':{
        CssRule.position:'abs',
        CssRule.left:0,
        CssRule.right:0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.justifyContent:'center',
        CssRule.alignItems:'center',
        CssRule.fontSize:160,
        CssRule.color:'rgba(242, 243, 245, 0.8)',
        CssRule.fontWeight:'bold'
      },
      'list-item-bk':{
        CssRule.position:'abs',
        CssRule.left:0,
        CssRule.right:0,
        CssRule.top:0,
        CssRule.bottom:0,
        CssRule.flexWrap:'wrap',
        CssRule.flexDirection:'row',
      },
      'list-item-normal':{
        CssRule.width:51.42,
        CssRule.height:54,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.color:'#323233',
        CssRule.fontSize:16
      },
      'list-item-select':{
        CssRule.backgroundColor:widget.option.color,
        CssRule.color:'white',
      },
      'empty':{
        CssRule.width:51.42,
        CssRule.height:54,
      },
      'list-item-month-title':{
        CssRule.color:'#323233',
        CssRule.height:33,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.width:double.infinity,
      },
      'list-item-hover':{
        CssRule.color:widget.option.color
      }
    };
  }

  @override
  initState() {
    super.initState();
    if (widget.option.minDate == null && widget.option.maxDate == null ) {
      setState(() {
        list = getDefaultList();        
      });
    }
    if (widget.option.defaultDate != null) {
      setState(() {
        select = Set.from(widget.option.defaultDate);
      });
    }
  }

  getMonthDays(currentYear,currentMonth,index) {
    return List.generate(DateTime(currentYear,currentMonth + index + 1,0).day, (i){
      final format = DayDart.fromDateTime(DateTime(currentYear,currentMonth + index,i + 1)).format(fm:'YYYY-MM-DD');
      final split = format.split('-');
      return {
        'select':false,
        'disable':false,
        'name':i + 1,
        // dayDart有bug 只判断了小于9的 导致遇到9的时候 返回的是9而不是09
        'value':split[2] == '9' ? split[0] + '-' + split[1] + '-0' + split[2] : format 
        // 'value':split[0] + '-' + split[1] + '-' + (int.parse(split[2]) < 10 ? '0' + split[2] : split[2])
      };
    });
  }

  getWeekDays(currentYear,currentMonth,index) {
    return DayDart.fromDateTime(DateTime(currentYear,currentMonth + index,1)).day();
  }

  getDays(currentYear,currentMonth,index) {
    final monthDays = getMonthDays(currentYear, currentMonth, index);
    final weeks = getWeekDays(currentYear, currentMonth, index);
    final emptyDay = List.generate(weeks, (index) => {'name':null});
    return [...emptyDay,...monthDays];
  }

  getDefaultList() {
    return List.generate(6, (index){
      final currentYear = DayDart().year();
      final currentMonth = DayDart().month();
      final days = getDays(currentYear, currentMonth, index);
      return {
        'title':currentMonth + index,
        'format':(currentYear.toString()) + '年' + (currentMonth + index) .toString() + '月',
        'children':days
      };
    });
  }

  getHeaderName() {
    return DayDart().format(fm: 'YYYY-MM');
  }

  renderHeader() {
    return View(
      styles: getStyles()['header'],
      children: [
        TextView(getHeaderName())
      ]
    );
  }

  renderWeek() {
    List<String> week = ['日','一','二','三','四','五','六'];
    return View(
      styles: getStyles()['week'],
      children: week.map((e){
        return View(styles: getStyles()['week-item'],children: [TextView(e)]);
      }).toList(),
    );
  }

  Widget renderListItemTitle(title) {
    return View(
      styles: getStyles()['list-item-title'],
      children: [
        TextView(title.toString())
      ]
    );
  }

  Widget renderEmpty () {
    return View(
      styles: getStyles()['empty'],
    );
  }

  onSingle(int parentIndex,int index) {
    final String value = list[parentIndex]['children'][index]['value'];
    select.clear();
    select.add(value);
    setState(() {
      select = select;
    });
    if (widget.option.showConfirm == false) {
      onConfirm();
    }
  }

  onMultiple(int parentIndex,int index) {
    final String value = list[parentIndex]['children'][index]['value'];
    if (select.contains(value)) {
      select.remove(value);
      if (widget.option.onUnselect != null) {
        widget.option.onUnselect(select.toList());
      }
    }else {
      select.add(value);
    }
    setState(() {
      select = select;
    });
    if (select.length > 0 && widget.option.showConfirm == false ) {
      onConfirm();
    }
  }

  onRange(int parentIndex,int index) {
    final String value = list[parentIndex]['children'][index]['value'];
    if (select.length == 2 ) {
      select.clear();
    }else {
      if (select.contains(value)) {
        select.remove(value);
      }else {
        select.add(value);
      }
    }
    setState(() {
      select = select;
    });
    if (select.length > 0 && widget.option.showConfirm == false ) {
      onConfirm();
    }
  }

  onListItemClick(int parentIndex,int index) {
    if (widget.option.readonly == true) return;
    switch (widget.option.type) {
      case VanCalendarType.single:
        this.onSingle(parentIndex,index);
        break;
      case VanCalendarType.multiple:
        this.onMultiple(parentIndex,index);
        break;
      case VanCalendarType.range:
        this.onRange(parentIndex,index);
        break;
      default:
        this.onSingle(parentIndex,index);
        break;
    }
    if (widget.option.onSelect != null) {
      widget.option.onSelect(select.toList());
    }
  }

  getItemHover(String value) {
    if (widget.option.type == VanCalendarType.range) {
      if (select.length == 2 ) {
        final List<int> selectArr = select.toList().map((e)=> DateTime.parse(e).microsecondsSinceEpoch).toList();
        final int currentTime = DateTime.parse(value).microsecondsSinceEpoch;
        if (currentTime > selectArr[0] && currentTime < selectArr[1]) {
          return true;
        }
        return false;
      }else {
        return false;
      }
    }else {
      return false;
    }
  }

  List<Widget> renderListItemChildren(List children,int parentIndex) {
    return children.asMap().keys.map((index){
      final Map<String,dynamic> e = children[index];
      if (e['name'] == null ) return renderEmpty();
      final css = {
        'list-item-normal':true,
        'list-item-disabled':e['disable'],
        'list-item-select':select.contains(e['value']),
        'list-item-hover':getItemHover(e['value'])
      };
      final cls = StylesMap.getClass(css, getStyles());
      return View(
        styles: cls,
        onClick: ()=> onListItemClick(parentIndex, index),
        children: [
          TextView(e['name'].toString()),
          widget.option.type == VanCalendarType.range 
          && select.length == 2 
          && select.contains(e['value']) 
          ? TextView(e['value'] == select.first ? '开始' : '结束') : Container()
        ]
      );
    }).toList();
  }

  Widget renderListItemMonthTitle(String month) {
    return View(
      styles: getStyles()['list-item-month-title'],
      children: [
        TextView(month)
      ]
    );
  }

  Widget renderListItemBK(Map<String,dynamic> listItem,index) {
    return View(
      styles: getStyles()['list-item-bk'],
      children: [
        index > 0 && widget.option.showSubtitle ? renderListItemMonthTitle(listItem['format']) : Container(),
        ...renderListItemChildren(listItem['children'] ?? [],index)
      ]
    );
  }

  Widget renderListItem(BuildContext context,int index) {
    final Map<String,dynamic> listItem = list[index];
    final int showMonthTitleSize = index > 0 ? 44 : 0;
    return View(
      styles: {
        ...getStyles()['list-item'],
        CssRule.height:listItem['children'].length > 35 ? 324 + showMonthTitleSize : 270 + showMonthTitleSize
      },
      children: [
        widget.option.showMark ? renderListItemTitle(listItem['title']) : Container(),
        renderListItemBK(listItem,index)
      ],
    );
  }

  renderListView() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemBuilder: renderListItem,
        itemCount: list.length,
        shrinkWrap:true
      )
    );
  }

  // 确认点击事件
  onConfirm() {
    if (select.length > 0) {
      if (widget.option.onConfirm != null) {
        widget.option.onConfirm(select.toList());
        VanCalendar.close();
      }
    }else {
      Toast(context: context,option: VanToastOption(
        message: '请选择'
      ));
    }
  }

  renderButton() {
    final String confirmText = '确定';
    return VanButton(
      text: widget.option.readonly == true ? widget.option.confirmDisabledText ?? confirmText : widget.option.confirmText ?? confirmText,
      round: true,
      block: true,
      type: 'danger',
      disabled: select.length == 0 ,
      onClick: onConfirm,
      className: {
        CssRule.borderRadius:18,
        CssRule.marginLeft:15,
        CssRule.marginRight:15,
        CssRule.height:36,
        CssRule.backgroundColor:widget.option.color,
        CssRule.borderColor:widget.option.color
      }
    );
  }

  renderList() {
    return View(
      styles: getStyles()['list-view'],
      children: [
        widget.option.showConfirm ? renderButton() : Container(),
        renderListView(),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return View(
      styles: getStyles()['main'],
      children: [
        // 日历头部 用于显示当前时间
        renderHeader(),
        // 星期日期
        renderWeek(),
        // 日历
        renderList()
      ]
    );
  }
}