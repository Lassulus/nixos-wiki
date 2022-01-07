{ config, lib, pkgs, ... }:
{
  services.mediawiki = {
    enable = true;
    name = "NixOS wiki";
    extensions = {
      AuthManagerOAuth = pkgs.fetchFromGitHub {
        owner = "mohe2015";
        repo = "AuthManagerOAuth";
        rev = "v0.1.0";
        sha256 = "sha256-03eu5BgmT0D+GubW8HG28NC7WsbwkJwX0UE0RzZHaCU=";
      };
    };
    extraConfig = ''
      $wgAuthManagerOAuthConfig = [
          'github' => [
              'clientId'                => 'xxx', # TODO get these from somewhere
              'clientSecret'            => 'xxx',
              'urlAuthorize'            => 'https://github.com/login/oauth/authorize',
              'urlAccessToken'          => 'https://github.com/login/oauth/access_token',
              'urlResourceOwnerDetails' => 'https://api.github.com/user'
          ],
      ];
    '';
    passwordFile = "/etc/secrets/mediawiki.pw";
    virtualHost = {
      hostName = "nixos.wiki";
      adminAddr = "admin@nixos.wiki";
      enableACME = true;
      forceSSL = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
