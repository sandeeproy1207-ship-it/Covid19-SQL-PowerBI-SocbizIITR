# rewrite-dates.py
from datetime import datetime

def commit_callback(commit):
    # use UTC unix timestamp + timezone offset
    ts = str(int(datetime.utcnow().timestamp()))
    b = (ts + ' +0000').encode('utf-8')
    commit.author_date = b
    commit.committer_date = b
