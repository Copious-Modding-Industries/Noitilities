C_Ext = {
    mana_multiplier = 1.0,

    -- Existing functions to edit
    _register_action = register_action,
    _order_deck = order_deck,
}

function state_per_cast()
    C_Ext.mana_multiplier = 1.0;
end

function register_action( state )
    local c = state;
    C_Ext._register_action( c );
    state_per_cast();
    return state;
end

function order_deck()
    C_Ext._order_deck();

    -- when the deck is ordered, go through and make the spells respect mana multiplier
    for _,action in pairs(deck) do
        if action.nt_manamult == nil then
            local base_mana = action.mana or 0;
            action.mana = nil;
            setmetatable( action, {
                __index = function( table, key )
                    if key == "mana" then
                        return base_mana * C_Ext.mana_multiplier;
                    end
                end
            } );
            action.nt_manamult = true;
        end
    end
end