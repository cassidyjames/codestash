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
            // icon_name: CodeStash.instance.application_id,
            icon_name: "edit-copy",
            resizable: true,
            title: "CodeStash"
        );
    }

    construct {
        set_size_request (910, 640);

        var delete_button = new Gtk.Button.from_icon_name ("edit-delete", Gtk.IconSize.LARGE_TOOLBAR);

        var new_button = new Gtk.Button.from_icon_name ("document-new", Gtk.IconSize.LARGE_TOOLBAR);

        var search_entry = new Gtk.SearchEntry ();
        search_entry.placeholder_text = "Search Stashes";
        search_entry.valign = Gtk.Align.CENTER;

        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        header.pack_start (delete_button);
        header.pack_start (new_button);
        header.pack_end (search_entry);

        var fake_stash = new StashSummary (
"""
    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            // icon_name: CodeStash.instance.application_id,
            icon_name: "edit-copy",
            resizable: true,
            title: "CodeStash"
        );
    }
"""
        );

        var fake_stash2 = new StashSummary (
"""
    construct {
        set_size_request (910, 640);

        var delete_button = new Gtk.Button.from_icon_name ("edit-delete", Gtk.IconSize.LARGE_TOOLBAR);

        var new_button = new Gtk.Button.from_icon_name ("document-new", Gtk.IconSize.LARGE_TOOLBAR);

        var search_entry = new Gtk.SearchEntry ();
        search_entry.placeholder_text = "Search Stashes";
        search_entry.valign = Gtk.Align.CENTER;

        var header = new Gtk.HeaderBar ();
        header.show_close_button = true;
        header.pack_start (delete_button);
        header.pack_start (new_button);
        header.pack_end (search_entry);
    }
"""
        );

        var fake_stash3 = new StashSummary (
"""
        var sidebar_list = new Gtk.ListBox ();
        sidebar_list.activate_on_single_click = true;
        sidebar_list.selection_mode = Gtk.SelectionMode.SINGLE;
        sidebar_list.vexpand = true;
        sidebar_list.width_request = 100;
"""
        );

        var sidebar_list = new Gtk.ListBox ();
        sidebar_list.activate_on_single_click = true;
        sidebar_list.selection_mode = Gtk.SelectionMode.SINGLE;
        sidebar_list.vexpand = true;
        sidebar_list.width_request = 100;

        sidebar_list.add (fake_stash);
        sidebar_list.add (fake_stash2);
        sidebar_list.add (fake_stash3);

        var source_view = new Gtk.SourceView ();
        source_view.expand = true;
        source_view.monospace = true;
        source_view.right_margin = source_view.left_margin = 12;
        source_view.smart_backspace = true;
        source_view.smart_home_end = Gtk.SourceSmartHomeEndType.BEFORE;
        source_view.top_margin = source_view.bottom_margin = 12;

        var source_scroll = new Gtk.ScrolledWindow (null, null);
        source_scroll.add (source_view);

        var paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        paned.position = 200;
        paned.add1 (sidebar_list);
        paned.add2 (source_scroll);

        var context = get_style_context ();
        context.add_class ("codestash");
        context.add_class ("rounded");

        set_titlebar (header);
        add (paned);
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

