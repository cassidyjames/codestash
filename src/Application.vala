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

public class App : Gtk.Application {
    public const string ID = "com.github.cassidyjames.codestash";
    public const string PATH = "/com/github/cassidyjames/codestash/";
    public const string TITLE = "CodeStash";

    public static GLib.Settings settings;
    public static MainWindow main_window;

    private uint configure_id;

    public App () {
        Object (
            application_id: ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    public static App _instance = null;
    public static App instance {
        get {
            if (_instance == null) {
                _instance = new App ();
            }
            return _instance;
        }
    }

    static construct {
        settings = new Settings (ID);
    }

    protected override void activate () {
        if (get_windows ().length () > 0) {
            get_windows ().data.present ();
            return;
        }

        // Handle quitting
        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"Escape"});

        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.destroy ();
            }
        });

        // Set up main window
        main_window = new MainWindow (this);
        main_window.configure_event.connect (() => {
            if (configure_id != 0) {
                GLib.Source.remove (configure_id);
            }

            configure_id = Timeout.add (100, () => {
                configure_id = 0;
                save_window_geometry (main_window);

                return false;
            });

            return false;
        });
        main_window.destroy.connect (() => {
            quit_action.activate (null);
        });

        // CSS provider
        var provider = new Gtk.CssProvider ();
        provider.load_from_resource (PATH + "Application.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

        Gtk.Settings.get_default ().gtk_application_prefer_dark_theme = true;
        main_window.show_all ();
    }

    private void save_window_geometry (Gtk.Window window) {
        int root_x, root_y;
        window.get_position (out root_x, out root_y);
        App.settings.set_value ("window-position", new int[] { root_x, root_y });
    }

    private static int main (string[] args) {
        Gtk.init (ref args);

        var app = new App ();
        return app.run (args);
    }
}

