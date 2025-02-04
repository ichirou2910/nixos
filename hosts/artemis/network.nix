{
  lib,
  pkgs,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    hostName = "artemis";
    firewall = {
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };

  systemd.user.services.wireguard = {
    enable = true;
    wantedBy = ["default.target"];
    after = ["network-online.target"];
    description = "Connect to WireGuard VPN (Home) after internet is available";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c 'until ping -c 1 -W 1 8.8.8.8; do sleep 2; done; nmcli connection up wg0'
      '';
      ExecStop= ''
        ${pkgs.networkmanager}/bin/nmcli connection down wg0
      '';
      RemainAfterExit=true;
    };
  };
}
