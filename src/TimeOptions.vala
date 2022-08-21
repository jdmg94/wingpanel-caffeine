namespace TimeOptions {
  private int minutes_to_milis (int minutes) {
    int one_second = 1000;
    int one_minute = 60 * one_second;

    return minutes * one_minute;
  }

  private int hours_to_milis(int hours) {
    return minutes_to_milis(hours * 60);
  }

  private class Value {
    public string label;
    public int timeout;

    public Value (string label, int timeout) {
      this.label = label;
      this.timeout = timeout;
    }

  }

  public class ComboBox : Gtk.ComboBox {
    private Gtk.ListStore data;    

    public ComboBox () {
      Gtk.TreeIter iterator;
      Gtk.CellRendererText renderer = new Gtk.CellRendererText ();

      this.data = new Gtk.ListStore (2, typeof (string), typeof (int));

      TimeOptions.Value[] options = {
        new TimeOptions.Value ("30 Minutes", minutes_to_milis (30)),
        new TimeOptions.Value ("1 Hour", minutes_to_milis (60)),
        new TimeOptions.Value ("2 Hours", hours_to_milis (2)),
        new TimeOptions.Value ("4 Hours", hours_to_milis (4)),
        new TimeOptions.Value ("5 Hours", hours_to_milis (5)),
        new TimeOptions.Value ("8 Hours", hours_to_milis (8)),
      };

      foreach (TimeOptions.Value item in options) {
        data.append (out iterator);
        data.set (iterator, 0, item.label, 1, item.timeout, -1);
      }

      this.set_model (data);
      this.set_active (0);
      this.pack_start (renderer, true);
      this.add_attribute (renderer, "text", 0);
    }

    public int get_selected_value () {
      int result = 0;
      Gtk.TreeIter iterator;

      if (this.get_active_iter (out iterator)) {
        this.data.get (iterator, 1, out result, -1);
      }

      return result;
    }

  }
}
