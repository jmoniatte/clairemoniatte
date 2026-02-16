# clairemoniatte.com

Portfolio website for Claire Moniatte.

## Environment variables

Create a `.env` file at the project root:

```
ADMIN_PASSWORD=<admin password>
SECRET_KEY_BASE=<secret key>
```

In development, placeholder values are fine. In production, use strong values. Generate a secret key with:

```bash
docker compose -f docker-compose.production.yml run --rm app bin/rails secret
```

The `.env` file is gitignored and must be created manually on each machine.

## Development

```bash
docker compose up -d
```

The site is available at http://localhost (nginx) or http://localhost:3000 (Rails directly).

To stop:

```bash
docker compose down
```

## Production

Production uses [Traefik](https://traefik.io/) for SSL termination and routing. Traefik runs separately in `~/jmoniatte/traefik/` and is shared across all sites on the server.

### First-time setup

```bash
# Create the shared Docker network (once per server)
docker network create proxy

# Start Traefik (once per server)
cd ~/jmoniatte/traefik
docker compose up -d
```

### Start

```bash
docker compose -f docker-compose.production.yml up -d
```

### Stop

```bash
docker compose -f docker-compose.production.yml down
```

### Rebuild after code changes

```bash
docker compose -f docker-compose.production.yml up -d --build
```

## SSL

Traefik automatically obtains and renews Let's Encrypt certificates. The only requirement is that the DNS A record for `clairemoniatte.com` points to the server's public IP, with ports 80 and 443 forwarded.
