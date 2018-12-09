FROM ubuntu:18.04
EXPOSE 3031
#VOLUME /usr/src/app/public
#WORKDIR /usr/src/app
#RUN apk add --no-cache \
#        uwsgi-python3 \
#        python3
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \

    #rm -rf /var/lib/apt/lists/* \
    #       /etc/apt/sources.list.d/cuda.list \
    #       /etc/apt/sources.list.d/nvidia-ml.list && \

    apt-get update && \
	DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        wget \
        git \
        vim \
        && \

$GIT_CLONE https://github.com/eleutherius/flask-wiki.git ~/flask-wiki

COPY . .
#RUN rm -rf public/*
RUN pip install --no-cache-dir -r requirements.txt
CMD [ "uwsgi", "--socket", "0.0.0.0:3031", \
               "--uid", "uwsgi", \
               "--plugins", "python3", \
               "--protocol", "uwsgi", \
               "--wsgi", "main:application" ]

