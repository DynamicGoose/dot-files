{ pkgs, username, ... }:
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

  home-manager.users.${username} =
    { pkgs, ... }:
    {
      xdg.configFile."ardour8/ui_config".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <Ardour>
          <UI>
            <Option name="icon-set" value="Papirus-Dark"/>
            <Option name="ui-rc-file" value="clearlooks.rc"/>
            <Option name="ui-font-family" value="Sans"/>
            <Option name="color-file" value="adwaita_dark"/>
            <Option name="flat-buttons" value="1"/>
            <Option name="boxy-buttons" value="0"/>
            <Option name="blink-rec-arm" value="0"/>
            <Option name="blink-alert-indicators" value="1"/>
            <Option name="waveform-gradient-depth" value="0"/>
            <Option name="timeline-item-gradient-depth" value="0.5"/>
            <Option name="all-floating-windows-are-dialogs" value="1"/>
            <Option name="floating-monitor-section" value="0"/>
            <Option name="transients-follow-front" value="0"/>
            <Option name="allow-to-resize-engine-dialog" value="0"/>
            <Option name="color-regions-using-track-color" value="0"/>
            <Option name="use-route-color-widely" value="1"/>
            <Option name="vertical-region-gap" value="0"/>
            <Option name="editor-stereo-only-meters" value="1"/>
            <Option name="show-waveform-clipping" value="1"/>
            <Option name="lock-gui-after-seconds" value="0"/>
            <Option name="screen-saver-mode" value="InhibitWhileRecording"/>
            <Option name="sensitize-playhead" value="0"/>
            <Option name="draggable-playhead-speed" value="0.5"/>
            <Option name="extra-ui-extents-time" value="1"/>
            <Option name="new-automation-points-on-lane" value="0"/>
            <Option name="automation-edit-cancels-auto-hide" value="0"/>
            <Option name="keyboard-layout" value="ansi"/>
            <Option name="keyboard-layout-name" value="ansi"/>
            <Option name="default-bindings" value="ardour"/>
            <Option name="vkeybd-layout" value="QWERTY Single"/>
            <Option name="only-copy-imported-files" value="1"/>
            <Option name="autoplay-files" value="0"/>
            <Option name="autoplay-clips" value="1"/>
            <Option name="highlight-auditioned-clips" value="1"/>
            <Option name="default-narrow_ms" value="0"/>
            <Option name="name-new-markers" value="0"/>
            <Option name="rubberbanding-snaps-to-grid" value="0"/>
            <Option name="font-scale" value="102400"/>
            <Option name="show-waveforms" value="1"/>
            <Option name="show-waveforms-while-recording" value="1"/>
            <Option name="waveform-scale" value="Logarithmic"/>
            <Option name="waveform-shape" value="Traditional"/>
            <Option name="update-editor-during-summary-drag" value="1"/>
            <Option name="never-display-periodic-midi" value="1"/>
            <Option name="sound-midi-notes" value="1"/>
            <Option name="select-last-drawn-note-only" value="1"/>
            <Option name="show-plugin-scan-window" value="0"/>
            <Option name="show-manager-if-plugins-are-missing" value="1"/>
            <Option name="show-zoom-tools" value="1"/>
            <Option name="use-mouse-position-as-zoom-focus-on-scroll" value="1"/>
            <Option name="use-time-rulers-to-zoom-with-vertical-drag" value="0"/>
            <Option name="preview-video-frame-on-drag" value="1"/>
            <Option name="use-double-click-to-zoom-to-selection" value="0"/>
            <Option name="widget-prelight" value="1"/>
            <Option name="use-tooltips" value="1"/>
            <Option name="mixer-element-visibility" value="Input,PhaseInvert,RecMon,SoloIsoLock,Output,Comments"/>
            <Option name="allow-non-quarter-pulse" value="0"/>
            <Option name="show-region-gain" value="0"/>
            <Option name="show-region-xrun-markers" value="1"/>
            <Option name="show-region-cue-markers" value="1"/>
            <Option name="show-name-highlight" value="0"/>
            <Option name="primary-clock-delta-mode" value="NoDelta"/>
            <Option name="secondary-clock-delta-mode" value="NoDelta"/>
            <Option name="clock-display-limit" value="359999"/>
            <Option name="show-track-meters" value="1"/>
            <Option name="follow-edits" value="0"/>
            <Option name="after-section-op" value="SectionSelectRetainAndMovePlayhead"/>
            <Option name="super-rapid-clock-update" value="0"/>
            <Option name="autoscroll-editor" value="1"/>
            <Option name="link-region-and-track-selection" value="0"/>
            <Option name="meter-hold" value="100"/>
            <Option name="meter-vu-standard" value="MeteringVUstandard"/>
            <Option name="meter-line-up-level" value="MeteringLineUp18"/>
            <Option name="meter-line-up-din" value="MeteringLineUp15"/>
            <Option name="input-meter-layout" value="LayoutAutomatic"/>
            <Option name="input-meter-scopes" value="1"/>
            <Option name="meter-peak" value="0"/>
            <Option name="meter-style-led" value="1"/>
            <Option name="show-editor-meter" value="1"/>
            <Option name="show-toolbar-recpunch" value="1"/>
            <Option name="show-toolbar-monitoring" value="0"/>
            <Option name="show-toolbar-selclock" value="1"/>
            <Option name="show-toolbar-latency" value="0"/>
            <Option name="show-toolbar-cuectrl" value="1"/>
            <Option name="show-toolbar-monitor-info" value="0"/>
            <Option name="show-mini-timeline" value="1"/>
            <Option name="show-secondary-clock" value="1"/>
            <Option name="waveform-clip-level" value="-0.093396699999999999"/>
            <Option name="no-new-session-dialog" value="1"/>
            <Option name="buggy-gradients" value="0"/>
            <Option name="cairo-image-surface" value="0"/>
            <Option name="nsgl-view-mode" value="NSGLHiRes"/>
            <Option name="waveform-cache-size" value="100"/>
            <Option name="recent-session-sort" value="7"/>
            <Option name="save-export-analysis-image" value="0"/>
            <Option name="save-export-mixer-screenshot" value="0"/>
            <Option name="open-gui-after-adding-plugin" value="1"/>
            <Option name="plugin-gui-behavior" value="PluginGUIHide"/>
            <Option name="show-inline-display-by-default" value="1"/>
            <Option name="max-plugin-chart" value="10"/>
            <Option name="max-plugin-recent" value="10"/>
            <Option name="prefer-inline-over-gui" value="1"/>
            <Option name="max-inline-controls" value="32"/>
            <Option name="action-table-columns" value="3"/>
            <Option name="hide-splash-screen" value="1"/>
            <Option name="check-announcements," value="1"/>
            <Option name="use-wm-visibility" value="1"/>
            <Option name="use-palette-for-new-track" value="1"/>
            <Option name="use-palette-for-new-bus" value="1"/>
            <Option name="use-palette-for-new-vca" value="0"/>
            <Option name="stripable-color-palette" value="#AA3939:#FFAAAA:#D46A6A:#801515:#550000:#AA8E39:#FFEAAA:#D4BA6A:#806515:#554000:#343477:#8080B3:#565695:#1A1A59:#09093B:#2D882D:#88CC88:#55AA55:#116611:#004400"/>
            <Option name="use-note-bars-for-velocity" value="1"/>
            <Option name="use-note-color-for-velocity" value="1"/>
            <Option name="show-snapped-cursor" value="1"/>
            <Option name="snap-threshold" value="25"/>
            <Option name="ruler-granularity" value="25"/>
            <Option name="snap-target" value="SnapTargetGrid"/>
            <Option name="snap-to-marks" value="1"/>
            <Option name="snap-to-playhead" value="1"/>
            <Option name="snap-to-region-sync" value="1"/>
            <Option name="snap-to-region-start" value="1"/>
            <Option name="snap-to-region-end" value="1"/>
            <Option name="show-selection-marker" value="1"/>
            <Option name="show-grids-ruler" value="1"/>
            <Option name="rulers-follow-grid" value="0"/>
            <Option name="grid-follows-internal" value="0"/>
            <Option name="show-region-name" value="1"/>
            <Option name="time-axis-name-ellipsize-mode" value="0"/>
            <Option name="one-plugin-window-only" value="0"/>
            <Option name="default-lower-midi-note" value="60"/>
            <Option name="default-upper-midi-note" value="71"/>
            <Option name="ask-before-closing-last-window" value="1"/>
            <Option name="ask-cut-copy-section-tempo-map" value="1"/>
            <Option name="freesound-dir" value="/home/gezaa/.cache/ardour8/freesound"/>
            <Option name="max-note-height" value="20"/>
            <Option name="prefer-tap-tempo" value="0"/>
            <Option name="sandbox-all-lua-scripts" value="0"/>
            <Option name="update-action-scripts" value="1"/>
            <Option name="use-cocoa-invalidation" value="1"/>
            <Option name="show-on-cue-page" value="1"/>
            <Option name="insert-at-position" value="3"/>
            <Option name="note-name-display" value="Always"/>
            <Option name="scroll-velocity-editing" value="1"/>
            <Option name="no-strobe" value="0"/>
          </UI>
          <Canvas>
            <Option name="small font" value=" 10"/>
            <Option name="smaller font" value=" 8"/>
            <Option name="normal font" value=" 12"/>
            <Option name="big font" value=" 14"/>
            <Option name="large font" value=" 16"/>
            <Option name="larger font" value=" 20"/>
            <Option name="huger font" value=" 24"/>
            <Option name="massive font" value=" 48"/>
            <Option name="small bold font" value="bold  10"/>
            <Option name="smaller bold font" value="bold  8"/>
            <Option name="normal bold font" value="bold  12"/>
            <Option name="big bold font" value="bold  14"/>
            <Option name="large bold font" value="bold  16"/>
            <Option name="larger bold font" value="bold  20"/>
            <Option name="huger bold font" value="bold  24"/>
            <Option name="massive bold font" value="bold  48"/>
            <Option name="small italic font" value="italic  10"/>
            <Option name="smaller italic font" value="italic  8"/>
            <Option name="normal italic font" value="italic  12"/>
            <Option name="big italic font" value="italic  14"/>
            <Option name="large italic font" value="italic  16"/>
            <Option name="larger italic font" value="italic  20"/>
            <Option name="huger italic font" value="italic  24"/>
            <Option name="massive italic font" value="italic  48"/>
            <Option name="small monospace font" value="ArdourMono  10"/>
            <Option name="smaller monospace font" value="ArdourMono  8"/>
            <Option name="normal monospace font" value="ArdourMono  12"/>
            <Option name="big monospace font" value="ArdourMono  14"/>
            <Option name="large monospace font" value="ArdourMono  16"/>
            <Option name="larger monospace font" value="ArdourMono  20"/>
            <Option name="huger monospace font" value="ArdourMono  24"/>
            <Option name="massive monospace font" value="ArdourMono  48"/>
            <Option name="small bold monospace font" value="bold ArdourMono  10"/>
            <Option name="smaller bold monospace font" value="bold ArdourMono  8"/>
            <Option name="normal bold monospace font" value="bold ArdourMono  12"/>
            <Option name="big bold monospace font" value="bold ArdourMono  14"/>
            <Option name="large bold monospace font" value="bold ArdourMono  16"/>
            <Option name="larger bold monospace font" value="bold ArdourMono  20"/>
            <Option name="huger bold monospace font" value="bold ArdourMono  24"/>
            <Option name="massive bold monospace font" value="bold ArdourMono  48"/>
          </Canvas>
        </Ardour>
      '';
      xdg.configFile."ardour8/my-adwaita_dark-ardour-8.12.colors".text = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <Ardour>
          <Colors>
            <Color name="alert:blue" value="3584e4ff"/>
            <Color name="alert:cyan" value="62a0eaff"/>
            <Color name="alert:green" value="2ec27eff"/>
            <Color name="alert:greenish" value="459952ff"/>
            <Color name="alert:orange" value="ff7800ff"/>
            <Color name="alert:red" value="c01c28ff"/>
            <Color name="alert:ruddy" value="e03131ff"/>
            <Color name="alert:yellow" value="f5c211ff"/>
            <Color name="meter color0" value="008800ff"/>
            <Color name="meter color1" value="00aa00ff"/>
            <Color name="meter color2" value="00ff00ff"/>
            <Color name="meter color3" value="00ff00ff"/>
            <Color name="meter color4" value="fff000ff"/>
            <Color name="meter color5" value="fff000ff"/>
            <Color name="meter color6" value="ff8800ff"/>
            <Color name="meter color7" value="ff8800ff"/>
            <Color name="meter color8" value="ff0000ff"/>
            <Color name="meter color9" value="ff0000ff"/>
            <Color name="midi meter 52" value="f8e45cff"/>
            <Color name="midi meter 53" value="f8e45cff"/>
            <Color name="midi meter 54" value="f6d32dff"/>
            <Color name="midi meter 55" value="f6d32dff"/>
            <Color name="midi meter 56" value="f5c211ff"/>
            <Color name="neutral:background" value="0f0f0fff"/>
            <Color name="neutral:background2" value="161616fe"/>
            <Color name="neutral:backgroundest" value="191919ff"/>
            <Color name="neutral:foreground" value="e0e0e0ff"/>
            <Color name="neutral:foreground2" value="484848ff"/>
            <Color name="neutral:foregroundest" value="f8f9faff"/>
            <Color name="neutral:midground" value="3f3f3fff"/>
            <Color name="theme:bg" value="0f0f0fff"/>
            <Color name="theme:bg1" value="161616ff"/>
            <Color name="theme:bg2" value="191919ff"/>
            <Color name="theme:contrasting" value="e03535ff"/>
            <Color name="theme:contrasting alt" value="fd7e14ff"/>
            <Color name="theme:contrasting clock" value="e0e0e0ff"/>
            <Color name="theme:contrasting less" value="4c4c4cff"/>
            <Color name="theme:contrasting selection" value="e0e0e0ff"/>
            <Color name="widget:bg" value="1f1f1fff"/>
            <Color name="widget:blue" value="3584e4ff"/>
            <Color name="widget:blue darker" value="495057ff"/>
            <Color name="widget:blue lighter" value="628db4ff"/>
            <Color name="widget:gray" value="3f3f3fff"/>
            <Color name="widget:green" value="35e035ff"/>
            <Color name="widget:green darker" value="3f3f3fff"/>
            <Color name="widget:green lighter" value="57e389ff"/>
            <Color name="widget:orange" value="fd7e14ff"/>
            <Color name="widget:ruddy" value="087f5bff"/>
            <Color name="widget:yellow" value="f5c211ff"/>
          </Colors>
          <ColorAliases>
            <ColorAlias name="active crossfade" alias="neutral:foreground"/>
            <ColorAlias name="arrange base" alias="theme:bg1"/>
            <ColorAlias name="arrangement marker bar" alias="neutral:background2"/>
            <ColorAlias name="arrangement rect" alias="widget:blue"/>
            <ColorAlias name="arrangement rect alt" alias="widget:blue darker"/>
            <ColorAlias name="audio automation track fill" alias="theme:bg"/>
            <ColorAlias name="audio bus base" alias="neutral:background"/>
            <ColorAlias name="audio master bus base" alias="neutral:backgroundest"/>
            <ColorAlias name="audio track base" alias="neutral:background"/>
            <ColorAlias name="automation line" alias="alert:green"/>
            <ColorAlias name="automation track outline" alias="theme:bg2"/>
            <ColorAlias name="big clock active: background" alias="neutral:backgroundest"/>
            <ColorAlias name="big clock active: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="big clock active: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="big clock active: text" alias="alert:red"/>
            <ColorAlias name="big clock active:gtk_somewhat_bright_indicator background" alias="neutral:backgroundest"/>
            <ColorAlias name="big clock: background" alias="theme:bg2"/>
            <ColorAlias name="big clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="big clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="big clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="border color" alias="neutral:backgroundest"/>
            <ColorAlias name="cd marker bar" alias="neutral:background2"/>
            <ColorAlias name="clipped waveform" alias="alert:red"/>
            <ColorAlias name="clock: background" alias="theme:bg2"/>
            <ColorAlias name="clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="comment button: fill" alias="widget:bg"/>
            <ColorAlias name="control point fill" alias="alert:green"/>
            <ColorAlias name="control point outline" alias="alert:blue"/>
            <ColorAlias name="control point selected fill" alias="alert:orange"/>
            <ColorAlias name="control point selected outline" alias="alert:red"/>
            <ColorAlias name="covered region" alias="neutral:background2"/>
            <ColorAlias name="crossfade editor base" alias="neutral:foreground2"/>
            <ColorAlias name="crossfade editor line" alias="neutral:backgroundest"/>
            <ColorAlias name="crossfade editor line shading" alias="widget:blue"/>
            <ColorAlias name="crossfade editor point fill" alias="alert:green"/>
            <ColorAlias name="crossfade editor point outline" alias="alert:blue"/>
            <ColorAlias name="crossfade editor wave" alias="neutral:foregroundest"/>
            <ColorAlias name="crossfade line" alias="neutral:backgroundest"/>
            <ColorAlias name="edit point" alias="alert:blue"/>
            <ColorAlias name="entered automation line" alias="widget:orange"/>
            <ColorAlias name="entered gain line" alias="widget:orange"/>
            <ColorAlias name="entered marker" alias="widget:orange"/>
            <ColorAlias name="fader outline" alias="neutral:backgroundest"/>
            <ColorAlias name="feedback alert: alt active" alias="alert:ruddy"/>
            <ColorAlias name="feedback alert: fill" alias="widget:bg"/>
            <ColorAlias name="feedback alert: fill active" alias="alert:red"/>
            <ColorAlias name="feedback alert: led active" alias="alert:red"/>
            <ColorAlias name="foldback knob" alias="widget:bg"/>
            <ColorAlias name="foldback knob: arc end" alias="widget:blue"/>
            <ColorAlias name="foldback knob: arc start" alias="widget:blue"/>
            <ColorAlias name="foldback knob: fill" alias="widget:bg"/>
            <ColorAlias name="foldback postfader: fill" alias="widget:green"/>
            <ColorAlias name="foldback postfader: fill active" alias="widget:green"/>
            <ColorAlias name="foldback postfader: led active" alias="alert:green"/>
            <ColorAlias name="foldback prefader: fill" alias="alert:cyan"/>
            <ColorAlias name="foldback prefader: fill active" alias="alert:cyan"/>
            <ColorAlias name="foldback prefader: led active" alias="alert:green"/>
            <ColorAlias name="frame handle" alias="theme:bg1"/>
            <ColorAlias name="gain line" alias="alert:blue"/>
            <ColorAlias name="gain line inactive" alias="theme:bg1"/>
            <ColorAlias name="generic button: fill" alias="widget:bg"/>
            <ColorAlias name="generic button: fill active" alias="alert:red"/>
            <ColorAlias name="generic button: led active" alias="alert:blue"/>
            <ColorAlias name="generic button: outline" alias="theme:bg2"/>
            <ColorAlias name="ghost track base" alias="widget:green lighter"/>
            <ColorAlias name="ghost track midi outline" alias="neutral:backgroundest"/>
            <ColorAlias name="ghost track wave" alias="neutral:midground"/>
            <ColorAlias name="ghost track wave clip" alias="neutral:background"/>
            <ColorAlias name="ghost track wave fill" alias="neutral:midground"/>
            <ColorAlias name="ghost track zero line" alias="neutral:backgroundest"/>
            <ColorAlias name="grid line major" alias="neutral:foreground2"/>
            <ColorAlias name="grid line micro" alias="widget:bg"/>
            <ColorAlias name="grid line minor" alias="widget:blue darker"/>
            <ColorAlias name="gtk_arm" alias="alert:red"/>
            <ColorAlias name="gtk_audio_bus" alias="neutral:background"/>
            <ColorAlias name="gtk_audio_track" alias="theme:bg1"/>
            <ColorAlias name="gtk_automation_track_header" alias="theme:bg"/>
            <ColorAlias name="gtk_background" alias="theme:bg"/>
            <ColorAlias name="gtk_bases" alias="theme:bg2"/>
            <ColorAlias name="gtk_bg_selected" alias="theme:contrasting selection"/>
            <ColorAlias name="gtk_bg_tooltip" alias="theme:bg2"/>
            <ColorAlias name="gtk_bright_color" alias="widget:blue darker"/>
            <ColorAlias name="gtk_bright_indicator" alias="alert:red"/>
            <ColorAlias name="gtk_clip_indicator" alias="alert:red"/>
            <ColorAlias name="gtk_contrasting_indicator" alias="theme:contrasting selection"/>
            <ColorAlias name="gtk_control_master" alias="theme:bg1"/>
            <ColorAlias name="gtk_control_text" alias="neutral:foreground"/>
            <ColorAlias name="gtk_control_text2" alias="alert:ruddy"/>
            <ColorAlias name="gtk_darkest" alias="theme:bg"/>
            <ColorAlias name="gtk_entry_cursor" alias="alert:red"/>
            <ColorAlias name="gtk_fg_selected" alias="theme:bg"/>
            <ColorAlias name="gtk_fg_tooltip" alias="neutral:foregroundest"/>
            <ColorAlias name="gtk_foldback_bg" alias="theme:bg1"/>
            <ColorAlias name="gtk_foreground" alias="neutral:foregroundest"/>
            <ColorAlias name="gtk_light_text_on_dark" alias="neutral:foreground2"/>
            <ColorAlias name="gtk_lightest" alias="neutral:foregroundest"/>
            <ColorAlias name="gtk_midi_channel_selector" alias="widget:blue"/>
            <ColorAlias name="gtk_midi_track" alias="neutral:background2"/>
            <ColorAlias name="gtk_monitor" alias="alert:orange"/>
            <ColorAlias name="gtk_mono" alias="neutral:foreground"/>
            <ColorAlias name="gtk_mute" alias="alert:yellow"/>
            <ColorAlias name="gtk_not_so_bright_indicator" alias="theme:contrasting"/>
            <ColorAlias name="gtk_processor_fader" alias="widget:gray"/>
            <ColorAlias name="gtk_processor_fader_frame" alias="neutral:midground"/>
            <ColorAlias name="gtk_processor_frame_selected" alias="theme:contrasting"/>
            <ColorAlias name="gtk_processor_postfader" alias="widget:green"/>
            <ColorAlias name="gtk_processor_postfader_frame" alias="widget:green"/>
            <ColorAlias name="gtk_processor_prefader" alias="widget:ruddy"/>
            <ColorAlias name="gtk_processor_prefader_frame" alias="widget:ruddy"/>
            <ColorAlias name="gtk_send_bg" alias="theme:bg1"/>
            <ColorAlias name="gtk_send_fg" alias="widget:blue"/>
            <ColorAlias name="gtk_solo" alias="alert:green"/>
            <ColorAlias name="gtk_somewhat_bright_indicator" alias="theme:contrasting alt"/>
            <ColorAlias name="gtk_texts" alias="neutral:foregroundest"/>
            <ColorAlias name="gtk_track_header_inactive" alias="theme:bg"/>
            <ColorAlias name="gtk_track_header_selected" alias="theme:contrasting less"/>
            <ColorAlias name="image track" alias="neutral:foreground2"/>
            <ColorAlias name="inactive crossfade" alias="theme:contrasting"/>
            <ColorAlias name="inactive fade handle" alias="neutral:foreground2"/>
            <ColorAlias name="inactive group tab" alias="theme:bg"/>
            <ColorAlias name="invert button: fill" alias="widget:bg"/>
            <ColorAlias name="invert button: fill active" alias="alert:blue"/>
            <ColorAlias name="invert button: led active" alias="alert:blue"/>
            <ColorAlias name="latency button: fill" alias="widget:bg"/>
            <ColorAlias name="latency button: fill active" alias="alert:ruddy"/>
            <ColorAlias name="latency button: led active" alias="alert:ruddy"/>
            <ColorAlias name="location arrangement marker" alias="theme:contrasting alt"/>
            <ColorAlias name="location cd marker" alias="widget:blue"/>
            <ColorAlias name="location loop" alias="alert:green"/>
            <ColorAlias name="location marker" alias="alert:yellow"/>
            <ColorAlias name="location punch" alias="alert:red"/>
            <ColorAlias name="location range" alias="alert:blue"/>
            <ColorAlias name="lock button: fill active" alias="widget:bg"/>
            <ColorAlias name="lock button: led active" alias="alert:red"/>
            <ColorAlias name="lua action button: fill" alias="widget:bg"/>
            <ColorAlias name="mapping bar" alias="neutral:background2"/>
            <ColorAlias name="marker bar" alias="neutral:background2"/>
            <ColorAlias name="marker bar separator" alias="theme:bg2"/>
            <ColorAlias name="marker drag line" alias="theme:contrasting clock"/>
            <ColorAlias name="marker label" alias="neutral:backgroundest"/>
            <ColorAlias name="marker track" alias="neutral:foreground2"/>
            <ColorAlias name="master monitor section button active: fill" alias="widget:ruddy"/>
            <ColorAlias name="master monitor section button active: fill active" alias="alert:yellow"/>
            <ColorAlias name="master monitor section button normal: fill active" alias="widget:bg"/>
            <ColorAlias name="measure line bar" alias="neutral:foregroundest"/>
            <ColorAlias name="measure line beat" alias="widget:blue"/>
            <ColorAlias name="meter background bottom" alias="neutral:midground"/>
            <ColorAlias name="meter background top" alias="neutral:background"/>
            <ColorAlias name="meter bar" alias="theme:bg1"/>
            <ColorAlias name="meter color BBC" alias="alert:orange"/>
            <ColorAlias name="meter marker" alias="widget:orange"/>
            <ColorAlias name="meter marker music" alias="widget:orange"/>
            <ColorAlias name="meter outline" alias="neutral:backgroundest"/>
            <ColorAlias name="meterbridge label: fill" alias="theme:bg"/>
            <ColorAlias name="meterbridge label: fill active" alias="neutral:background2"/>
            <ColorAlias name="meterbridge label: led" alias="alert:red"/>
            <ColorAlias name="meterbridge label: led active" alias="alert:red"/>
            <ColorAlias name="meterbridge peakindicator: fill" alias="widget:bg"/>
            <ColorAlias name="meterbridge peakindicator: fill active" alias="alert:red"/>
            <ColorAlias name="meterbridge peakindicator: led" alias="alert:red"/>
            <ColorAlias name="meterbridge peakindicator: led active" alias="alert:red"/>
            <ColorAlias name="meterbridge peaklabel" alias="alert:red"/>
            <ColorAlias name="meterstrip dpm bg" alias="theme:bg2"/>
            <ColorAlias name="meterstrip dpm fg" alias="neutral:foreground2"/>
            <ColorAlias name="meterstrip ppm bg" alias="theme:bg2"/>
            <ColorAlias name="meterstrip ppm fg" alias="neutral:foreground2"/>
            <ColorAlias name="meterstrip vu bg" alias="theme:contrasting"/>
            <ColorAlias name="meterstrip vu fg" alias="neutral:backgroundest"/>
            <ColorAlias name="midi automation track fill" alias="widget:green darker"/>
            <ColorAlias name="midi bus base" alias="neutral:backgroundest"/>
            <ColorAlias name="midi device: fill" alias="widget:bg"/>
            <ColorAlias name="midi device: fill active" alias="theme:bg"/>
            <ColorAlias name="midi device: led active" alias="alert:green"/>
            <ColorAlias name="midi input button: fill active" alias="alert:green"/>
            <ColorAlias name="midi input button: led active" alias="alert:red"/>
            <ColorAlias name="midi meter color0" alias="midi meter 52"/>
            <ColorAlias name="midi meter color1" alias="midi meter 53"/>
            <ColorAlias name="midi meter color2" alias="midi meter 53"/>
            <ColorAlias name="midi meter color3" alias="midi meter 54"/>
            <ColorAlias name="midi meter color4" alias="midi meter 54"/>
            <ColorAlias name="midi meter color5" alias="midi meter 55"/>
            <ColorAlias name="midi meter color6" alias="midi meter 55"/>
            <ColorAlias name="midi meter color7" alias="midi meter 56"/>
            <ColorAlias name="midi meter color8" alias="midi meter 56"/>
            <ColorAlias name="midi meter color9" alias="midi meter 56"/>
            <ColorAlias name="midi note inactive channel" alias="neutral:backgroundest"/>
            <ColorAlias name="midi note max" alias="alert:green"/>
            <ColorAlias name="midi note mid" alias="alert:yellow"/>
            <ColorAlias name="midi note min" alias="alert:orange"/>
            <ColorAlias name="midi note selected" alias="widget:ruddy"/>
            <ColorAlias name="midi note selected outline" alias="neutral:foregroundest"/>
            <ColorAlias name="midi note velocity text" alias="theme:contrasting"/>
            <ColorAlias name="midi patch change fill" alias="theme:contrasting selection"/>
            <ColorAlias name="midi patch change outline" alias="neutral:foreground"/>
            <ColorAlias name="midi select rect outline" alias="alert:red"/>
            <ColorAlias name="midi sysex fill" alias="theme:contrasting"/>
            <ColorAlias name="midi sysex outline" alias="theme:contrasting alt"/>
            <ColorAlias name="midi track base" alias="widget:green darker"/>
            <ColorAlias name="mixer strip button: fill" alias="widget:bg"/>
            <ColorAlias name="mixer strip button: fill active" alias="alert:orange"/>
            <ColorAlias name="mixer strip button: led active" alias="alert:green"/>
            <ColorAlias name="mixer strip name button: fill active" alias="theme:bg2"/>
            <ColorAlias name="mixer strip name button: led active" alias="alert:green"/>
            <ColorAlias name="monitor button: fill" alias="widget:bg"/>
            <ColorAlias name="monitor button: fill active" alias="alert:orange"/>
            <ColorAlias name="monitor button: led active" alias="alert:ruddy"/>
            <ColorAlias name="monitor section button: fill" alias="widget:bg"/>
            <ColorAlias name="monitor section dim: fill" alias="widget:bg"/>
            <ColorAlias name="monitor section dim: fill active" alias="alert:orange"/>
            <ColorAlias name="monitor section dim: led active" alias="alert:green"/>
            <ColorAlias name="monitor section knob" alias="widget:bg"/>
            <ColorAlias name="monitor section knob: arc end" alias="widget:blue"/>
            <ColorAlias name="monitor section knob: arc start" alias="widget:blue"/>
            <ColorAlias name="monitor section mono: fill" alias="widget:bg"/>
            <ColorAlias name="monitor section mono: fill active" alias="alert:blue"/>
            <ColorAlias name="monitor section mono: led active" alias="alert:green"/>
            <ColorAlias name="monitor section processors present: fill" alias="alert:orange"/>
            <ColorAlias name="monitor section processors toggle: fill" alias="theme:bg"/>
            <ColorAlias name="monitor section processors toggle: fill active" alias="theme:bg"/>
            <ColorAlias name="monitor section solo model: fill" alias="widget:bg"/>
            <ColorAlias name="monitor section solo model: fill active" alias="theme:bg"/>
            <ColorAlias name="monitor section solo model: led active" alias="alert:green"/>
            <ColorAlias name="monitor section solo model:punch button: fill active fill" alias="widget:bg"/>
            <ColorAlias name="monitor section solo option: fill" alias="widget:bg"/>
            <ColorAlias name="monitor section solo option: fill active" alias="theme:bg"/>
            <ColorAlias name="monitor section solo option: led active" alias="alert:green"/>
            <ColorAlias name="mono panner bg" alias="theme:bg2"/>
            <ColorAlias name="mono panner fill" alias="widget:blue"/>
            <ColorAlias name="mono panner outline" alias="theme:bg"/>
            <ColorAlias name="mono panner position fill" alias="neutral:foreground2"/>
            <ColorAlias name="mono panner position outline" alias="theme:bg"/>
            <ColorAlias name="mono panner text" alias="neutral:backgroundest"/>
            <ColorAlias name="mouse mode button: fill" alias="widget:bg"/>
            <ColorAlias name="mouse mode button: fill active" alias="alert:blue"/>
            <ColorAlias name="mouse mode button: led active" alias="alert:green"/>
            <ColorAlias name="mute button: fill" alias="widget:bg"/>
            <ColorAlias name="mute button: fill active" alias="alert:yellow"/>
            <ColorAlias name="mute button: led active" alias="alert:yellow"/>
            <ColorAlias name="name highlight fill" alias="alert:blue"/>
            <ColorAlias name="name highlight outline" alias="theme:bg1"/>
            <ColorAlias name="nudge button: fill" alias="widget:bg"/>
            <ColorAlias name="nudge button: fill active" alias="widget:bg"/>
            <ColorAlias name="nudge button: led active" alias="alert:green"/>
            <ColorAlias name="nudge clock: background" alias="theme:bg2"/>
            <ColorAlias name="nudge clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="nudge clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="nudge clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="page switch button: fill" alias="widget:bg"/>
            <ColorAlias name="page switch button: fill active" alias="alert:blue"/>
            <ColorAlias name="pan knob" alias="widget:bg"/>
            <ColorAlias name="pan knob: arc end" alias="widget:orange"/>
            <ColorAlias name="pan knob: arc start" alias="widget:orange"/>
            <ColorAlias name="patch change button unnamed: fill" alias="neutral:background2"/>
            <ColorAlias name="patch change button unnamed: fill active" alias="widget:blue"/>
            <ColorAlias name="patch change button: fill" alias="widget:bg"/>
            <ColorAlias name="patch change button: fill acpunch button: fill activetive" alias="widget:blue"/>
            <ColorAlias name="patch change button: fill active" alias="widget:blue"/>
            <ColorAlias name="piano key black" alias="neutral:background2"/>
            <ColorAlias name="piano key highlight" alias="alert:ruddy"/>
            <ColorAlias name="piano key white" alias="neutral:foreground"/>
            <ColorAlias name="piano roll black" alias="theme:bg2"/>
            <ColorAlias name="piano roll black outline" alias="neutral:background"/>
            <ColorAlias name="piano roll white" alias="neutral:foreground"/>
            <ColorAlias name="pinrouting custom: led active" alias="alert:ruddy"/>
            <ColorAlias name="pinrouting sidechain: led active" alias="alert:green"/>
            <ColorAlias name="play head" alias="theme:contrasting"/>
            <ColorAlias name="plugin automation state button: fill active" alias="alert:orange"/>
            <ColorAlias name="plugin bypass button: led active" alias="alert:red"/>
            <ColorAlias name="pluginlist filter button: fill active" alias="widget:bg"/>
            <ColorAlias name="pluginlist hide button: led active" alias="alert:cyan"/>
            <ColorAlias name="pluginlist radio button: led active" alias="alert:cyan"/>
            <ColorAlias name="pluginui toggle: fill" alias="widget:bg"/>
            <ColorAlias name="pluginui toggle: fill active" alias="widget:blue"/>
            <ColorAlias name="preference highlight" alias="alert:yellow"/>
            <ColorAlias name="processor automation line" alias="alert:green"/>
            <ColorAlias name="processor auxfeedback: fill" alias="theme:contrasting alt"/>
            <ColorAlias name="processor auxfeedback: led active" alias="alert:green"/>
            <ColorAlias name="processor control button: fill" alias="neutral:background"/>
            <ColorAlias name="processor control button: fill active" alias="neutral:background2"/>
            <ColorAlias name="processor control button: led active" alias="widget:blue"/>
            <ColorAlias name="processor control knob" alias="theme:bg"/>
            <ColorAlias name="processor control knob: arc end" alias="widget:blue"/>
            <ColorAlias name="processor control knob: arc start" alias="widget:blue"/>
            <ColorAlias name="processor fader: fill" alias="alert:blue"/>
            <ColorAlias name="processor fader: fill active" alias="alert:blue"/>
            <ColorAlias name="processor fader: led active" alias="alert:green"/>
            <ColorAlias name="processor postfader: fill" alias="widget:green"/>
            <ColorAlias name="processor postfader: fill active" alias="widget:green"/>
            <ColorAlias name="processor postfader: led active" alias="alert:green"/>
            <ColorAlias name="processor prefader: fill" alias="widget:ruddy"/>
            <ColorAlias name="processor prefader: fill active" alias="widget:ruddy"/>
            <ColorAlias name="processor prefader: led active" alias="alert:green"/>
            <ColorAlias name="processor sidechain: fill" alias="alert:orange"/>
            <ColorAlias name="processor sidechain: led active" alias="alert:green"/>
            <ColorAlias name="processor stub: fill" alias="neutral:background2"/>
            <ColorAlias name="processor stub: fill active" alias="neutral:background2"/>
            <ColorAlias name="punch button: fill" alias="widget:bg"/>
            <ColorAlias name="punch button: fill active" alias="alert:ruddy"/>
            <ColorAlias name="punch button: led active" alias="alert:red"/>
            <ColorAlias name="punch clock: background" alias="theme:bg2"/>
            <ColorAlias name="punch clock: cursor" alias="alert:ruddy"/>
            <ColorAlias name="punch clock: edited text" alias="alert:ruddy"/>
            <ColorAlias name="punch clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="punch line" alias="alert:ruddy"/>
            <ColorAlias name="range drag bar rect" alias="neutral:midground"/>
            <ColorAlias name="range drag rect" alias="alert:ruddy"/>
            <ColorAlias name="range marker bar" alias="neutral:background2"/>
            <ColorAlias name="record enable button: fill active" alias="alert:ruddy"/>
            <ColorAlias name="record enable button: led active" alias="alert:red"/>
            <ColorAlias name="recording note" alias="neutral:foregroundest"/>
            <ColorAlias name="recording rect" alias="alert:ruddy"/>
            <ColorAlias name="recording waveform fill" alias="neutral:foregroundest"/>
            <ColorAlias name="recording waveform outline" alias="neutral:foregroundest"/>
            <ColorAlias name="region automation line" alias="alert:blue"/>
            <ColorAlias name="region list automatic" alias="theme:contrasting less"/>
            <ColorAlias name="region list missing source" alias="alert:red"/>
            <ColorAlias name="region list whole file" alias="neutral:foreground"/>
            <ColorAlias name="region mark" alias="theme:contrasting alt"/>
            <ColorAlias name="route button: fill" alias="widget:bg"/>
            <ColorAlias name="route button: fill active" alias="theme:bg2"/>
            <ColorAlias name="route button: led active" alias="alert:green"/>
            <ColorAlias name="route rec button: led active" alias="alert:red"/>
            <ColorAlias name="rubber band rect" alias="neutral:foreground2"/>
            <ColorAlias name="rude audition: fill" alias="widget:bg"/>
            <ColorAlias name="rude audition: fill active" alias="alert:ruddy"/>
            <ColorAlias name="rude audition: led active" alias="alert:red"/>
            <ColorAlias name="rude isolate: fill" alias="widget:bg"/>
            <ColorAlias name="rude isolate: fill active" alias="theme:contrasting alt"/>
            <ColorAlias name="rude isolate: led active" alias="alert:red"/>
            <ColorAlias name="rude solo: fill" alias="widget:bg"/>
            <ColorAlias name="rude solo: fill active" alias="alert:ruddy"/>
            <ColorAlias name="rude solo: led active" alias="alert:red"/>
            <ColorAlias name="ruler base" alias="theme:bg2"/>
            <ColorAlias name="ruler text" alias="neutral:foreground2"/>
            <ColorAlias name="scroomer" alias="neutral:foreground"/>
            <ColorAlias name="secondary clock: background" alias="theme:bg2"/>
            <ColorAlias name="secondary clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="secondary clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="secondary clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="secondary delta clock: background" alias="theme:bg2"/>
            <ColorAlias name="secondary delta clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="secondary delta clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="secondary delta clock: text" alias="theme:contrasting alt"/>
            <ColorAlias name="selected midi note frame" alias="alert:ruddy"/>
            <ColorAlias name="selected region base" alias="alert:ruddy"/>
            <ColorAlias name="selected time axis frame" alias="alert:ruddy"/>
            <ColorAlias name="selected waveform fill" alias="alert:orange"/>
            <ColorAlias name="selected waveform outline" alias="theme:bg2"/>
            <ColorAlias name="selection" alias="alert:red"/>
            <ColorAlias name="selection clock: background" alias="theme:bg2"/>
            <ColorAlias name="selection clock: cursor" alias="alert:ruddy"/>
            <ColorAlias name="selection clock: edited text" alias="alert:ruddy"/>
            <ColorAlias name="selection clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="selection rect" alias="theme:contrasting less"/>
            <ColorAlias name="send alert button: fill" alias="neutral:foreground"/>
            <ColorAlias name="send alert button: fill active" alias="alert:cyan"/>
            <ColorAlias name="send alert button: led active" alias="alert:red"/>
            <ColorAlias name="send bg" alias="neutral:backgroundest"/>
            <ColorAlias name="send pan" alias="theme:contrasting alt"/>
            <ColorAlias name="shuttle" alias="widget:bg"/>
            <ColorAlias name="shuttle bg" alias="neutral:backgroundest"/>
            <ColorAlias name="silence" alias="theme:contrasting alt"/>
            <ColorAlias name="silence text" alias="neutral:foreground"/>
            <ColorAlias name="solo button: fill" alias="widget:bg"/>
            <ColorAlias name="solo button: fill active" alias="alert:green"/>
            <ColorAlias name="solo button: led active" alias="alert:green"/>
            <ColorAlias name="solo isolate: fill" alias="widget:bg"/>
            <ColorAlias name="solo isolate: fill active" alias="widget:bg"/>
            <ColorAlias name="solo isolate: led active" alias="alert:ruddy"/>
            <ColorAlias name="solo safe: fill" alias="widget:bg"/>
            <ColorAlias name="solo safe: fill active" alias="widget:bg"/>
            <ColorAlias name="solo safe: led active" alias="alert:ruddy"/>
            <ColorAlias name="stereo panner bg" alias="theme:bg2"/>
            <ColorAlias name="stereo panner fill" alias="widget:blue"/>
            <ColorAlias name="stereo panner inverted bg" alias="theme:bg2"/>
            <ColorAlias name="stereo panner inverted fill" alias="theme:contrasting less"/>
            <ColorAlias name="stereo panner inverted outline" alias="alert:ruddy"/>
            <ColorAlias name="stereo panner inverted text" alias="neutral:backgroundest"/>
            <ColorAlias name="stereo panner mono bg" alias="theme:bg2"/>
            <ColorAlias name="stereo panner mono fill" alias="alert:orange"/>
            <ColorAlias name="stereo panner mono outline" alias="alert:orange"/>
            <ColorAlias name="stereo panner mono text" alias="neutral:backgroundest"/>
            <ColorAlias name="stereo panner outline" alias="theme:bg"/>
            <ColorAlias name="stereo panner rule" alias="theme:bg"/>
            <ColorAlias name="stereo panner text" alias="neutral:backgroundest"/>
            <ColorAlias name="stretch clock: background" alias="theme:bg2"/>
            <ColorAlias name="stretch clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="stretch clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="stretch clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="sync mark" alias="theme:contrasting clock"/>
            <ColorAlias name="tempo bar" alias="neutral:background2"/>
            <ColorAlias name="tempo curve" alias="widget:blue"/>
            <ColorAlias name="tempo marker" alias="widget:orange"/>
            <ColorAlias name="tempo marker music" alias="widget:orange"/>
            <ColorAlias name="time axis frame" alias="neutral:backgroundest"/>
            <ColorAlias name="time axis view item base" alias="widget:gray"/>
            <ColorAlias name="time stretch fill" alias="theme:contrasting less"/>
            <ColorAlias name="time stretch outline" alias="widget:gray"/>
            <ColorAlias name="tracknumber label: fill" alias="theme:bg"/>
            <ColorAlias name="tracknumber label: fill active" alias="neutral:background2"/>
            <ColorAlias name="tracknumber label: led active" alias="alert:red"/>
            <ColorAlias name="transport active option button: fill" alias="widget:bg"/>
            <ColorAlias name="transport active option button: fill active" alias="alert:green"/>
            <ColorAlias name="transport active option button: led active" alias="alert:green"/>
            <ColorAlias name="transport button: fill" alias="widget:bg"/>
            <ColorAlias name="transport button: fill active" alias="alert:blue"/>
            <ColorAlias name="transport button: led active" alias="alert:blue"/>
            <ColorAlias name="transport clock: background" alias="theme:bg2"/>
            <ColorAlias name="transport clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="transport clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="transport clock: text" alias="theme:contrasting clock"/>
            <ColorAlias name="transport delta clock: background" alias="theme:bg2"/>
            <ColorAlias name="transport delta clock: cursor" alias="theme:contrasting alt"/>
            <ColorAlias name="transport delta clock: edited text" alias="theme:contrasting alt"/>
            <ColorAlias name="transport delta clock: text" alias="theme:contrasting alt"/>
            <ColorAlias name="transport drag rect" alias="neutral:midground"/>
            <ColorAlias name="transport loop rect" alias="alert:green"/>
            <ColorAlias name="transport marker bar" alias="neutral:background2"/>
            <ColorAlias name="transport option button: fill" alias="widget:bg"/>
            <ColorAlias name="transport option button: fill active" alias="widget:bg"/>
            <ColorAlias name="transport option button: led active" alias="alert:green"/>
            <ColorAlias name="transport punch rect" alias="widget:ruddy"/>
            <ColorAlias name="transport recenable button: fill" alias="widget:bg"/>
            <ColorAlias name="transport recenable button: fill active" alias="alert:ruddy"/>
            <ColorAlias name="transport recenable button: led active" alias="alert:red"/>
            <ColorAlias name="trim handle" alias="alert:blue"/>
            <ColorAlias name="trim handle locked" alias="alert:ruddy"/>
            <ColorAlias name="trim knob" alias="widget:bg"/>
            <ColorAlias name="trim knob: arc end" alias="widget:blue"/>
            <ColorAlias name="trim knob: arc start" alias="widget:blue"/>
            <ColorAlias name="vari button: fill" alias="widget:bg"/>
            <ColorAlias name="vari button: fill active" alias="alert:ruddy"/>
            <ColorAlias name="vca assign button: fill" alias="widget:bg"/>
            <ColorAlias name="verbose canvas cursor" alias="theme:contrasting clock"/>
            <ColorAlias name="video timeline bar" alias="neutral:background2"/>
            <ColorAlias name="waveform fill" alias="neutral:foregroundest"/>
            <ColorAlias name="waveform outline" alias="neutral:midground"/>
            <ColorAlias name="zero line" alias="neutral:midground"/>
            <ColorAlias name="zoom button: fill" alias="widget:bg"/>
            <ColorAlias name="zoom button: fill active" alias="alert:green"/>
            <ColorAlias name="zoom button: led active" alias="alert:green"/>
          </ColorAliases>
          <Modifiers>
            <Modifier name="audio bus base" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="audio track base" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="automation line fill" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="automation track fill" modifier="= alpha:0.5"/>
            <Modifier name="covered region base" modifier="= alpha:0.69999999999999996"/>
            <Modifier name="crossfade alpha" modifier="= alpha:0.20000000000000001"/>
            <Modifier name="dragging region" modifier="= alpha:0.5"/>
            <Modifier name="editable region" modifier="= alpha:0.10000000000000001"/>
            <Modifier name="gain line inactive" modifier="= alpha:0.80000000000000004"/>
            <Modifier name="ghost track base" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="ghost track midi fill" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="grid line" modifier="= alpha:0.81945799457994584"/>
            <Modifier name="inactive crossfade" modifier="= alpha:0.40000000000000002"/>
            <Modifier name="loop rectangle" modifier="= alpha:0.5"/>
            <Modifier name="marker bar" modifier="= alpha:0.49864498644986449"/>
            <Modifier name="midi note" modifier="= alpha:0.91869918699186992"/>
            <Modifier name="midi note velocity text" modifier="= alpha:0.69999999999999996"/>
            <Modifier name="midi patch change fill" modifier="= alpha:0.59999999999999998"/>
            <Modifier name="midi sysex fill" modifier="= alpha:0.5"/>
            <Modifier name="midi track base" modifier="= alpha:0.29999999999999999"/>
            <Modifier name="mono panner position fill" modifier="= alpha:0.80000000000000004"/>
            <Modifier name="panner fill" modifier="= alpha:0.80000000000000004"/>
            <Modifier name="piano roll black" modifier="= alpha:0.16531165311653118"/>
            <Modifier name="piano roll white" modifier="= alpha:0.16531165311653118"/>
            <Modifier name="recording rect" modifier="= alpha:0.25"/>
            <Modifier name="region alpha" modifier="= alpha:0.75"/>
            <Modifier name="region mark" modifier="= alpha:0.80000000000000004"/>
            <Modifier name="scroomer alpha" modifier="= alpha:0.25"/>
            <Modifier name="selected midi note" modifier="= alpha:1"/>
            <Modifier name="selection rect" modifier="= alpha:0.13"/>
            <Modifier name="silence" modifier="= alpha:0.5"/>
            <Modifier name="stereo panner inverted" modifier="= alpha:0.69999999999999996"/>
            <Modifier name="stereo panner inverted bg" modifier="= alpha:0.69999999999999996"/>
            <Modifier name="time axis view item base" modifier="= alpha:0.69999999999999996"/>
            <Modifier name="time stretch fill" modifier="= alpha:0.5"/>
            <Modifier name="transparent region base" modifier="= alpha:1"/>
            <Modifier name="verbose canvas cursor" modifier="= alpha:0.5"/>
          </Modifiers>
        </Ardour>
      '';
    };
}
