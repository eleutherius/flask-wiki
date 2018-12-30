FROM ubuntu:18.04 
MAINTAINER ALex Lyakhov "eleutherius69@gmail.com"
RUN apt-get update && apt-get upgrade && \
apt-get install -y --no-install-recommends apt-utils && \
apt-get install -y python3-pip git python3-dev build-essential wget \
zip && \
wget https://github.com/eleutherius/flask-wiki/archive/master.zip && \
unzip master.zip && rm master.zip

WORKDIR /flask-wiki-master
RUN pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python3"]
CMD ["application.py"]