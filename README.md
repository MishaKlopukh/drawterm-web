Javascript Drawterm port
============================

***WARNING: PROBABLY INSECURE***

This is a version of [drawterm](http://drawterm.9front.org/) (a program for connecting to Plan 9 systems) which runs in a webbrowser.
To connect to the remote host, it uses Websockets, which means you need a proxy such as [websockify](https://github.com/novnc/websockify).

Jsdrawterm is written in Javascript, but it uses a bunch of C libraries from Plan 9 (for crypto and drawing routines) which need to be compiled to Webassembly.
Since the Javascript also deals with some of the crypto, it's probably horribly insecure and hackers will steal your cats.

How to build
-------------

With emscripten installed, a simple `make` will build the `blob.js` and `blob.wasm` files.

How to install
---------------

- Copy the `js`, `html`, `wasm` and `jpg` files on your webserver.
- Edit `config.js` to taste.
- Start a Websocks proxy:

	websockify 1234 cirno:17019
	websockify 1235 cirno:567

- Enjoy.
