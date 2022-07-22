FROM cm2network/steamcmd:root

LABEL org.opencontainers.image.source="https://github.com/Ekman/satisfactory-docker"
LABEL org.opencontainers.image.authors="Niklas Ekman <nikl.ekman@gmail.com>"

ENV GAME_DIR="$HOMEDIR/game" \
    CONFIG_DIR="$HOMEDIR/.config/Epic/FactoryGame/Saved/SaveGames" \
    GAME_ID="1690800" \
    NAME="My server" \
    DEBIAN_FRONTEND="noninteractive" \
    STEAM_CONFIG_DIR="$HOMEDIR/.config"

EXPOSE 15777/udp
EXPOSE 15000/udp
EXPOSE 7777/udp

RUN apt-get update \
    && apt-get install --yes --no-install-recommends --no-install-suggests tini gosu \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && apt-get autoclean \
    && mkdir -p "$GAME_DIR" "$CONFIG_DIR" "$STEAM_CONFIG_DIR" "$HOMEDIR/Steam" \
    && chown -R "$USER":"$USER" "$GAME_DIR" "$CONFIG_DIR" "$STEAM_CONFIG_DIR" "$HOMEDIR/Steam"
     
ADD --chown="$USER":"$USER" scripts/docker-entrypoint.sh /

VOLUME [ "$GAME_DIR", "$CONFIG_DIR", "$STEAM_CONFIG_DIR", "$HOMEDIR/Steam" ]

# See: https://github.com/docker-library/official-images#init
ENTRYPOINT [ "tini", "-v", "-e", "143", "--", "bash", "/docker-entrypoint.sh" ]
