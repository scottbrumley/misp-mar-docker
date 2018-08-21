FROM alpine


RUN apk update
#RUN apk add --no-cache python \
#    && apk add curl \
#    && apk add git \
#    && apk add gcc \
#    && apk add py-setuptools \
#    && apk add py-pip \
#    && rm -rf /var/cache/apk/*

RUN apk add --no-cache python3 && \
    apk add bash && \
    apk add curl && \
    apk add git && \
    apk add gcc && \
#    apk add python3-dev && \
#    apk add musl-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#RUN apk add --no-cache curl python pkgconfig python-dev openssl-dev libffi-dev musl-dev make gcc
#RUN pip install setuptools

# Set the lang, you can also specify it as as environment variable through docker-compose.yml
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8


# Install PyMISP
RUN git clone https://github.com/MISP/PyMISP.git
RUN cd PyMISP/; python setup.py install

# Install Requests
RUN pip install requests

# Install OpenDXL Python client
#RUN pip install cffi
#RUN mkdir -p /config
RUN git clone https://github.com/opendxl/opendxl-client-python.git
RUN cd opendxl-client-python/; python setup.py install

# Install OpenDXL bootstrap
RUN git clone https://github.com/opendxl/opendxl-bootstrap-python.git
RUN cd opendxl-bootstrap-python/;python setup.py install

# Install OpenDXL MAR SDK
RUN git clone https://github.com/opendxl/opendxl-mar-client-python.git
RUN cd opendxl-mar-client-python/; python setup.py install

# Install MISP MAR script
RUN git clone https://github.com/mohlcyber/misp-mar.git
WORKDIR /misp-mar
RUN python -m dxlclient provisionconfig config epo misp-mar-cn -u admin -p McAfee123!

RUN sed -i 's/https:\/\/misp-ip\//https:\/\/misp\//g' misp_mar.py
RUN sed -i 's/api key/MvQeHbndoW0CkArWnPy8wxG2ea5XHZFwUIm0ITYY/g' misp_mar.py
RUN sed -i 's/path to the config file/\/misp-mar\/config\/dxlclient.config/g' mar.py
RUN pwd
RUN cat mar.py

#RUN ping -c 1 misp
#RUN cat MISP-MAR/misp_mar.py

ENTRYPOINT ["python"]
CMD ["misp_mar.py"]

#ENTRYPOINT ["squid"]
#CMD ["-f","/etc/squid/squid.conf"]
