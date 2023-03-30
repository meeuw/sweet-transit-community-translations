#!/bin/bash

set -eu

echo "Action ref: $GITHUB_ACTION_REF"

repo=`pwd`
export HOME=/home/steam
cd $STEAMCMDDIR

echo "Uploading item $2 for app $1 from $3"

cat << EOF > ./workshop.vdf
"workshopitem"
{
    "appid"            "$1"
    "publishedfileid"  "$2"
    "contentfolder"    "$repo/$3"
    "changenote"       "$4"
}
EOF

cat << EOF > /home/steam/Steam/config/config.vdf
"InstallConfigStore"
{
	"Software"
	{
		"Valve"
		{
			"Steam"
			{
				"Perf"
				{
					"GameProfiles"
					{
						"Global"
						{
							"0"
							{
								"0"		""
							}
						}
						"App"
						{
							"769"
							{
								"0"
								{
									"0"		""
								}
							}
						}
					}
				}
				"AutoUpdateWindowEnabled"		"0"
				"ipv6check_http_state"		"bad"
				"ipv6check_udp_state"		"bad"
				"MTBF"		"$STEAM_MTBF"
				"ConnectCache"
				{
					"$STEAM_CONNECT_CACHE_1"		"$STEAM_CONNECT_CACHE_2"
				}
				"Accounts"
				{
					"$STEAM_USERNAME"
					{
						"SteamID"		"$STEAM_ID"
					}
				}
			}
		}
	}
}
EOF

echo "$(cat ./workshop.vdf)"

(/home/steam/steamcmd/steamcmd.sh \
    +login $STEAM_USERNAME \
    +workshop_build_item `pwd -P`/workshop.vdf \
    +quit \
) || (
    # https://partner.steamgames.com/doc/features/workshop/implementation#SteamCmd
    echo /home/steam/Steam/logs/stderr.txt
    echo "$(cat /home/steam/Steam/logs/stderr.txt)"
    echo
    echo /home/steam/Steam/logs/workshop_log.txt
    echo "$(cat /home/steam/Steam/logs/workshop_log.txt)"
    echo
    echo /home/steam/Steam/workshopbuilds/depot_build_$1.log
    echo "$(cat /home/steam/Steam/workshopbuilds/depot_build_$1.log)"

    exit 1
)

exit 0
