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
public class StashSummary : Gtk.Grid {
    public string stash { get; construct set; }

    public StashSummary (string _stash) {
        Object (
            margin: 12,
            row_spacing: 12,
            stash: _stash
        );
    }

    construct {
        // string uuid = Uuid.string_random ();

        // var settings = new Settings.with_path (
        //     App.ID + ".stash",
        //     App.PATH + "stashes/%s/".printf (uuid)
        // );

        stash = stash.chug ();
        string[] lines = stash.split ("\n");

        string preview = "";
        int preview_lines = 2;
        for (int i = 0; i < preview_lines; i++) {
            lines[i] = lines[i].chug ();
            preview = string.join ("\n", preview, lines[i]);
        }

        var preview_label = new Gtk.Label (preview);
        preview_label.ellipsize = Pango.EllipsizeMode.END;
        preview_label.halign = Gtk.Align.START;
        preview_label.hexpand = true;
        preview_label.xalign = 0;
        preview_label.get_style_context ().add_class ("monospace");

        var date_label = new Gtk.Label ("30m ago");
        date_label.halign = Gtk.Align.START;
        date_label.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

        // var test = new Gtk.Entry ();
        // test.halign = Gtk.Align.END;
        // test.valign = Gtk.Align.CENTER;

        attach (preview_label, 0, 0);
        attach (date_label, 0, 1);
        // attach (test, 1, 0, 1, 2);
        // settings.bind ("content", test, "text", SettingsBindFlags.DEFAULT);

        // test.changed.connect (() => {
        //     settings.set_int64 ("updated", new  DateTime.now ().to_unix ());
        // });
    }
}

