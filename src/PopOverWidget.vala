public class PopOverWidget : Gtk.Box {
  public signal void toggle_caffeine (bool is_active);

  private Caffeinate caffeine;
  private Granite.SwitchModelButton main_switch;
  private RevealerSwitch indefinite_switch;
  private Notify.Notification disable_alert;
  private Notify.Notification invalid_input_alert;

  public PopOverWidget () {
    try {
      caffeine = new Caffeinate ();
      main_switch = new Granite.SwitchModelButton ("Caffeinate");
      indefinite_switch = new RevealerSwitch ("Indefinite", true, true);
      invalid_input_alert = new Notify.Notification ("Caffeine", "The timeout can only be in numeric values", "dialog-warning");
      disable_alert = new Notify.Notification ("Decaffeinated", "Caffeine will no longer keep the system awake", "caffeine-cup-empty-symbolic");

      bool is_indefinite = true;
      Regex only_numbers = new Regex ("^[0-9]*$");
      var timeout_label = new Gtk.Label ("timeout in minutes:");
      var container = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
      var timeout_entry = new Granite.ValidatedEntry.from_regex (only_numbers);

      main_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
      indefinite_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);

      indefinite_switch.toggled.connect ((nextState) => {
        is_indefinite = nextState;
      });

      main_switch.toggled.connect ((nextState) => {
        toggle_caffeine (nextState.active);
        timeout_entry.set_sensitive (!nextState.active);
        indefinite_switch.set_sensitive (!nextState.active);

        if (nextState.active) {
          if (is_indefinite) {
            caffeine.start ();
          } else if (timeout_entry.is_valid) {
            var timeout = int.parse (timeout_entry.get_text ());

            caffeine.timed_session (timeout, () => {
              main_switch.set_active (false);

              try {
                disable_alert.show ();
              } catch {}
            });
          } else {
            TimeoutSource timer = new TimeoutSource (1);

            timer.set_callback (() => {
              main_switch.set_active (false);

              return false;
            });

            timer.attach ();

            try {
              invalid_input_alert.show ();
            } catch {}
          }
        } else {
          caffeine.stop ();
        }
      });

      disable_alert.set_timeout (3000);
      timeout_entry.set_text ("30");
      timeout_entry.set_alignment (1);
      timeout_entry.set_margin_end (10);
      timeout_entry.set_width_chars (9);
      indefinite_switch.add (container);
      container.pack_start (timeout_label, true, true, 0);
      container.pack_start (timeout_entry, false, false, 0);
      container.get_style_context ().add_class (Granite.STYLE_CLASS_SMALL_LABEL);

      this.pack_start (main_switch);
      this.pack_start (new Gtk.Separator (Gtk.Orientation.HORIZONTAL));
      this.pack_start (indefinite_switch);
    } catch {}
  }

  construct {
    orientation = Gtk.Orientation.VERTICAL;

    show_all ();
  }
}