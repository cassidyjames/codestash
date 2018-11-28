/*
* Copyright © 2018 Cassidy James Blaede (https://cassidyjames.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Cassidy James Blaede <c@ssidyjam.es>
*/

public class MainWindow : Gtk.Window {
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: CodeStash.instance.application_id,
            resizable: false,
            title: "CodeStash"
        );
    }

    construct {
        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;

        var header_context = header.get_style_context ();

        var hello = new Gtk.Label ("Hello");

        var main_layout = new Gtk.Grid ();
        main_layout.column_spacing = main_layout.row_spacing = 12;
        main_layout.margin_bottom = main_layout.margin_start = main_layout.margin_end = 12;

        main_layout.add (hello);

        var context = get_style_context ();
        context.add_class ("codestash");
        context.add_class ("rounded");

        set_titlebar (header);
        add (main_layout);
    }

    public override void realize () {
        base.realize ();

        var main_position = CodeStash.settings.get_value ("window-position");
        if (main_position.n_children () == 2) {
            var x = (int32) main_position.get_child_value (0);
            var y = (int32) main_position.get_child_value (1);

            move (x, y);
        } else {
            window_position = Gtk.WindowPosition.CENTER;
        }
    }
}
