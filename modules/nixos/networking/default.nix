{ ... }: {

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  #networking.hostName = "dreamhouse";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Detroit";

}
