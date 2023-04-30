{
  description = ''
    Some useful nix templates
  '';
  outputs = self: rec {
    templates = {

      blank = {
        path = ./blank;
        description = "Base template";
      };
    }
  }