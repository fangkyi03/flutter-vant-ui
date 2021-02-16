import 'package:flutter/material.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/popup.dart';
import 'package:rlstyles/Component/CssRule.dart';
import 'package:rlstyles/Component/StylesMap.dart';
import 'package:rlstyles/Component/TextView.dart';
import 'package:rlstyles/Component/View.dart';
import 'package:flutter_daydart/flutter_daydart.dart';

class VanCalendarOption {
    // 选择类型:
  // single表示选择单个日期，
  // multiple表示选择多个日期，
  // range表示选择日期区间
  final String type;
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
  final dynamic defaultDate;
  // 日期行高
  final dynamic rowHeight;
  // 格式化函数
  final dynamic formatter;
  // 是否以弹层的形式展示日历
  final bool poppable;
  // 是否只渲染可视区域的内容
  final bool lazyRender;
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
  const VanCalendarOption({
    this.type, 
    this.title, 
    this.color, 
    this.minDate, 
    this.maxDate, 
    this.defaultDate, 
    this.rowHeight, 
    this.formatter, 
    this.poppable, 
    this.lazyRender, 
    this.showMark, 
    this.showTitle, 
    this.showSubtitle, 
    this.showConfirm, 
    this.readonly, 
    this.confirmText, 
    this.confirmDisabledText, 
    this.firstDayWeek,
    this.show = true,
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
        title: option.title,
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
  
}

class _VanCalendarState extends State<VanCalendar> {

  List<Map<String,dynamic>> list = [];
  @override
  initState() {
    super.initState();
    if (widget.option.minDate == null && widget.option.maxDate == null ) {
      setState(() {
        list = getDefaultList();        
      });
    }
  }

  getDefaultList() {
    return List.generate(6, (index){
      final currentYear = DayDart().year();
      final currentMonth = DayDart().month();
      final monthDays = List.generate(DateTime(currentYear,currentMonth + index + 1,0).day, (i){
          return {
            'select':false,
            'disable':false,
            'name':i + 1,
          };
      });
      final weeks = DayDart.fromDateTime(DateTime(currentYear,currentMonth + index,1)).day();
      final emptyDay = List.generate(weeks, (index) => {'name':null});
      final days = [...emptyDay,...monthDays];
      return {
        'title':currentMonth + index,
        'children':days
      };
    });
  }

  getStyles() {
    return {
      'main':{
        // CssRule.height:450,
        // CssRule.width:double.infinity,
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
      'list-item':{
        CssRule.height:270,
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
        CssRule.backgroundColor:'red',
        CssRule.color:'white'
      },
      'empty':{
        CssRule.width:51.42,
        CssRule.height:54,
      }
    };
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

  onListItemClick(int parentIndex,int index) {
    print('点击');
    list[parentIndex]['children'][index]['select'] = !list[parentIndex]['children'][index]['select'];
    setState(() {
      list = list;
    });
  }

  List<Widget> renderListItemChildren(List<Map<String,dynamic>> children,int parentIndex) {
    return children.asMap().keys.map((index){
      final Map<String,dynamic> e = children[index];
      if (e['name'] == null ) return renderEmpty();
      final css = {
        'list-item-normal':true,
        'list-item-disabled':e['disable'],
        'list-item-select':e['select'],
      };
      final cls = StylesMap.getClass(css, getStyles());
      return View(
        styles: cls,
        onClick: ()=> onListItemClick(parentIndex, index),
        children: [
          TextView(e['name'].toString())
        ]
      );
    }).toList();
  }

  Widget renderListItemBK(List<Widget> listChildren) {
    return View(
      styles: getStyles()['list-item-bk'],
      children: listChildren,
    );
  }

  Widget renderListItem(BuildContext context,int index) {
    final Map<String,dynamic> listItem = list[index];
    return View(
      styles: getStyles()['list-item'],
      children: [
        renderListItemTitle(listItem['title']),
        renderListItemBK(renderListItemChildren(listItem['children'],index)),
      ],
    );
  }

  renderList() {
    return Expanded(
      flex: 1, 
      child: ListView.builder(
        itemBuilder: renderListItem,
        itemCount: list.length,
        shrinkWrap:true
      )
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