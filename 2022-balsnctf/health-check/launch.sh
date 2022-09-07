#!/bin/bash
# should be run by healthcheck

docker build --tag sandbox .
chmod 644 flag1.py flag2
rm -rf __pycache__
python3 background.py &
sleep 2

mkdir -p ~/backup
sudo chown -R healthcheck:uploaded __pycache__
chmod 755 __pycache__
sudo chown healthcheck:uploaded data
sudo touch /etc/authbind/byport/80
sudo chmod 500 /etc/authbind/byport/80
sudo chown healthcheck /etc/authbind/byport/80
authbind gunicorn -w 4 -k uvicorn.workers.UvicornWorker --log-syslog --bind 0.0.0.0:80 apiserver:app
