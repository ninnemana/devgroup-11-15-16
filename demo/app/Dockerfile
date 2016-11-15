
FROM golang:latest

WORKDIR /go/src/github.com/ninnemana/devgroup-11-15-16/demo
ADD . /go/src/github.com/ninnemana/devgroup-11-15-16/demo

# Get godeps from main repo
RUN go get github.com/tools/godep

# Restore godep dependencies
RUN godep restore

# go get all of the dependencies
RUN go install
ENTRYPOINT ["/go/bin/demo"]

EXPOSE 8080
