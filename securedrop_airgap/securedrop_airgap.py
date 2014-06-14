import os, sys, inspect, gtk, gobject, webkit, threading
import webapp

def launch_window(port):
    def on_destroy(widget, data=None):
        gtk.main_quit()

    window = gtk.Window()
    window.set_title('SecureDrop')
    window.set_resizable(True)
    window.connect('destroy', on_destroy)

    box = gtk.VBox(homogeneous=False, spacing=0)
    window.add(box)

    browser = webkit.WebView()
    box.pack_start(browser, expand=True, fill=True, padding=0)

    window.show_all()

    # wait half a second for server to start
    gobject.timeout_add(500, browser.open, 'http://127.0.0.1:{0}/'.format(port))

    gtk.main()

def main():
    port = 6666

    # start the web app in a background thread
    t = threading.Thread(target=webapp.app.run, kwargs={'port':port})
    t.daemon = True
    t.start()

    # launch the window
    launch_window(port)

if __name__ == '__main__':
    main()
