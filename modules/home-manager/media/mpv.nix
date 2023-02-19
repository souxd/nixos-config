{ config, pkgs, ... }:

{
  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.mpris
      mpvScripts.thumbnail
      mpvScripts.mpv-playlistmanager
      mpvScripts.autoload
      mpvScripts.sponsorblock
    ];
    config = {
      profile = "gpu-hq";
      hwdec = "auto-safe";

      ## VIDEO ##
      vo = "gpu";
      gpu-context = "wayland";

      ## AUDIO ##
      ao = "pipewire";
      audio-channels = "auto-safe";
      af = "lavfi=[dynaudnorm]";

      osc = "no";
      ytdl-format = "bestvideo[height<=?720][fps<=?30][vcodec!=?vp9]+bestaudio/best[height<=?720]";
      script-opts = "ytdl_hook-ytdl_path=~/.nix-profile/bin/yt-dlp";

      keep-open = "yes";
    };
  };
}
