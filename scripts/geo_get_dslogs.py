#!/usr/bin/env python3
import argparse
import os

SERV_US='172.16.160.115'
SERV_UAT='172.16.160.210'
DEFAULT_SERV=SERV_UAT

DSS_DIR='/logs/dss'
DSV_DIR='/logs/dsv6'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
	        description='Gets a DSS log')
    parser.add_argument('-s', '--server', default=DEFAULT_SERV,
                        help = 'Server address (Default {}) Can use US or UAT string also'.format(DEFAULT_SERV))
    parser.add_argument('-d', '--date',
                        help = 'Specific date in YYYY-MM-DD format (Gets current log if not specified)')
    parser.add_argument('-o', '--out', default='.',
                        help = 'Output directory (Current dir if not specified)')
    parser.add_argument('--dsv', action='store_true',
                        help = 'Get dsv (GMS2) log instead of dss (GMS3)')
    parser.add_argument('-r', '--remote-dir', default=DSS_DIR,
                        help = 'Remote log directory (DSS (GMS3, default) or DSV (GMS2))')
    parser.add_argument('-p', '--packets', action='store_true',
                        help = 'Gets dss-packets log (Gets dss log if not specified)')
    args = parser.parse_args()

    ext = '.log'
    if args.packets:
        log = 'dss-packets'
    else:
        log = 'dss'

    if args.date:
        log += '-' + args.date
        ext += '.gz'

    remote_dir = args.remote_dir
    if args.remote_dir == 'DSV':
        remote_dir = DSV_DIR
    elif args.remote_dir == 'DSS':
        remote_dir = DSS_DIR

    addr = args.server
    if args.server == 'UAT':
        addr = SERV_UAT
    elif args.server == 'US':
        addr = SERV_US

    log += ext

    os.system('scp {}:{}/{} {}'.format(addr, args.remote_dir, log, args.out))
    if 'gz' in ext:
        os.system('gzip -d {}/{}'.format(args.out, log))
