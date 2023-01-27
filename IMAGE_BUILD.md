# Build docker images

## Requirements
Create builder

```bash
./create-builder
```

## Build and export locally for amd64 platform

```bash
docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --load --set *.platform=linux/amd64
```


## Build all and push

```bash
docker buildx bake --file docker-bake.hcl --builder kafkabuilder --no-cache --pull --push
```
