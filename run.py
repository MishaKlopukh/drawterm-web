#!/usr/bin/env python
import os
import websockify
from websockify.token_plugins import BasePlugin
class Plug(BasePlugin):
    def lookup(self, token):
        return token.split(':')
pubdir = os.path.join(os.path.dirname(__file__),'dist')
srv = websockify.WebSocketProxy(web=pubdir,token_plugin=Plug(''),listen_port=8090)
if __name__=='__main__':
    srv.start_server()
