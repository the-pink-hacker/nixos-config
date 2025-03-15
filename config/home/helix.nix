{ ... }:

{
    programs.helix = {
        enable = true;
        #defaultEditor = true;
        languages = {
            language-server.rust-analyzer = {
                command = "rust-analyzer";
                config.inlayHints = {
                    bindingModeHints.enable = true;
                    closureReturnTypeHints.enable = true;
                    discriminantHints.enable = "fieldless";
                    lifetimeElisionHints.enable = "skip_trivial";
                    typeHints.hideClosureInitialization = false;
                    chainingHints.enable = true;
                };
            };
            language = [
                {
                    name = "rust";
                    auto-format = true;
                }
            ];
        };
        settings = {
            keys.normal = {
                esc = [
                    "collapse_selection"
                    "keep_primary_selection"
                ];
                "$" = "goto_line_end";
                "^" = "goto_first_nonwhitespace";
                "C-r" = "redo";
            };
            editor.lsp.display-inlay-hints = true;
        };
    };
}
