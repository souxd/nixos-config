# backup tool for incremental local and remote backups
{ config, ... }:

{
  services.borgbackup.jobs."borgbase" = {
    paths = [
      "/var/lib"
      "/home"
    ];
    exclude = [
      # very large paths
      "/var/lib/docker"
      "/var/lib/systemd"
      "/var/lib/libvirt"

    ];
    repo = "w82n33w3@w82n33w3.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /root/borgbackup/passphrase";
    };
    environment.BORG_RSH = "ssh -i /root/borgbackup/ssh_key";
    compression = "auto,zstd";
    startAt = "daily";
  };
}
