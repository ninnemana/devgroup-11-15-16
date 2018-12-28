FROM arm32v7/golang:1.11.4-stretch

RUN go get golang.org/x/tools/cmd/present
COPY present /run/present
COPY . /app

WORKDIR /app

CMD [ "/run/present" ]
