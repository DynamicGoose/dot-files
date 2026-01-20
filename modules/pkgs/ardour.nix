{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ardour

    # Plugins

    # bundles
    lsp-plugins
    calf
    tap-plugins
    distrho-ports

    # synths
    vital
    zynaddsubfx

    # samplers
    drumgizmo
    samplv1
    drumkv1

    # eqs/filters
    eq10q

    # distortion
    wolf-shaper

    # amp sim
    tamgamp-lv2

    # other
    noise-repellent
  ];
}
