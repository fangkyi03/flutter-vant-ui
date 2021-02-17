底层使用rlstyles
因目前还在疯狂修复bug中 所以rlstyles没有提交新版本 想体验的请自行clone rlstyle到本地
并修改yaml文件中rlstyles的路径指向

支持css样式跟slot 可以使用下面的方式来写代码

```dart
VanCell(
    className:{
        cssRule.color:'red'
    },
    slot:{
        VanCellSlot.title:renderTitle
    }
)
```

```dart
getStyles() {
    return {
      'main':{
        CssRule.minHeight:24,
        CssRule.width:double.infinity,
        CssRule.flexDirection:'row',
        CssRule.justifyContent:'space-between',
        CssRule.alignItems:widget.center == true ? 'center' : 'flex-start',
        CssRule.backgroundColor:'white',
        CssRule.paddingLeft:10,
        CssRule.paddingRight:10,
        CssRule.paddingBottom:5,
        CssRule.paddingTop:5,
        CssRule.borderBottomColor:'##ebedf0',
        CssRule.borderBottomWidth:widget.border == true ? 0.5 : 0.0,
        CssRule.borderBottomStyle:'solid'
      },
      'left':{
        CssRule.fontSize:14,
        CssRule.color:'#323233',
      },
      'title':{
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        ...widget.titleStyle
      },
      'label':{
        CssRule.fontSize:12,
        CssRule.color:'#969799',
        ...widget.labelStyle
      },
      'right':{
        CssRule.fontSize:12,
        CssRule.color:'#323233',
        CssRule.flexDirection:'row',
        CssRule.alignItems:'center',
        ...widget.valueStyle
      }
    };
  }
```

文档还在补全中 rlstyles使用 可以去https://github.com/fangkyi03/flutter-rlstyle
