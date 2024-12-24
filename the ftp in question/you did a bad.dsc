debugthing:
    debug: false
    type: world
    events:
        on script generates error:
        - if <server.online_players_flagged[sendunfunny].size> = 0:
            - stop
        - if <context.queue||null> == null:
            - narrate "<element[<&c>UNKNOWN<&4> die].on_hover[<&f><context.message>]>" targets:<server.online_players_flagged[sendunfunny]>
            - stop
        - if <context.script||null> == null:
            - narrate "<element[<&c><context.queue><&4> die].on_hover[<&f><context.message>]>" targets:<server.online_players_flagged[sendunfunny]>
            - stop
        - else:
            - narrate "<element[<&c><context.script.relative_filename.split[/].last> <&4>die: <&c>line <&l><context.line||UNKNOWN>].on_hover[<element[<&4><context.script.relative_filename.replace_text[<context.script.relative_filename.split[/].last>].with[<&c><context.script.relative_filename.split[/].last>]><n><&f><context.message>]>]>" targets:<server.online_players_flagged[sendunfunny]>
            - stop

toggleunfunny:
    debug: false
    type: command
    name: sendunfunny
    description: "Toggles a debug script"
    aliases:
    - unfunny
    usage: /sendunfunny
    script:
    - if <player.has_flag[sendunfunny]>:
        - flag player sendunfunny:!
        - narrate "<&5>[Denizen] <&d>Debug is now off for you."
        - stop
    - if <player.has_flag[sendunfunny].not>:
        - flag player sendunfunny
        - narrate "<&5>[Denizen] <&d>Debug is now on for you."
        - stop