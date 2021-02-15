import 'package:flutter/material.dart';
import 'package:flutter_vant/component/button.dart';
import 'package:flutter_vant/component/popup.dart';
import 'package:rlstyles/Component/CssRule.dart';
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

  getStyles() {
    return {
      'main':{
        // CssRule.height:450,
        // CssRule.width:double.infinity,
      },
      'header':{
        CssRule.width:double.infinity,
        CssRule.height:50,
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.fontSize:12,
        CssRule.color:'#333333'
      },
      'week':{
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        CssRule.height:30,
        CssRule.width:double.infinity,
        CssRule.borderBottomColor:Colors.black.withOpacity(0.5),
        CssRule.borderBottomWidth:0.5,
        CssRule.borderBottomStyle:'solid'
      },
      'week-item':{
        CssRule.alignItems:'center',
        CssRule.justifyContent:'center',
        CssRule.flex:1,
        CssRule.fontSize:12
      }
    };
  }

  getHeaderName() {
    return DayDart().format(fm: 'YYYY-MM-DD');
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

  Widget renderListItem(BuildContext context,int index) {
    return TextView(index.toString());
  }

  renderList() {
    return Expanded(
      flex: 1, 
      child: ListView.builder(
        itemBuilder: renderListItem,
        itemCount: 100,
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