styleextra:
  debug: false
  type: world
  events:
    on entity damaged:
    - if <context.damage> >= <context.entity.health_max>:
      - if <context.damager||0> == 0:
        - stop
      - narrate <element[+ ].italicize.bold.color[#FFFFFF]><element[INSTAKILL].italicize.bold.color[#FF8080]> targets:<context.damager>
      - flag <context.damager> stylestatus:<context.damager.flag[stylestatus].add[<context.damage>]>