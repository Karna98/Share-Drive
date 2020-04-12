FROM python:alpine3.7 

LABEL maintainer="vedantwakalkar@gmail.com"

RUN pip install -r requirements.txt 

COPY . /app
WORKDIR /app

ENTRYPOINT [ "python", "app.py" ] 

EXPOSE 8000 
