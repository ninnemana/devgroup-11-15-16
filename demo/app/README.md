## go-gin-mgo-demo

A demo CRUD application in golang using the popular gin-gonic framework

## Development

1. Clone the (forked) repo.
2. Then, run

  ```sh
  $ go get -u
  ```

3. Run

  ```sh
  $ go run main.go
  ```

  Then visit `localhost:7000`

4. `MONGODB_URL` and `PORT` can be configured by setting the env variable.

  ```sh
  $ export MONGODB_URL=mongodb://
  $ export PORT=7000
  ```
5. [godep](https://github.com/tools/godep) is used for dependency management. So if you add or remove deps, make sure you run `godep save` before pushing code. Refer to its documentation for more info on how to use it.

## Running in Docker

Start a MongoDB instance

```sh
$ docker run -itd -p 27017 --name mongo-database -d mongo
```

Build the application

```sh
$ docker build -t kubernetes-demo:latest .
```

Run the application

```sh
$ docker run --rm -p 8080:8080 -p 27017:27017 -e "MONGODB_URL=mongodb://mongo-database:27017/articles_demo_dev" --link mongo-database:mongo-database kubernetes-demo --name demo
```

## Usage

```sh
$ go get github.com/madhums/go-gin-mgo-demo
$ PORT=7000 GIN_MODE=release go-gin-mgo-demo # should start listening on port 7000
```

#### Credits

Thanks to all the dependent packages