{ pkgs, lib, ... }:
{
  # env.LD_LIBRARY_PATH="${pkgs.glib.out}/lib:${pkgs.pango.out}/lib:${pkgs.fontconfig.out}/lib";
  env.LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
    glib
    pango
    fontconfig
  ];
  process.manager.implementation = "overmind";
  processes.gpt-researcher.exec = ''
    uvicorn main:app --reload --port 8083 --host 0.0.0.0
  '';

  languages.python = {
    enable = true;
    package = pkgs.python311;
    venv = {
      enable = true;
      requirements = ./requirements.txt;
    };
    uv.enable = true;
  };

  dotenv.enable = true;
}

