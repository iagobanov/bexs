FROM golang

ENV TZ="UTC" \
    ENV="development"

RUN mkdir /app
WORKDIR /app

ADD . /app
WORKDIR /app/src/backend

RUN export GOBIN=$GOPATH/bin && \
    go get -t
    
CMD go run main.go