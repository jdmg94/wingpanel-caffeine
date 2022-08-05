public class Caffeine.Indicator : Wingpanel.Indicator {
  private Gtk.Box popover_widget;
  private Gtk.Image display_widget;
  private Caffeinate caffeine;

  public Indicator () {
    Object (
      code_name: "wingpanel-caffeine"
      );

    visible = true;
    caffeine = new Caffeinate ();
  }

  public override Gtk.Widget get_display_widget () {
    if (display_widget == null) {
      display_widget = new Gtk.Image.from_icon_name ("caffeine-cup-empty-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
    }

    return display_widget;
  }

  public override Gtk.Widget ? get_widget () {
    if (popover_widget == null) {
      popover_widget = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

      var main_switch = new Granite.SwitchModelButton ("Caffeinate");
      main_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
      main_switch.toggled.connect ((nextState) => {
        if (nextState.active) {
          display_widget.icon_name = "caffeine-cup-full-symbolic";
          caffeine.activate ();

        } else {
          display_widget.icon_name = "caffeine-cup-empty-symbolic";
          caffeine.stop ();
        }
      });

      popover_widget.add (main_switch);
    }

    return popover_widget;
  }

  public override void opened () {}

  public override void closed () {}

}

public Wingpanel.Indicator ? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
  if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
    return null;
  }

  return new Caffeine.Indicator ();
}
