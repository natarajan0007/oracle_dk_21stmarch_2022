FROM openjdk 
# official docker image with java support 
LABEL email=ashutoshh@linux.com
RUN mkdir /code
ADD oracle.java /code/
ADD new.java /code/
# copy and ADD both are same but add can take data from URL also 
WORKDIR  /code/
# to change directory during build time and also maintain it 
RUN  javac oracle.java ; javac new.java 
# compiling code 
ENTRYPOINT ["sh","-c","java"]
# calling main code which will be fixed 
CMD ["myclass"]
# is changable 
