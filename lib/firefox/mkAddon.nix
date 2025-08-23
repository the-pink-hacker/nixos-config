{
    slug,
    installation_mode ? "force_installed",
}: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
    inherit installation_mode;
}
