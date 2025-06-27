{ inputs, ... }:
let
  mkVMApp = nixosConfiguration: {
    type = "app";
    program = "${
      inputs.self.nixosConfigurations.${nixosConfiguration}.config.system.build.vm
    }/bin/run-${nixosConfiguration}-vm";
  };
in
{
  mkVMApp = mkVMApp;
}
