FROM localhost:5000/base:1
COPY test.txt /
ENV A MANUAL BASE
VOLUME ["/data", "/mnt/db"]
ENV B=TEST\ IMAGE IMAGE_DESCRIPTION="Test image"
LABEL VERSION=1.2.3 org.opencontainers.image.title=image_rebase\ test\ image
# port added
EXPOSE 3000 4000/udp
