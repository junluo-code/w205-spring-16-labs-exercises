import psycopg2
import sys

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

# Default sql
sql = "SELECT count(*) FROM tweetwordcount;"

if len(sys.argv) == 1:
  sql = "SELECT word, count FROM tweetwordcount ORDER by word ASC;"
  cur.execute(sql)

  records = cur.fetchall()
  output = ""
  for rec in records:
    output += "(" + rec[0] + ", " + str(rec[1]) + "), "
  print output[:-2]

elif len(sys.argv) == 2:
  word = sys.argv[1]

  sql = "SELECT count FROM tweetwordcount WHERE word='%s';"%(word)
  cur.execute(sql)

  records = cur.fetchall()
  for rec in records:
    count = int(rec[0])

  print 'Total number of occurences of "%s": %d'%(word, count)

else:
  print "usage: python finalresults.py [word]"


conn.commit()
conn.close()
