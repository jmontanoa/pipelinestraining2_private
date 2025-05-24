# Build image
docker build -t restapp:1.0.0 .

# Run Unit Tests
docker stop "restapp"
docker rm  "restapp"
docker run --name "restapp" -p "5000:5000" -d restapp:1.0.0
docker exec -it restapp sh -c "python -m pytest test/unit -v"
#docker exec -it restapp sh -c "pytest test/unit -v"

# Run Integration Tests
docker stop "redisService"
docker rm  "redisService"
docker run --name "redisService" -p "6379:6379" -d redis:alpine
$redisIP = (docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redisService)[1]
docker stop "restapp"
docker rm  "restapp"
docker run --name "restapp" --add-host "redis:$redisIP" -p "5000:5000" -d restapp:1.0.0
docker exec -it restapp sh -c "python -m pytest test/integration -v"
