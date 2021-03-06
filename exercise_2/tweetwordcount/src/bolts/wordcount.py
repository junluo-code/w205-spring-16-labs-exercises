from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2


class WordCounter(Bolt):

    # Move connection to class level attribute
    conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

    def initialize(self, conf, ctx):
        self.counts = Counter()
        #self.redis = StrictRedis()


    def __del__(self):
        # Close connection
        WordCounter.conn.close()

    def upsert(self, uWord, uCount):

        # Handle single quote issue such as "I'm", "Can't"
        if "'" in uWord:
            uWord = uWord.replace("'", "''")

        # Move connection out of upsert method to be a bit more efficient
        #conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
        cur = WordCounter.conn.cursor()

        sql = "UPDATE tweetwordcount SET count=%s WHERE word='%s';"%(uCount, uWord)
        sql += "INSERT INTO tweetwordcount (word, count) SELECT '%s', %s WHERE NOT EXISTS"%(uWord, uCount)
        sql += " (SELECT 1 FROM tweetwordcount WHERE word='%s');"%(uWord)

        cur.execute(sql)
        WordCounter.conn.commit()

        #conn.close()

    def process(self, tup):
        word = tup.values[0]

        # Write codes to increment the word count in Postgres
        # Use psycopg to interact with Postgres
        # Database name: Tcount
        # Table name: Tweetwordcount
        # you need to create both the database and the table in advance.

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Update if exists. Insert if not exists
        self.upsert(word, self.counts[word])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
