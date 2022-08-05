public class Caffeine.Indicator : Wingpanel.Indicator {
  private PopOverWidget popover_widget;
  private Gtk.Image display_widget;

  public Indicator () {
    Object (
      code_name: "wingpanel-caffeine"
      );

    visible = true;
  }

  public override Gtk.Widget get_display_widget () {
    if (display_widget == null) {
      display_widget = new Gtk.Image.from_icon_name ("caffeine-cup-empty-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
    }

    return display_widget;
  }

  public override Gtk.Widget ? get_widget () {
    if (popover_widget == null) {
      popover_widget = new PopOverWidget ();

      popover_widget.toggle_caffeine.connect ((is_active) => {
        display_widget.icon_name = is_active ? "caffeine-cup-full-symbolic" : "caffeine-cup-empty-symbolic";
      });
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
