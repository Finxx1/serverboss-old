#SS13 Text in Minecraft
chatHandler:
  type: world
  debug: false
  events:
    on player chats:
    - if !<server.has_flag[ss13mode]>:
      - stop
    - define message <context.message>
    # Try and find a valid prefix in the player chat. Things like `.`, '@', `#`, `*`, `;`, `:c` to further narrow down how it'll be parsed.
    - define initrange 15.0
    - define initvolume 2.0
    - define verb says
    - define beginformat <empty>
    - define format <empty>
    - define doRadio 0

    - define prefix <context.message.char_at[1]>
    - if <element[.@,#*;:].contains[<[prefix]>]>:
      - if <[prefix].equals[@]>:
        - define verb emotes
        - define initrange 30.0
      - else if <[prefix].equals[*]>:
        # TODO turn this into a comprehensive list of emotes
        - define verb emotes
        - define initrange 30.0
      - else if <element[,#;:].contains[<[prefix]>]>:
        - define initrange 6.0
        - define initvolume 1.2
        - define verb whispers
        - define beginformat <&7>
        - define format <&o>
      - if <element[;:].contains[<[prefix]>]>:
        # Since this is radio chat, define metavariables.
        - define doRadio <element[1]>
        - if <[prefix].equals[:]>:
          - define shorthandChannel <context.message.char_at[2]>
      - define message <[message].substring[2]>
    
    - if !<[verb].equals[emotes]>:
      # try and find the postfix of the message??? figure out if you need to exclaim/yell/ask/whatever
      - define postfix <context.message.substring[<context.message.length>]>
      - if <element[!?].contains[<[postfix]>]>:
        - if <context.message.ends_with[!!]>:
          - define verb yells
          - define format <bold><&o>
        - else:
          - define verb <map[!=exclaims;?=asks].get[<[postfix]>]>
          # - define format <map[!=<bold>;?=<[format]>].get[<[postfix]>]>
        
    # Find all the potential recipients of the player speaking. (local chat, no prefix)
    - define players <server.online_players>
    - define valids <list[]>
    - define message <[message].substring[1,1].to_sentence_case><[message].substring[2]>
    - if <[message].regex_matches[.*<&lb>a-zA-Zа-яА-Я0-9<&rb>]> && !<[verb].equals[emotes]>:
      - define message <[message]>.
    # Iterate over everything that could possibly relay a message and over every person.
    - foreach <[players]> as:other:
      - define dst <[other].location.distance[<player.location>]>
      - if <[dst].is_less_than[<[initrange]>]>:
        - if <[verb].equals[emotes]>:
          - narrate "<[beginformat]><[format]><player.display_name> <context.message.substring[2]>" targets:<[other]>	
        - else:
          # check if <[other]> can even hear, and if they can, how much and what. Process message accordingly.
          # this would be used for "You hear something...", "You can't hear yourself!" and of course, wall occlusion
          - narrate "<[beginformat]><player.display_name><&r><[beginformat]> <[verb]>, <&dq><[format]><[message]><&r><[beginformat]><&dq>" targets:<[other]>
      - if <[doRadio].equals[1]>:
        - if <[verb].equals[whispers]>:
          - define verb says
          - define format <empty>
        - narrate "<&a><&lb>Common<&rb> <player.display_name><&r> <&a><[verb]>, <&dq><[format]><[message]><&r><&a><&dq>" targets:<[other]>
    - determine cancelled
    # prevent any pesky chat from leaking through