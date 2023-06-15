#!/usr/bin/python
"""
Writing the current-env that will enable
the use of open-env-current.sh script by exporting some variables.

"""

import os
import argparse

def parse_cli() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('paths', nargs='*', type=str, help='env path(s)', default='.')
    parser.add_argument('--no-venv', '-ne', action='store_true', help='do not source virtual environment', default=False)
    parser.add_argument('--no-htop', '-nh', action='store_true', help='do not open an htop', default=False)
    parser.add_argument('--no-vim', '-nv', action='store_true', help='do not open vim session', default=False)
    parser.add_argument('--no-test', '-nt', action='store_true', help='do not run tests with make test', default=False)
    parser.add_argument('--env-file', type=str, help='location of the env-current file', default='~/scripts/.current-env.sh')
    return parser.parse_args()




if __name__ == '__main__':
    args = parse_cli()

    variables = {
        'SOURCE_VENV': 'no' if args.no_venv else 'yes',
        'OPEN_HTOP': 'no' if args.no_htop else 'yes',
        'RUN_TESTS': 'no' if args.no_test else 'yes',
        'OPEN_VIM_SESSION': 'no' if args.no_vim else 'yes',
    }

    for idx, path in enumerate(args.paths, start=1):
        variables[f'PATH_{idx}'] = f'"{os.path.abspath(path)}"'

    with open(os.path.expanduser(args.env_file), 'w') as fd:
        # write variables
        for var, val in variables.items():
            fd.write(f"export CURENV_{var}={val}\n")
    print(f"env file {args.env_file} written with {len(variables)} variables.")
