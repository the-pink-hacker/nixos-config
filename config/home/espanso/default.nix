{
    matches = [
        # === Symbols ===
        # Misc
        {
            trigger = ":...";
            replace = "…";
        }
        {
            trigger = ":<=";
            replace = "≤";
        }
        {
            trigger = ":>=";
            replace = "≥";
        }
        {
            regex = ":(!|/)=";
            replace = "≠";
        }
        {
            trigger = ":~=";
            replace = "≈";
        }
        {
            trigger = ":--";
            replace = "—";
        }
        {
            trigger = ":o~";
            replace = "⧜";
        }
        {
            trigger = ":oo";
            replace = "∞";
        }
        {
            regex = ":o(/|\\|)o";
            replace = "⧞";
        }
        {
            trigger = ":multiply";
            replace = "×";
        }
        {
            trigger = ":divide";
            replace = "÷";
        }
        {
            trigger = ":degree";
            replace = "°";
        }
        {
            trigger = ":tm";
            replace = "™";
        }
        {
            trigger = ":copyright";
            replace = "©";
        }

        # Superscripts
        {
            trigger = ":^0";
            replace = "⁰";
        }
        {
            trigger = ":^1";
            replace = "¹";
        }
        {
            trigger = ":^2";
            replace = "²";
        }
        {
            trigger = ":^3";
            replace = "³";
        }
        {
            trigger = ":^4";
            replace = "⁴";
        }
        {
            trigger = ":^5";
            replace = "⁵";
        }
        {
            trigger = ":^6";
            replace = "⁶";
        }
        {
            trigger = ":^7";
            replace = "⁷";
        }
        {
            trigger = ":^8";
            replace = "⁸";
        }
        {
            trigger = ":^9";
            replace = "⁹";
        }

        # === Emojies ===
        # Hearts
        {
            regex = ":<(\\||/|\\\\)3";
            replace = "💔";
        }
        {
            regex = ":(|red)<3";
            replace = "❤️";
        }
        {
            trigger = ":pink<3";
            replace = "🩷";
        }
        {
            trigger = ":orange<3";
            replace = "🧡";
        }
        {
            trigger = ":yellow<3";
            replace = "💛";
        }
        {
            trigger = ":green<3";
            replace = "💚";
        }
        {
            trigger = ":blue<3";
            replace = "💙";
        }
        {
            regex = ":(azure|aqua|light blue)<3";
            replace = "🩵";
        }
        {
            trigger = ":purple<3";
            replace = "💜";
        }
        {
            trigger = ":brown<3";
            replace = "🤎";
        }
        {
            trigger = ":black<3";
            replace = "🖤";
        }
        {
            regex = ":(gray|grey)<3";
            replace = "🩶";
        }
        {
            trigger = ":white<3";
            replace = "🤍";
        }


        # === Accents ===
        # Aigu
        {
            trigger = ":e'";
            replace = "é";
            propagate_case = true;
        }
        # Cédille
        {
            trigger = ":c~";
            replace = "ç";
            propagate_case = true;
        }
        # Grave
        {
            trigger = ":e`";
            replace = "è";
            propagate_case = true;
        }
        {
            trigger = ":a`";
            replace = "à";
            propagate_case = true;
        }
        {
            trigger = ":i`";
            replace = "ì";
            propagate_case = true;
        }
        {
            trigger = ":o`";
            replace = "ò";
            propagate_case = true;
        }
        {
            trigger = ":u`";
            replace = "ù";
            propagate_case = true;
        }
        # Circonflexe
        {
            trigger = ":a^";
            replace = "â";
            propagate_case = true;
        }
        {
            trigger = ":e^";
            replace = "ê";
            propagate_case = true;
        }
        {
            trigger = ":i^";
            replace = "î";
            propagate_case = true;
        }
        {
            trigger = ":o^";
            replace = "ô";
            propagate_case = true;
        }
        {
            trigger = ":u^";
            replace = "û";
            propagate_case = true;
        }
        # Trema
        {
            trigger = ":e:";
            replace = "ë";
            propagate_case = true;
        }
        {
            trigger = ":i:";
            replace = "ï";
            propagate_case = true;
        }
        {
            trigger = ":u:";
            replace = "ü";
            propagate_case = true;
        }
    ];
}
