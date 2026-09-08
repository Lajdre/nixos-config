{ ... }:

{
  nixpkgs.overlays = [
    (
      _final: prev:
      let
        passwordStore = "--password-store=gnome-libsecret";
      in
      {
        brave = prev.brave.override {
          commandLineArgs = passwordStore;
        };
        vivaldi = prev.vivaldi.override {
          commandLineArgs = passwordStore;
        };
        # Wrapped instead of override: uses the cache, no source rebuild on
        # every update
        element-desktop = prev.symlinkJoin {
          name = "element-desktop-wrapped";
          paths = [ prev.element-desktop ];
          buildInputs = [ prev.makeWrapper ];
          postBuild = ''
            wrapProgram "$out/bin/element-desktop" \
              --add-flags "${passwordStore}"
          '';
        };
      }
    )
  ];
}
