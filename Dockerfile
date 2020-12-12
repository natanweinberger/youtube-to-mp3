FROM python:3.8

RUN apt update
RUN apt install -y \
    ffmpeg \
    pv

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . /var/src

WORKDIR /var/src
