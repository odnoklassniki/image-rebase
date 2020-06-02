FROM localhost:5000/centos:7
EXPOSE 2000
ENV IMAGE_DESCRIPTION="New base image"
ENV TEST=Successfully\ rebased\ to\ base2!!!
ENTRYPOINT ["bash","-c"]
LABEL VERSION=2
CMD ["env && echo 'CMD from base:2' && cat test.txt /etc/centos-release"]
