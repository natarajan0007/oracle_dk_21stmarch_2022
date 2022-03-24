FROM oraclelinux:8.4 
LABEL email=ashutoshh@linux.com
RUN dnf install httpd -y 
# installing apache httpd 
COPY project-website-template /var/www/html/
# copy webapp to target 
EXPOSE 80 
# letting docker engine know about default port of webapp server 
# optional field 
ENTRYPOINT httpd -DFOREGROUND 