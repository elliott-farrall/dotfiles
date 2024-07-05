{ ...
}:

final: prev:
{
  rofi-wayland = prev.rofi-wayland.overrideAttrs (attrs: {
    src = prev.fetchFromGitHub {
      owner = "lbonn";
      repo = "rofi";
      rev = "1.7.5+wayland1"; # Fixes ABI version mismatch in plugins
      fetchSubmodules = true;
      sha256 = "sha256-ddKLV7NvqgTQl5YlAEyBK0oalcJsLASK4z3qArQPUDQ=";
    };
  });
}
