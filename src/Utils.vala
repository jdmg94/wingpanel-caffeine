public class Utils {
  private static string get_wingpanel_xid () {
    string hit = "";
    string all_xids;
   // this works on bash: read a _ <<< $(xwininfo -root -children | grep -m 1 io.elementary.wingpanel) && echo $a
    Process.spawn_command_line_sync("xwininfo -root -children", out all_xids, null, null);
    
    string[] entries = all_xids.split("\n");
    foreach (unowned string item in entries) {
      if (item.length > 0 && item.contains("io.elementary.wingpanel")) {
        hit = item.strip();
        break;
      }
    }

    return hit.split(" ")[0];
  }

  public static void suspend() {
    string xid = Utils.get_wingpanel_xid();

    Posix.system("xdg-screensaver suspend " + xid);
  }

  public static void resume() {
    string xid = Utils.get_wingpanel_xid();

    Posix.system("xdg-screensaver resume " + xid);
  }
}