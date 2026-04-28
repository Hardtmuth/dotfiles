#!/usr/bin/env python3

import imaplib
obj = imaplib.IMAP4_SSL('imap.yandex.ru',993)
obj.login('abramow-a.v@ya.ru','mskvkwholnlkzlbg')
obj.select()
number = len(obj.search(None, 'UnSeen')[1][0].split())
if number>0:
    print(number)
else:
    print(' ')