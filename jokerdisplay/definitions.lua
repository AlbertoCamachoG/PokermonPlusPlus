local jd_def = JokerDisplay.Definitions

jd_def["j_euclashh_ralts"] = {
    text = {
        {ref_table ="card.joker_display_values", ref_value = "status", colour = G.C.GREY},
        {ref_table = "card.ability.extra", ref_value = "triggers", colour = G.C.MULT},
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds",colour = G.C.GREEN, scale = 0.3  },
            { ref_table = "card.joker_display_values", ref_value = "trigg",colour = G.C.GREEN, scale = 0.3  },
            { text = ")" },
        },
    },
calc_function = function(card)
    card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } },
    card.joker_display_values.trigg = localize { type = 'variable', key = "trigg", vars = { card.ability.extra.trigger } }
end

jd_def["j_euclashh_gardevoir"] = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" },
            },
        },
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    },
    calc_function = function(card)
        local mult = card.ability.extra.Xmult
        if text ~= 'Unknown' then
            card.joker_display_values.Xmult = math.max(1,mult) 
        end
    end
}

jd_def["j_euclashh_mega_gardevoir"] = {
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        local first_card = scoring_hand and JokerDisplay.calculate_leftmost_card(scoring_hand)
        local second_card = scoring_hand and JokerDisplay.sort_cards(scoring_hand)[2]
        return first_card and playing_card == first_card and
        joker_card.ability.extra.retriggers * JokerDisplay.calculate_joker_triggers(joker_card) or 0 and 
        second_card and playing_card == second_card and
        joker_card.ability.extra.retriggers * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
    }
