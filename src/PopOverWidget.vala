public class PopOverWidget : Gtk.Box {
  public signal void toggle_caffeine (bool is_active);

  private Caffeinate caffeine;
  private RevealerSwitch indefinite_switch;
  private Notify.Notification disable_alert;
  private Granite.SwitchModelButton main_switch;

  public PopOverWidget () {
    bool is_indefinite = true;
    Gtk.Label timeout_label = new Gtk.Label ("Timeout");
    Gtk.Box container = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
    TimeOptions.ComboBox time_options_combobox = new TimeOptions.ComboBox ();

    this.caffeine = new Caffeinate ();
    this.orientation = Gtk.Orientation.VERTICAL;
    this.main_switch = new Granite.SwitchModelButton ("Caffeinate");
    this.indefinite_switch = new RevealerSwitch ("Indefinite", true, true);
    this.disable_alert = new Notify.Notification (
      "Decaffeinated",
      "Caffeine will no longer keep the system awake",
      "caffeine-cup-empty-symbolic"
      );

    container.set_margin_top (5);
    container.set_margin_bottom (3);
    disable_alert.set_timeout (3000);
    timeout_label.set_padding (10, 0);
    indefinite_switch.add (container);
    time_options_combobox.set_margin_end (10);
    timeout_label.set_halign (Gtk.Align.START);
    container.pack_start (timeout_label, true, true, 0);
    container.pack_start (time_options_combobox, false, false, 0);
    main_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
    indefinite_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

    indefinite_switch.toggled.connect ((nextState) => {
      is_indefinite = nextState;
    });

    main_switch.toggled.connect ((nextState) => {
      toggle_caffeine (nextState.active);
      indefinite_switch.set_sensitive (!nextState.active);
      time_options_combobox.set_sensitive (!nextState.active);

      if (nextState.active) {
        if (is_indefinite) {
          caffeine.start ();
        } else {
          var timeout = time_options_combobox.get_selected_value ();

          caffeine.timed_session (timeout, () => {
            main_switch.set_active (false);

            try {
              disable_alert.show ();
            } catch {}
          });
        }
      } else {
        caffeine.stop ();
      }
    });

    this.pack_start (main_switch);
    this.pack_start (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
    this.pack_start (indefinite_switch);
  }

  construct {
    show_all ();
  }
}