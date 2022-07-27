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

public class Template.Indicator : Wingpanel.Indicator {

    private Gtk.Image display_widget;
    private Gtk.Grid popover_widget;

    public Indicator () {
        Object (
            code_name: "wingpanel-indicator-template"
        );

        visible = true;
    }

    public override Gtk.Widget get_display_widget () {
        if (display_widget == null) {
            display_widget = new Gtk.Image.from_icon_name ("applications-other-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
        }

        return display_widget;
    }

    public override Gtk.Widget? get_widget () {
        if (popover_widget == null) {
            popover_widget = new Gtk.Grid ();
        }

        return popover_widget;
    }

    public override void opened () {
    }

    public override void closed () {
    }

}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    debug ("Activating Template Indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        return null;
    }

    var indicator = new Template.Indicator ();
    return indicator;
}
