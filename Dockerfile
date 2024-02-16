FROM python:3.8

RUN apt update
RUN apt install -y \
    ffmpeg \
    pv

RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install -r requirements.txt

# Temp fix for age-restricted content bug
RUN pip uninstall -y pytube

ENV PYTHONPATH=/var/src/pytube

COPY . /var/src

WORKDIR /var/src
