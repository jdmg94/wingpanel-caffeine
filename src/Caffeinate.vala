public delegate void Callback ();

public class Caffeinate {
  private string xid;
  private bool is_active;
  private TimeoutSource timer;

  private static string get_wingpanel_xid () {
    string hit = "";
    string all_xids;

    try {
      // this works on bash: read a _ <<< $(xwininfo -root -children | grep -m 1 io.elementary.wingpanel) && echo $a
      Process.spawn_command_line_sync ("xwininfo -root -children", out all_xids, null, null);
    } catch {}

    string[] entries = all_xids.split ("\n");
    foreach (unowned string item in entries) {
      if (item.length > 0 && item.contains ("io.elementary.wingpanel")) {
        hit = item.strip ();
        break;
      }
    }

    return hit.split (" ")[0];
  }

  public Caffeinate () {
    this.is_active = false;
    this.xid = Caffeinate.get_wingpanel_xid ();
  }

  public void activate () {
    this.is_active = true;
    Posix.system ("xdg-screensaver suspend " + this.xid);
  }

  public void stop () {
    if (this.is_active) {
      this.is_active = false;
      Posix.system ("xdg-screensaver resume " + this.xid);
    }

    if (timer) {
      timer.destroy ();
      timer = null;
    }
  }

  public void activateFor (int duration, Callback callback) {
    timer = new TimeoutSource.seconds (duration * 60); // duration comes in minutes

    timer.set_callback (() => {
      this.stop ();
      callback ();

      return false;
    });

    timer.attach ();
    this.activate ();
  }

}