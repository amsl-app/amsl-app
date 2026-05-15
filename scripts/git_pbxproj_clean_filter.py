#!/usr/bin/env python3

import re
import sys


def main() -> None:
    content = sys.stdin.read()
    content = re.sub(
        r'("?)DEVELOPMENT_TEAM(\[sdk=\w+\*])?("?)\s+=\s+"[^"]*";',
        f'\\g<1>DEVELOPMENT_TEAM\\g<2>\\g<3> = "";',
        content,
    )
    sys.stdout.write(content)


if __name__ == "__main__":
    main()
