/*
 * Copyright 2021 Pong Loong Yeat (https://github.com/pongloongyeat/wingpanel-indicator-template)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

public class Caffeine.Indicator : Wingpanel.Indicator {

    //  private bool is_active = false;
    private Gtk.Box popover_widget;
    private Gtk.Image display_widget;


    public Indicator () {
        Object (
            code_name: "wingpanel-caffeine"
        );

        visible = true;
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new Gtk.Image.from_icon_name ("face-tired-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        }

        return display_widget;
    }

    public override Gtk.Widget? get_widget () {
        if (popover_widget == null) {
            popover_widget = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            
            var revealer = new Gtk.Revealer();
            var indefinite_switch = new Granite.SwitchModelButton("Indefinite");
            var revealer_content = new Gtk.Box(Gtk.Orientation.VERTICAL, 2);

            indefinite_switch.active = true;
            revealer_content.add(indefinite_switch);
            revealer.add(revealer_content);

            var main_switch = new Granite.SwitchModelButton("Caffeinate");
            var content_separator = new Gtk.Separator (Gtk.Orientation.HORIZONTAL) {
                margin_top = 3,
                margin_bottom = 3
            };

            main_switch.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            main_switch.toggled.connect((nextState) => {
                var alert = new Notify.Notification(
                    "Caffeine", 
                    (!nextState.active ? "Activating" : "Deactivaing")  + " sleep on ElementaryOS",
                    "dialog-information"
                );

                revealer.reveal_child = nextState.active;

                
                if (nextState.active) {
                    display_widget.icon_name = "face-surprise-symbolic"; 
                    Utils.suspend();                              
                    
                } else {
                    display_widget.icon_name = "face-tired-symbolic";                                
                    Utils.resume();
                }

                alert.show();                
            });

            popover_widget.add(main_switch);
            popover_widget.add(content_separator);
            popover_widget.add(revealer);         
        }

        return popover_widget;
    }

    public override void opened () {
    }

    public override void closed () {
    }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        return null;
    }

    Notify.init ("com.github.jdmg94.wingpanel-caffeine");

    var indicator = new Caffeine.Indicator ();
    return indicator;
}
