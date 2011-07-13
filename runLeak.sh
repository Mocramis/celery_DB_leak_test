#!/bin/bash

VIRTUALENV_DIR="/tmp/CeleryDBMemoryLeak"
LOGFILE="leakLog.data"

cd `dirname "$(readlink -f $0)"`
rm -r $VIRTUALENV_DIR
virtualenv --no-site-packages $VIRTUALENV_DIR
source "$VIRTUALENV_DIR/bin/activate"
pip install "celery>=2.1.7"
pip install "sqlalchemy>=0.7"
pip install "simplejson"
pip install "psycopg"

createdb -U postgres mycelery

echo 
echo "Starting the LeakTesting program for 10 minutes (600 seconds)."
python celery_memory_leak.py | tee $LOGFILE

echo "$LOGFILE"
echo -e "plot \"$LOGFILE\" using 1:2 title 'rss size/calls' with line, \"$LOGFILE\"  using 1:3 title 'rsz size/calls' with line, \"$LOGFILE\" using 1:4 title 'vsz size/calls' with line ;"
#plot the file pointed in the first argument.
gnuplot -persist -e "plot \"$LOGFILE\" using 1:2 title 'rss size/calls' with line, \"$LOGFILE\"  using 1:3 title 'rsz size/calls' with line, \"$LOGFILE\" using 1:4 title 'vsz size/calls' with line ;"
gnuplot -persist -e "plot \"$LOGFILE\" using 5:1 title 'total calls/time' with line;"
