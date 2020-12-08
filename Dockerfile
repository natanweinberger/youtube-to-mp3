FROM python:3.8

RUN apt update
RUN apt install -y \
    ffmpeg

COPY requirements.txt .
RUN pip install -r requirements.txt
