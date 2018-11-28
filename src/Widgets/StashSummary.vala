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
            stash: _stash
        );
    }

    construct {
        stash = stash.chug ();
        string[] lines = stash.split ("\n");

        string preview = string.join ("\n", lines[0], lines[1]);

        var label = new Gtk.Label (preview);
        label.ellipsize = Pango.EllipsizeMode.END;

        add (label);
    }
}

