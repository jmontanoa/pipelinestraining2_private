# Deploy to dev or prod
docker compose -f docker-compose.dev.yml --env-file .env.dev up -d
docker compose -f docker-compose.prod.yml --env-file .env.prod up -d
# ----------------------------------------------------------------------------------------

# Redeploy
# Option 1: Recreate service manually
docker compose up -d --force-recreate SERVICE_NAME

# Option 2: Recreate and re-pull the image
docker compose up -d --force-recreate --pull always SERVICE_NAME

# Option 3: Remove and start it cleanly
docker compose stop app
docker compose rm -f app
docker compose up -d app

# Option 4: Combine with --build if using build: section
docker compose up -d --build --force-recreate app


# | Goal                           | Command                                                   |
# | ------------------------------ | --------------------------------------------------------- |
# | Force redeploy (no rebuild)    | `docker compose up -d --force-recreate app`               |
# | Force redeploy with image pull | `docker compose up -d --force-recreate --pull always app` |
# | Clean remove + redeploy        | `stop → rm -f → up -d`                                    |
# | Rebuild image too              | `--build --force-recreate`                                |
