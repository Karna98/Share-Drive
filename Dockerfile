FROM python:alpine3.7 

LABEL maintainer="vedantwakalkar@gmail.com"

COPY . /app
WORKDIR /app

RUN pip install -r requirements.txt 
EXPOSE 5001 

ENTRYPOINT [ "python" ] 
CMD [ "app.py" ] 
