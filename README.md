# Satisfactory Docker

Run a [Satisfactory](https://store.steampowered.com/app/526870/Satisfactory/) dedicated server using Docker. There are plenty of other solutions out there that has way more features than this.
I wanted a bare minimum setup.

## Installation

The image can be found at:

```sh
docker pull ghcr.io/ekman/satisfactory:1
```

## Configuration

View the [example `docker-compose.yml` file](docker-compose.yml) for indications on how to install, configure and run this.

### Ports

Open UDP ports `15777`, `15000` and `7777` on your router and forward them to the hosting server/computer.

### Volumes

Mount all these volumes to your host.

| Directory inside container | Description |
| --- | --- |
| `/home/steam/.config/Epic/FactoryGame/Saved/SaveGames` | Contains all save data |
| `/home/steam/game` | Contains the game files |

### Configuration

Configuration is done in game. Add the server to your server manager and configure it accordingly.


### Updating the game files

The game files will update when the container starts. I recommend adding the following cron job to
continuously restart the server:

```sh
0 4 * * * /usr/local/bin/docker-compose --file /path/to/docker-compose.yml restart satisfactory >/dev/null 2>&1
```

## Versioning

This project complies with [Semantic Versioning](https://semver.org/).

## Changelog

For a complete list of changes, and how to migrate between major versions, see [releases page](https://github.com/Ekman/satisfactory-docker/releases).
