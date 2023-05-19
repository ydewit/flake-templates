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

      python-poetry-app = {
        path = ./python-poetry-app;
        description = "Base Python app flake template using poetry"; 
      };

      jupyter-lab = {
        path = ./jupyter-lab;
        description = "Base JupyterLab template using venv";
      };

      rust = {
        path = ./rust;
        description = "Base rust template";
      };
    };
    templates.default = self.templates.blank;
  };
}
