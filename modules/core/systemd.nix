{ config, ... }:
{
  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=524288";
    extraConfig = "DefaultLimitNOFILE=524288";
  };
}
