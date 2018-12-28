FROM golang:1.11

RUN go get golang.org/x/tools/cmd/present
COPY present /run/present
COPY . /app

WORKDIR /app

CMD [ "/run/present" ]
