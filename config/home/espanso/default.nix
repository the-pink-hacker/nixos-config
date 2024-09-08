{
    matches = [
        # === Symbols ===
        # Misc
        { trigger = ":..."; replace = "…"; }
        { trigger = ":<="; replace = "≤"; }
        { trigger = ":>="; replace = "≥"; }
        { regex = ":(!|/)="; replace = "≠"; }
        { trigger = ":~="; replace = "≈"; }
        { trigger = ":--"; replace = "—"; }
        { trigger = ":o~"; replace = "⧜"; }
        { trigger = ":oo"; replace = "∞"; }
        { regex = ":o(/|\\|)o"; replace = "⧞"; }
        { trigger = ":multiply"; replace = "×"; }
        { trigger = ":divide"; replace = "÷"; }
        { trigger = ":degree"; replace = "°"; }
        
        
        # Superscripts
        { trigger = ":^0"; replace = "⁰"; }
        { trigger = ":^1"; replace = "¹"; }
        { trigger = ":^2"; replace = "²"; }
        { trigger = ":^3"; replace = "³"; }
        { trigger = ":^4"; replace = "⁴"; }
        { trigger = ":^5"; replace = "⁵"; }
        { trigger = ":^6"; replace = "⁶"; }
        { trigger = ":^7"; replace = "⁷"; }
        { trigger = ":^8"; replace = "⁸"; }
        { trigger = ":^9"; replace = "⁹"; }
        
        # === Emojies ===;
        # Hearts;
        { regex = ":<(\\||/|\\\\)3"; replace = "💔"; }
        { regex = ":(|red)<3"; replace = "❤️"; }
        { trigger = ":pink<3"; replace = "🩷"; }
        { trigger = ":orange<3"; replace = "🧡"; }
        { trigger = ":yellow<3"; replace = "💛"; }
        { trigger = ":green<3"; replace = "💚"; }
        { trigger = ":blue<3"; replace = "💙"; }
        { regex = ":(azure|aqua|light blue)<3"; replace = "🩵"; }
        { trigger = ":purple<3"; replace = "💜"; }
        { trigger = ":brown<3"; replace = "🤎"; }
        { trigger = ":black<3"; replace = "🖤"; }
        { regex = ":(gray|grey)<3"; replace = "🩶"; }
        { trigger = ":white<3"; replace = "🤍"; }
    ];
}
