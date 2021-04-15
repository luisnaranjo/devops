# Example of a multi-stage build.

# First stage is used to compile the source code file.
# It uses a heavy docker image with all tools to compile the go source file.
FROM golang:1.12.4 AS compiler
WORKDIR /helloworld
COPY helloworld.go .
RUN GOOS=linux go build -a -installsuffix cgo -o helloworld .

# Second stage will generate the final desired image.
# It will use an alpine image as the base image and copy the compiled go program from previous stage.
# Only the compiled program will be used from the previous stage.
FROM alpine:3.9.3
WORKDIR /root
COPY --from=compiler /helloworld/helloworld .
CMD ["./helloworld"]
