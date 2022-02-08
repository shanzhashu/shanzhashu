#!/usr/bin/env python
#coding=utf-8
import pymysql
import os
import smtplib
import email
import time
import datetime
import mimetypes
import subprocess
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.MIMEBase import MIMEBase
from email import Utils, Encoders
import sys
reload(sys)
sys.setdefaultencoding('utf8')

conn = pymysql.connect(host='localhost', user='root', passwd='', charset="utf8")
curs = conn.cursor() #cursorclass = pymysql.cursors.DictCursor)
curs.execute("SET NAMES utf8")
conn.select_db('mydata')

count = curs.execute('SELECT Max(f_id) as MaxId FROM my_content WHERE f_name = \'liuxiao\'')
row = curs.fetchone()
MaxId = row[0]
print "Max Id got %d" % (MaxId);

idpath=os.path.realpath(sys.path[0]) + '/id.txt'

oldMaxId = 0;
if os.path.exists(idpath):
  lf = open(idpath)
  oldMaxId= int(lf.readline());
  print "Old Max Id %d" % (oldMaxId);

  if MaxId <= oldMaxId:
    print "No New Id Found. Exit"
    quit()
else:
  print 'No maxid, do backup.'

count = curs.execute('SELECT f_time, f_content FROM my_content WHERE f_name = \'liuxiao\'')
#print count
body = '';
for i in range(count):
  row = curs.fetchone()
  body = body + '\r\n' + row[0].strftime('%Y-%m-%d %H:%M:%S') + '\r\n' + row[1].encode('utf-8')
curs.close()
conn.close()

path=os.path.realpath(sys.path[0]) + '/message.txt'

f = open(path, 'w')
f.write(body)
f.flush
f.close

print path

f=open(path, 'rb')
s=f.readlines()
#print s
f.close

returnCode = os.system('/usr/bin/mysqldump -u root -p123 mydata > ' + os.path.realpath(sys.path[0]) + '/mydata.sql')
print 'Dump reeturncode:', returnCode
time.sleep(2)

returnCode = subprocess.call(os.path.realpath(sys.path[0]) +'/zipmsg.py')
print 'Zip returncode:', returnCode  

time.sleep(5)

today = datetime.date.today()

#msg = MIMEText(body, 'plain', 'utf-8')
msg = MIMEMultipart()

msg['From'] = '21808552@qq.com'
msg['To'] = 'liuxiaoshanzhashu@gmail.com'
msg['Subject'] = 'Backup Package ' + today.strftime('%Y-%m-%d %H:%M:%S')

f=open(os.path.realpath(sys.path[0]) + '/message.zip', 'rb')
s=f.read()
#print s
f.close

fd = file(os.path.realpath(sys.path[0]) + '/message.zip',"rb")
mimetype,mimeencoding = mimetypes.guess_type(os.path.realpath(sys.path[0]) + '/message.zip')
if mimeencoding or (mimetype is None):
    mimetype = "application/octet-stream"
maintype,subtype = mimetype.split("/")

if maintype == "text":
    att1 = MIMEText(fd.read(),_subtype = subtype)
else:
    att1 = MIMEBase(maintype,subtype)
    att1.set_payload(fd.read())
    Encoders.encode_base64(att1)
att1.add_header("Content-Disposition","attachment",filename = "message.zip")
fd.close()

msg.attach(att1)

smtp = smtplib.SMTP_SSL("smtp.qq.com:465")
smtp.login("21808552@qq.com", "mypassword")
smtp.sendmail("21808552@qq.com", "liuxiaoshanzhashu@gmail.com", msg.as_string())
smtp.quit()
#print msg.as_string()
print "Mail send Success. Record MaxId"

os.remove(os.path.realpath(sys.path[0]) + "/message.txt")
os.remove(os.path.realpath(sys.path[0]) + "/message.zip")

lf = open(idpath, 'w');
lf.write(str(MaxId));
lf.close;
print "Backup Success."

