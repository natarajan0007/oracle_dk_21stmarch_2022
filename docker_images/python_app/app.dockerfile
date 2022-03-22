FROM python 
# choosing mybase image to setup python platform 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com
# optional field but sharing contact info 
RUN mkdir /app
# created folder to put our code 
COPY oracle.py /app/
# copy data from docker client to docker host during image build time
# make sure source data must be with respect to Dockerfile location 
CMD ["python","/app/oracle.py"]
# to fix default process for this image 
# cmd won't be executed during image build time 