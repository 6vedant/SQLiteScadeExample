import ScadeKit

extension MainPageAdapter {
  var rowView: SCDWidgetsRowView {
    return self.page?.getWidgetByName("rowView") as! SCDWidgetsRowView
  }

  var read_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("read_btn") as! SCDWidgetsButton
  }

  var write_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("write_btn") as! SCDWidgetsButton
  }

  var update_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("update_btn") as! SCDWidgetsButton
  }

  var del_btn: SCDWidgetsButton {
    return self.page?.getWidgetByName("del_btn") as! SCDWidgetsButton
  }

  var label: SCDWidgetsLabel {
    return self.page?.getWidgetByName("label") as! SCDWidgetsLabel
  }

  var title: SCDWidgetsLabel {
    return self.page?.getWidgetByName("title") as! SCDWidgetsLabel
  }
}