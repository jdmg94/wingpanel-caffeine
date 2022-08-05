public class PopOverWidget : Gtk.Box {
  public signal void toggle_caffeine (bool is_active);

  Caffeinate caffeine;
  Granite.SwitchModelButton main_switch;

  public PopOverWidget () {
    caffeine = new Caffeinate ();
    main_switch = new Granite.SwitchModelButton ("Caffeinate");

    main_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
    main_switch.toggled.connect ((nextState) => {
      toggle_caffeine (nextState.active);

      if (nextState.active) {
        caffeine.activate ();
      } else {
        caffeine.stop ();
      }
    });

    this.pack_start (main_switch);
  }

  construct {
    orientation = Gtk.Orientation.VERTICAL;

    show_all ();
  }
}