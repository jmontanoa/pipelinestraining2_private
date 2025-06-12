# Get newman image
docker pull postman/newman

# Get restapp ip address
$restappIp = (docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' restapp)

# Run collection using newman
docker run --rm `
            --add-host "restapp:$restappIp" `
            -v "$(Get-Location):/etc/newman" `
            postman/newman run "tests/postman/collectionRestAppTest.json" `
            --environment "tests/postman/env.json"
