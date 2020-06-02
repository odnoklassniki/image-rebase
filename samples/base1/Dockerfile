FROM localhost:5000/centos:6
EXPOSE 1000
ENV TEST=base1
ENV IMAGE_DESCRIPTION="Old base image"
VOLUME /mnt/basevol
ENTRYPOINT ["bash","-c"]
LABEL VERSION=1
CMD ["env && echo 'CMD from base:1' && cat test.txt /etc/centos-release"]

