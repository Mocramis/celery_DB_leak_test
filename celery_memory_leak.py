from celery.task import task
import memory #A simple memory tool
import sys
from time import time

@task
def foobar():
  return True

result = foobar.delay()

columns = ('n_calls', 'rss size (kB)', 'rsz size (kB)', 'vsz size (kB)', 
          'time (s)')
print (' %12s ' * len(columns)) % columns
count = 0
start = time()
while time() - start < 600: # we run for 10 minutes
  if not count % 1000:
    vals = (count, memory.rss(), memory.rsz(), memory.vsz(), time() - start)
    print (' %12i ' * len(vals)) % vals
    sys.stdout.flush()
  status = result.state
  count += 1
