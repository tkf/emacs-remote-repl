#!/usr/bin/env python

"""
Remote REPL client.
"""

from cmd import Cmd

from epc.client import EPCClient


class RemoteREPLClient(Cmd):

    prompt = 'rrepl> '

    def connect(self, address):
        self.client = EPCClient(address)

    def default(self, line):
        self.stdout.write(self.client.call_sync('eval', [line]))
        self.stdout.write("\n")


def run_remote_repl(address, port):
    repl = RemoteREPLClient()
    repl.connect((address, port))
    repl.cmdloop()


def main(args=None):
    from argparse import ArgumentParser
    parser = ArgumentParser(description=__doc__)
    parser.add_argument('--address', default='localhost')
    parser.add_argument('--port', default=9999, type=int)
    ns = parser.parse_args(args)
    run_remote_repl(**vars(ns))


if __name__ == '__main__':
    main()
