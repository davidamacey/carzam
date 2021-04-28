# define base docker image for the app
# we are choosing python base image, version 3.7-slim
# python 3.7-slim includes pip3
from python:3.7-slim

# create working directory inside the docker image
WORKDIR /app

# dot notation says source for copy is all files in current directory
# current directory is the external directory Dockerfile is located
# destination is the internal docker image directory "/app"
COPY . /app

# install dependencies in the docker image
# it is installing from the interal docker image "/app" directory
# add --no-chache-dir to keep docker image size smaller, build fails with out it
RUN pip3 --no-cache-dir install -r requirements.txt
#RUN pip3 install -r requirements.txt

# solves "ImportError: libGL.so.1: cannot open shared object file: No such file or directory"
#https://stackoverflow.com/questions/55313610/importerror-libgl-so-1-cannot-open-shared-object-file-no-such-file-or-directo
RUN apt-get update ##[edited]
RUN apt-get install ffmpeg libsm6 libxext6  -y

# expose port 8080 inside the docker image
EXPOSE 8080

# make containers created from this docker image executable
# ENTRYPOINT makes the container executable
# [ ] holds commands we want to run when creating container
# CMD [ ] containers arguments to pass to ENTRYPOINT command 
# CMD can pass multiple arguments... [ "<arg1>", "<arg2>"]
ENTRYPOINT ["python3"]
CMD ["app.py"]