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

      python-poetry = {
        path = ./python-poetry;
        description = "Base python template using poetry";
      };

    };
    defaultTemplate = self.templates.blank;
  };
}
