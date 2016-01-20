#!/usr/bin/python

from json import loads
from json import dumps

import fileinput

stdin_lines = [line for line in fileinput.input()]

ret = loads(''.join(stdin_lines))

for minion_id, data in ret.items():
    print(minion_id)
    print('='*len(minion_id))
    for key, value in ret[minion_id].items():
        if value['result'] == False:
            print('')
            print(dumps(value, indent=4))
            print('')
