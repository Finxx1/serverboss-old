nicksetter:
    debug: true
    type: command
    name: nick
    description: "Sets your nick, just like old MCNicks."
    aliases:
    - setnick
    usage: /nick
    script:
    - adjust <player> display_name:<context.raw_args.parse_color><&f>
    - flag <player> nickdisplayname:<context.raw_args.parse_color><&f>
    - narrate "<&a>Set nick to <context.raw_args.parse_color>"

onjoinnickset:
    debug: true
    type: world
    events:
        on player join:
        - wait 1s
        - if <player.has_flag[nickdisplayname]>:
            - adjust <player> display_name:<player.flag[nickdisplayname]><&f>