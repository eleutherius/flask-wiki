FROM python:3.10.2
MAINTAINER ALex Lyakhov "eleutherius69@gmail.com"
RUN apt-get update && apt-get upgrade && \
apt-get install -y --no-install-recommends 
WORKDIR /app
COPY requirements.txt requirements.txt
RUN /usr/local/bin/python -m pip install --upgrade pip ; \
/usr/local/bin/python -m pip install -I setuptools==45  importlib-metadata==4.4