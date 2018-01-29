# First Stage
FROM golang:1.6-alpine AS build-env
ADD . /builder/
WORKDIR /builder
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Second Stage
FROM alpine AS production-env
EXPOSE 80
CMD ["/webapp"]
# Copy artifacts from the first stage
COPY --from=build-env /builder/main /webapp
