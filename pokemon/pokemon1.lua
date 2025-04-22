local ralts = {
  name = "ralts", 
  poke_custom_prefix = "euclashh",
  pos = {x = 8, y = 2}, 
  config = {extra = {triggers_mod = 1, triggers = 0, odds = 5, Xmult_minus = 0.75,}, evo_rqmt = 5},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'baby'}
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds or 5, center.ability.extra.triggers, center.ability.extra.Xmult_minus}}
  end,
  rarity = 1, 
  cost = 6, 
  stage = "Baby", 
  ptype = "Psychic",
  atlas = "pokedex_3",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        faint_baby_poke(self, card, context)
        return {
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult_minus}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult_minus
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local _card
      if G.consumeables.cards[1] then
        if pseudorandom('ralts') < G.GAME.probabilities.normal/card.ability.extra.odds then
          _card = copy_card(pseudorandom_element({G.consumeables.cards[1]}, pseudoseed('ralts')), nil)
          _card:set_edition({negative = true}, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        else
          return {
            message = "Nope!", 
            colour = G.C.UI.TEXT_INACTIVE,
          }
        end
        if not context.blueprint then
          G.consumeables.cards[1]:remove()
          card.ability.extra.triggers= card.ability.extra.triggers_mod + card.ability.extra.triggers
        end
      end
      return scaling_evo(self, card, context, "j_euclashh_kirlia", card.ability.extra.triggers, self.config.evo_rqmt)
    end
  end,
}

local kirlia = {
  name = "kirlia", 
  poke_custom_prefix = "euclashh",
  pos = {x = 9, y = 2}, 
  config = {extra = {triggers_mod = 1, triggers = 0, odds = 4, hsize = 1,}, evo_rqmt = 5},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {key = 'poke_pink_seal_seal', set = 'Other'}
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds or 4, center.ability.extra.triggers, center.ability.extra.hsize or 0 }}
  end,
  rarity = 3, 
  cost = 8, 
  stage = "2", 
  ptype = "Psychic",
  atlas = "pokedex_3",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint and not card.debuff then
      _card = context.scoring_hand[1]
      local seal_type ="poke_pink_seal"
      _card:set_seal(seal_type, true)
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local _card
      if G.consumeables.cards[1] then
        if pseudorandom('kirlia') < G.GAME.probabilities.normal/card.ability.extra.odds then
          _card = copy_card(pseudorandom_element({G.consumeables.cards[1]}, pseudoseed('kirlia')), nil)
          _card:set_edition({negative = true}, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        else
          return {
            message = "Nope!", 
            colour = G.C.UI.TEXT_INACTIVE,
          }
        end
        if not context.blueprint then
          G.consumeables.cards[1]:remove()
          card.ability.extra.triggers= card.ability.extra.triggers_mod + card.ability.extra.triggers
        end
      end
      return scaling_evo(self, card, context, "j_euclashh_gardevoir", card.ability.extra.triggers, self.config.evo_rqmt)
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.hsize
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.hsize
      return true end }))
  end,
}

local gardevoir = {
  name = "gardevoir", 
  poke_custom_prefix = "euclashh",
  pos = {x = 0, y = 3}, 
  config = {extra = {odds = 3, hsize = 2, Xmult = 1, Xmult_mod = 0.5,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {key = 'poke_pink_seal_seal', set = 'Other'}
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    info_queue[#info_queue + 1] = {set = 'Other', key = 'mega_poke'}
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds or 4, center.ability.extra.hsize or 0, center.ability.extra.Xmult, center.ability.extra.Xmult_mod, (center.ability.extra.Xmult_mod * 2) }}
  end,
  rarity = "poke_safari", 
  cost = 10, 
  stage = "3", 
  ptype = "Psychic",
  atlas = "pokedex_3",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return{
          message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, 
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.Xmult,
          card = card
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local _card
      if G.consumeables.cards[1] then
        if pseudorandom('gardevoir') < G.GAME.probabilities.normal/card.ability.extra.odds then
          _card = copy_card(pseudorandom_element({G.consumeables.cards[1]}, pseudoseed('gardevoir')), nil)
          _card:set_edition({negative = true}, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        else
          return {
            message = "Nope!", 
            colour = G.C.UI.TEXT_INACTIVE,
          }
        end
        if not context.blueprint then
          if G.consumeables.cards[1].ability.set == 'Spectral' then
            card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod * 2)
          else
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          end
          G.consumeables.cards[1]:remove()
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.hsize
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.hsize
      return true end }))
  end,
  megas = {"mega_gardevoir"}
}

local mega_gardevoir = {
  name = "mega_gardevoir", 
  pos = {x = 3, y = 3}, 
  soul_pos = {x = 4, y = 3},
  config = {extra = {odds = 2, hsize = 3,}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {key = 'poke_pink_seal_seal', set = 'Other'}
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    return {vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds or 3, center.ability.extra.hsize,}}
  end,
  rarity = "poke_mega",
  cost = 12,
  stage = "3",
  ptype = "Psychic",
  atlas = "Megas",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      for k, v in pairs(context.scoring_hand) do
        if v.seal == 'poke_pink_seal' then
          print(v.rank, v.suit)
          return {
            message = localize('k_again_ex'),
            repetitions = 1,
            card = card
          }
        end
      end
    end
    if context.end_of_round and not context.individual and not context.repetition and not card.debuff then
      local _card
      if G.consumeables.cards[1] then
        if pseudorandom('mega_gardevoir') < G.GAME.probabilities.normal/card.ability.extra.odds then
          _card = copy_card(pseudorandom_element({G.consumeables.cards[1]}, pseudoseed('mega_gardevoir')), nil)
          _card:set_edition({negative = true}, true)
          _card:add_to_deck()
          G.consumeables:emplace(_card)
        else
          return {
            message = "Nope!", 
            colour = G.C.UI.TEXT_INACTIVE,
          }
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.hsize
      return true end }))
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.E_MANAGER:add_event(Event({func = function()
      G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.hsize
      return true end }))
  end,
}


list = {ralts, kirlia, gardevoir, mega_gardevoir}

return {name = "PokermonPlus1", 
list = list
}
