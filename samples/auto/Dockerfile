# Example Dockerfile for auto base image detection using FROM label 
FROM localhost:5000/base:latest
LABEL FROM=base:latest
COPY test.txt /
# Overwrites parent ENV
ENV A AUTO BASE
ENV B=TEST\ IMAGE IMAGE_DESCRIPTION="Test image with embedded base image info"
LABEL VERSION=1.2.3 TEST=AUTO
EXPOSE 3000 4000/udp
