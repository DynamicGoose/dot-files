{
  systemd = {
    user.extraConfig = "DefaultLimitNOFILE=524288";
    settings.Manager = {
      DefaultLimitNOFILE = 524288;
    };
  };
}
