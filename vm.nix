{ config, lib, pkgs, ... }:
{
  imports = [
    ./config.nix
  ];

  services.mediawiki = {
    passwordFile = lib.mkForce (pkgs.writeText "pw" "this_password_is_not_secure");
    virtualHost = {
      hostName = lib.mkForce "localhost:9080";
      enableACME = lib.mkForce false;
      forceSSL = lib.mkForce false;
    };
  };
  services.getty.autologinUser = "root";
  virtualisation.forwardPorts = [
    { host.port = 9080; guest.port = 80; }
  ];
}
