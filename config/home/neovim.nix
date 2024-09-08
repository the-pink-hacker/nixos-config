{ pkgs, ... }:

{
    programs.neovim = {
         enable = true;
         defaultEditor = true;
         viAlias = true;
         vimAlias = true;
         extraLuaConfig = builtins.readFile ./neovim/extra.lua;
         withPython3 = true;
         withNodeJs = true;
         plugins = with pkgs.vimPlugins; [
     	    rustaceanvim
            nvim-treesitter
            nvim-treesitter-parsers.rust
     	    nvim-treesitter-parsers.json
     	    nvim-treesitter-parsers.toml
     	    nvim-treesitter-parsers.python
     	    nvim-treesitter-parsers.nix
     	    nvim-lspconfig
     	    nvim-dap
     	    nvim-autopairs
     	    plenary-nvim
     	    telescope-nvim
     	    vimagit
     	    nvim-cmp
     	    cmp-nvim-lsp
     	    vim-vsnip
         ];
    };
}
