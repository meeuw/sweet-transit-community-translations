FROM cm2network/steamcmd:root

COPY entrypoint.sh /entrypoint.sh

ENV STEAM_USERNAME=
ENV STEAM_MTBF=
ENV STEAM_CONNECT_CACHE_1=
ENV STEAM_CONNECT_CACHE_2=
ENV STEAM_ID=

RUN chmod +x /entrypoint.sh

CMD ["."]
ENTRYPOINT ["/entrypoint.sh"]
