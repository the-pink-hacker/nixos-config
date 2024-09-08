{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        initExtra = "source ~/.p10k.zsh";
        plugins = [
    	    {
    	        name = "powerlevel10k";
    	        src = pkgs.zsh-powerlevel10k;
    	        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    	    }
        ];

        oh-my-zsh = {
            enable = true;
            plugins = [
    	        "git"
    	        "gh"
    	        "pass"
    	        "rust"
    	    ];
        };
    };
}
