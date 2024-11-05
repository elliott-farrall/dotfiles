{ lib
, inputs
, system
, ...
}:

(lib.deploy-rs.${system}.deployChecks inputs.self.deploy).deploy-activate
