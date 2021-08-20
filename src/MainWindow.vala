/*
* Copyright (c) 2019 brombinmirko (https://linuxhub.it)
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
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: brombinmirko <send@mirko.pm>
*/

public class Funfact.MainWindow : Gtk.ApplicationWindow
{
    private Gtk.Label fact_text;
    private Gtk.Box main;
    private Gtk.CssProvider css_provider;
    private string[] offline_facts = new string[] {
        "70% of your cat's life is spent asleep.",
        "Both humans and cats have identical regions in the brain responsible for emotion.",
        "In an average year, cat owners in the United States spend over $2 billion on cat food.",
        "Tigers are excellent swimmers and do not avoid water.",
        "Approximately 1/3 of cat owners think their pets are able to read their minds.",
        "The first true cats came into existence about 12 million years ago and were the Proailurus.",
        "Normal body temperature for a cat is 102 degrees F.",
        "Most cats had short hair until about 100 years ago, when it became fashionable to own cats and experiment with breeding.",
        "The technical term for a cat’s hairball is a bezoar.",
        "Cats must have fat in their diet because they can't produce it on their own.",
        "The Cat Fanciers Association (CFA) recognizes 44 breeds of cats."
    };
    construct
    {
        get_style_context ().add_class ("rounded");
        // set_keep_below (true);

        // set default window size
        set_size_request (450, 200);
        set_resizable (false);

        css_provider = new Gtk.CssProvider ();

        // custom style
        try {
            css_provider.load_from_data(""
                + ".box {margin: 0 20px 30px;}"
                + ".titlebar, .background { background-color: #89b2d3; color: #ffffff; border: none; text-shadow: 1px 1px #648baa;}"
                + ".fact_text { font-size: 22px; margin-top: 5px;}"
            );
        }
        catch (GLib.Error e) {
            error (e.message);
        }

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);

        // create refresh button
        var refresh_button = new Gtk.Button.from_icon_name ("view-refresh-symbolic");
        refresh_button.set_tooltip_text(_("Refresh"));

        refresh_button.clicked.connect (() => {
            get_random_fact ();
        });

        // create close button
        var close_button = new Gtk.Button.from_icon_name ("close-symbolic");

        close_button.clicked.connect (() => {
            this.destroy ();
        });

        // create main box
        main = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        main.get_style_context ().add_class ("box");

        // create elements for answer data
        fact_text = new Gtk.Label (_("Cats are so cool!"));
        fact_text.get_style_context ().add_class ("fact_text");
        fact_text.set_line_wrap(true);
        fact_text.set_max_width_chars(50);

        main.add (fact_text);

        // spacer
        var spacer = new Gtk.Grid ();
        spacer.height_request = 3;

        // headerbar
        var headerbar = new Gtk.HeaderBar ();
        headerbar.pack_end (refresh_button);
        headerbar.pack_start (close_button);
        headerbar.set_custom_title (spacer);

        var headerbar_style_context = headerbar.get_style_context ();
        headerbar_style_context.add_class ("default-decoration");
        headerbar_style_context.add_class (Gtk.STYLE_CLASS_FLAT);

        add (main);
        set_titlebar (headerbar);

        get_random_fact ();
    }

    private void get_random_fact ()
    {
        Soup.Session session = new Soup.Session ();
        Soup.Message message;
        Json.Parser parser = new Json.Parser ();

        message = new Soup.Message ("GET", "https://catfact.ninja/facts?limit=1");
        session.send_message (message);
        if(message.status_code != 200)
        {
            int rnd = Random.int_range (0, offline_facts.length);
            fact_text.set_text (offline_facts[rnd]);
            return;
        }
        try {
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);
        }
        catch(GLib.Error e) {
            error (e.message);
        }
        var root_array = parser.get_root ().get_object ();
        Json.Object fact = root_array.get_array_member ("data").get_object_element (0);
        fact_text.set_text (fact.get_string_member ("fact"));
    }
}
