privatechat:
  debug: false
  type: command
  name: privatechat
  description: toggles no discord spionage chat
  usage: /privatechat
  script:
  - if <player.has_flag[privatechat]>:
    - flag <player> privatechat:!
    - narrate "<&e>[D] <&f>Spionage chattery <&c>off"
    - stop
  - else:
    - flag <player> privatechat:true
    - narrate "<&e>[D] <&f>Spionage chattery <&a>on"
    - stop
privatechathandler:
  debug: false
  type: world
  events:
    on player chats flagged:privatechat bukkit_priority:monitor:
    - determine cancelled passively
    - announce "<&7><&o>spionage: <context.full_text>"
