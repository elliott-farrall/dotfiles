{ ...
}:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "greeter";
        command = "hyprwm";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprwm
  '';
}
