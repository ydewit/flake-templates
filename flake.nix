{
  description = ''
    Some useful nix templates
  '';
  outputs = { self }: {
    templates = {
      blank = {
        path = ./blank;
        description = "Base template";
	      welcomeText = ''
          # Simple blank template
        '';
      };
    };
    defaultTemplate = self.templates.blank;
  };
}
