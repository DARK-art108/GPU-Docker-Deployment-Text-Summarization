FROM nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu20.04


#set up environment
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl
RUN apt-get install unzip
RUN apt-get -y install python3
RUN apt-get -y install python3-pip

# Copy our application code
WORKDIR /var/app

# . Here means current directory.
COPY . .


RUN pip3 install --no-cache-dir -r requirements.txt
RUN python3 download_HF_Question_Generation_summarization.py

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8


EXPOSE 80

# Start the app
CMD ["gunicorn", "-b", "0.0.0.0:80","app:app","--workers","1","-k","uvicorn.workers.UvicornWorker"]














