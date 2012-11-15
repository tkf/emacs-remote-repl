#!/usr/bin/env python

"""
Remote REPL client.
"""

from epc.client import EPCClient


def run_remote_repl(address, port):
    client = EPCClient((address, port))

    while True:
        string = raw_input('rrepl> ')
        print client.call_sync('eval', [string])


def main(args=None):
    from argparse import ArgumentParser
    parser = ArgumentParser(description=__doc__)
    parser.add_argument('--address', default='localhost')
    parser.add_argument('--port', default=9999, type=int)
    ns = parser.parse_args(args)
    run_remote_repl(**vars(ns))


if __name__ == '__main__':
    main()
