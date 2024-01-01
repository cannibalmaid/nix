{
  presence = import ./linux-discord-rich-presence.nix;
  arrpc = import ./arrpc.nix;
  swww = import ./swww/swww.nix;
  swww-random = import ./swww/swww-random.nix;

  librewolf = import ./librewolf;
  spicetify = import ./spicetify;
}
