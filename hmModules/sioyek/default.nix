{ lib, pkgs, ... }:

{
  programs.sioyek = {
    enable = true;
    bindings = {
      screen_up = "w";
      screen_down = "e";
      toggle_dark_mode = "<C-r>";
    };
    # ahrm/sioyek#1283: QOpenGLWidget fails to create a GL context on Wayland (NVIDIA),
    # so run through XWayland. LD_LIBRARY_PATH is nixpkgs#432137: qtmultimedia dlopens
    # libpipewire-0.3, which never lands in the RPATH closure.
    package = pkgs.symlinkJoin {
      name = "sioyek";
      paths = [ pkgs.sioyek ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/sioyek \
          --set QT_QPA_PLATFORM xcb \
          --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ pkgs.pipewire ]}
      '';
    };
  };
}
