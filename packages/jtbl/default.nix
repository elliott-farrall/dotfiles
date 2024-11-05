{ lib
, inputs
, python3
, ...
}:

python3.pkgs.buildPythonApplication rec {
  pname = "jtbl";
  version = inputs.jtbl.rev;
  pyproject = true;

  src = inputs.jtbl;

  nativeBuildInputs = with python3.pkgs; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3.pkgs; [
    tabulate
  ];

  pythonImportsCheck = [ "jtbl" ];

  meta = with lib; {
    description = "CLI tool to convert JSON and JSON Lines to terminal, CSV, HTTP, and markdown tables";
    homepage = "https://github.com/kellyjonbrazil/jtbl";
    changelog = "https://github.com/kellyjonbrazil/jtbl/blob/${src.rev}/CHANGELOG";
    license = licenses.mit;
    # maintainers = with maintainers; [ ];
    mainProgram = "jtbl";
  };
}
