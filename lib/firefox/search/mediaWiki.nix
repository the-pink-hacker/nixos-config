{
    url,
    fandomFormat ? false,
    searchURL ? (if fandomFormat then "${url}/wiki/Special:Search" else "${url}/index.php"),
    suggestionNamespaces ? [],
    additionalSuggestionParams ? [],
    iconUpdateURL ? "${url}/favicon.ico",
    updateInterval,
    description,
    definedAliases,
}:

{
    inherit iconUpdateURL;
    inherit updateInterval;
    inherit description;
    inherit definedAliases;

    urls = [
        {
            template = searchURL;
            type = "text/html";
            params = (if !fandomFormat then [{
                    name = "title";
                    value = "Special:Search";
                }] else []) ++ [
                {
                    name = "search";
                    value = "{searchTerms}";
                }
            ];
        }
        {
            template = "${url}/api.php";
            type = "application/x-suggestions+json";
            params = additionalSuggestionParams ++
                (if ((builtins.length suggestionNamespaces) > 0) then [{
                    # namespace=1|2|3
                    name = "namespace";
                    value = builtins.concatStringsSep "|" (builtins.map builtins.toString suggestionNamespaces);
                }] else []) ++ [
                {
                    name = "action";
                    value = "opensearch";
                }
                {
                    name = "search";
                    value = "{searchTerms}";
                }
            ];
        }
    ];
}