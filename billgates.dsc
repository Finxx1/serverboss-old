denizreloading:
  debug: false
  type: world
  events:
    on script reload:
    - if <context.had_error>:
      - playsound <server.online_players> sound:custom.reload_error pitch:1 volume:10 custom
    - else:
      - playsound <server.online_players> sound:custom.reload_correct pitch:1 volume:10 custom
    on tnt primes:
    - determine cancelled passively
#    on player walks:
#    - ratelimit <player> 3t
#    - adjust <player> velocity:<player.velocity.add[<player.flag[velstore]||location[0,0,0]>]>
#e    - flag <player> velstore:<player.velocity>