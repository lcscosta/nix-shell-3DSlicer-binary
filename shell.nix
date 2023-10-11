{ extraPkgsFn ? (pkgs: [])
  , shellName ? "fhs"
  , pkgs ? import <nixpkgs> {}
}:
(
  let
    extraPkgs = extraPkgsFn pkgs;
  in

  pkgs.buildFHSUserEnv rec {
    name = shellName;
    runScript = "zsh -i";
    targetPkgs = pkgs: (
      with pkgs; [
      # Edit with your needs
      zsh
      zlib
      libGLU
      glib
      nss
      nspr
      pulseaudio
      freetype
      expat
      fontconfig
      libxkbcommon
      dbus
      alsa-lib
      krb5
    ] ++ (with libsForQt5; [
      qt5.qtx11extras
      qt5.qtmultimedia
      qt5.qttools
      qt5.qtxmlpatterns
      qt5.qtsvg
      qt5.qtwebengine
      qt5.qtscript

    ]) ++ (with xorg; [
      libSM
      libICE
      libXrender
      libXext
      libX11
      libGL
      libXcomposite
      libXdamage
      libXfixes
      libXrandr
      libxcb
      xcbutil
      xcbutilimage
      xcbutilwm
      xcbutilkeysyms
      xcbutilrenderutil
      libXcursor
      libXi
      libXtst
    ]) 
    ++ extraPkgs
  );
    profile = ''
      export NIX_FHS=${name}
    '';
  }
).env
