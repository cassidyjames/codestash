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
            resizable: true,
            title: "CodeStash"
        );
    }

    construct {
        set_size_request (910, 640);

        var delete_button = new Gtk.Button.from_icon_name ("edit-delete", Gtk.IconSize.LARGE_TOOLBAR);

        var edit_button = new Gtk.Button.from_icon_name ("edit", Gtk.IconSize.LARGE_TOOLBAR);

        var search_entry = new Gtk.SearchEntry ();
        search_entry.placeholder_text = "Search Stashes";

        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        header.pack_start (delete_button);
        header.pack_start (edit_button);
        header.pack_end (search_entry);

        var header_context = header.get_style_context ();

        var fake_stash = new Gtk.Label ("public MainWindow (Gtk.Application application) {\n\tObject (");
        fake_stash.margin = 12;

        var sidebar_list = new Gtk.ListBox ();
        sidebar_list.activate_on_single_click = true;
        sidebar_list.selection_mode = Gtk.SelectionMode.SINGLE;
        sidebar_list.vexpand = true;
        sidebar_list.get_style_context ().add_class ("monospace");
        sidebar_list.add (fake_stash);

        var sidebar = new Gtk.ScrolledWindow (null, null);
        sidebar.hscrollbar_policy = Gtk.PolicyType.NEVER;
        sidebar.width_request = 300;
        sidebar.add (sidebar_list);

        var hello = new Gtk.Label ("Hello");

        var main_layout = new Gtk.Grid ();
        main_layout.column_spacing = main_layout.row_spacing = 12;
        main_layout.margin_end = 12;

        main_layout.add (sidebar);
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

