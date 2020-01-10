#!/usr/bin/env python
#coding=utf-8
import os
import smtplib
import email
import time
import datetime
import zipfile
import mimetypes
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email import Utils, Encoders
import sys
reload(sys)
sys.setdefaultencoding('utf8')

z = zipfile.ZipFile(os.path.realpath(sys.path[0]) + '/message.zip', 'w', zipfile.ZIP_DEFLATED)
path=os.path.realpath(sys.path[0]) + '/message.txt'
print path

f=open(path, 'rb')
s=f.readlines()
#print s
f.close

z.write(path, 'message.txt')
z.setpassword('1233211234567')
z.close

print "Zip Success."

