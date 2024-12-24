cmdspy:
    debug: false
    type: command
    name: cmdspy
    description: "Toggles your commandspy"
    aliases:
    - commandspy
    usage: /cmdspy
    script:
    - if <player.has_flag[cmdspy]>:
        - flag player cmdspy:!
        - narrate "<&5>[Denizen] <&d>Commandspy was turned off."
        - stop
    - if <player.has_flag[cmdspy].not>:
        - flag player cmdspy
        - narrate "<&5>[Denizen] <&d>Commandspy was turned on."
        - stop

cspyhandler:
    debug: false
    type: world
    events:
        on command:
        - if <player.name||null> != null:
          - if <player.flag[notthere]||false>:
            - stop
          - if <context.command> == gmv:
            - stop
          - narrate "<&9>Commandspy: <&e><player.name> ran <&2><context.command> <&a><context.raw_args>" targets:<server.online_players.filter[has_flag[cmdspy]].exclude[<player>]>
          - narrate "<&9>(CSPY) <&e><player.name>: <&2><context.command> <&a><context.raw_args>" targets:<server.online_players.filter[has_flag[temcmdspy]].exclude[<player>]>