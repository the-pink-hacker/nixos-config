{pkgs, ...}: {
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        extraLuaConfig = builtins.readFile ./neovim/extra.lua;
        withPython3 = true;
        withNodeJs = true;
        coc.enable = true;
        plugins = with pkgs.vimPlugins; [
            rustaceanvim
            nvim-treesitter
            nvim-treesitter-parsers.rust
            nvim-treesitter-parsers.json
            nvim-treesitter-parsers.toml
            nvim-treesitter-parsers.python
            nvim-treesitter-parsers.nix
            nvim-treesitter-parsers.wgsl
            nvim-lspconfig
            nvim-dap
            nvim-autopairs
            plenary-nvim
            telescope-nvim
            vimagit
            nvim-cmp
            cmp-nvim-lsp
            vim-vsnip
            nvim-treesitter-parsers.vue
            coc-vetur
            vim-vue-plugin
            nvim-solarized-lua
        ];
    };

    home.packages = with pkgs; [
        lldb_19
    ];
}
