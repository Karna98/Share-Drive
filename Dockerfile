FROM python:alpine3.7 

LABEL maintainer="vedantwakalkar@gmail.com"

RUN pip install -r requirements.txt 

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN pip install -r requirements.txt 

ENTRYPOINT [ "python", "app.py" ] 