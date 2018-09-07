FROM alpine:latest
COPY hostpath-provisioner /
CMD ["/hostpath-provisioner"]
