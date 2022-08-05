class RevealerSwitch : Gtk.Box {
  public signal void toggled (bool is_active);

  private Gtk.Revealer revealer;
  private Granite.SwitchModelButton main_switch;

  public RevealerSwitch (string title, bool defaultOpen = false, bool inverted = false) {
    this.main_switch = new Granite.SwitchModelButton (title) {
      active = defaultOpen
    };

    this.revealer = new Gtk.Revealer () {
      reveal_child = inverted ? !defaultOpen : defaultOpen
    };

    this.main_switch.toggled.connect ((nextState) => {
      toggled (nextState.active);
      this.revealer.reveal_child = inverted ? !nextState.active : nextState.active;
    });


    this.pack_start (this.main_switch);
    this.pack_start (this.revealer);
  }

  construct {
    orientation = Gtk.Orientation.VERTICAL;

    show_all ();
  }

  public new void add (Gtk.Widget child) {
    this.revealer.add (child);
  }

}