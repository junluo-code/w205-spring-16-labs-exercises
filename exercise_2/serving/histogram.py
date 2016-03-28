import psycopg2
import sys
import re

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) == 2:

  # Default bounds
  lower, upper = 0, 0

  bounds = str.strip(sys.argv[1])

  # Simple rex check to make sure bounds is entered as "int,int"
  if not bool(re.match(r'^[0-9]+,[0-9]+$', bounds)):
    print "ERROR: invalid input. Bounds need to be k1,k2 where both k1 and k2 are integers"
    print ""
  else:
    lower = int(bounds.split(',')[0])
    upper = int(bounds.split(',')[1])

    if lower > upper:
      print "ERROR: in bounds [k1,k2], k1 must be smaller or equal to k2"
      print ""
    else:
      sql = "SELECT word, count FROM tweetwordcount WHERE count BETWEEN %s AND %s ORDER by count DESC;"%(str(lower), str(upper))
      cur.execute(sql)

      records = cur.fetchall()
      for rec in records:
        print "%20s: %4s"%(rec[0], rec[1])

else:
  print "usage: python histogram.py k1,k2"
  print "k1: lower bound of word count query"
  print "k2: upper bound of word count query"
  print ""

conn.commit()
conn.close()
