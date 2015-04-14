#!/usr/bin/env python
#coding=utf-8
import MySQLdb
import os
import smtplib
import email
import datetime
from email.mime.text import MIMEText
import sys
reload(sys)
sys.setdefaultencoding('utf8')

conn = MySQLdb.connect(host='localhost', user='root', passwd='mypassword', charset="utf8")
curs = conn.cursor(cursorclass = MySQLdb.cursors.DictCursor)
curs.execute("SET NAMES utf8")
conn.select_db('mydata')

count = curs.execute('SELECT Max(f_id) as MaxId FROM my_content WHERE f_name = \'liuxiao\'')
row = curs.fetchone()
MaxId = row["MaxId"]
print "Max Id got %d" % (MaxId);

oldMaxId = 0;
if os.path.exists("id.txt"):
  lf = open('id.txt' )
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
  body = body + '\r\n' + row["f_time"].strftime('%Y-%m-%d %H:%M:%S') + '\r\n' + row["f_content"].encode('utf-8')
curs.close()
conn.close()

today = datetime.date.today()

msg = MIMEText(body, 'plain', 'utf-8')
msg['From'] = 'shanzhashu@163.com'
msg['To'] = 'liuxiaoshanzhashu@gmail.com'
msg['Subject'] = 'Backup Package ' + today.strftime('%Y-%m-%d %H:%M:%S')

smtp = smtplib.SMTP()
smtp.connect("smtp.163.com", 25)
smtp.login("shanzhashu@163.com", "mypassword")
smtp.sendmail("shanzhashu@163.com", "liuxiaoshanzhashu@gmail.com", msg.as_string())
smtp.quit()
print "Mail send Success. Record MaxId"

lf = open('id.txt', 'w');
lf.write(str(MaxId));
lf.close;
print "Backup Success."

