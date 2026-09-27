{ pkgs, ... }:

{
  services.printing.drivers = [
    pkgs.hplip
  ];
  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP-DeskJet4530";
        location = "Home";
        deviceUri = "hp:/usb/DeskJet_4530_series?serial=TH61L3D1HH0661"; # from lpinfo -v output
        model = "drv:///hp/hpcups.drv/hp-deskjet_4530_series.ppd"; # from lpinfo -m | grep -i deskjet
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "HP-DeskJet4530";
  };
  # enables support for SANE scanners; scanimage [-L]; sane-find-scanner;
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplip ]; # pkgs.hplipWithPlugin
  };
}
