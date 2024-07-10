{ ...
}:

final: prev:
{
  vscode = (prev.vscode.override { isInsiders = true; }).overrideAttrs (attrs: {
    src = builtins.fetchTarball {
      url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
      sha256 = "sha256:14z0jfsl8zj9spqmla88r0n4yjxhhs9qxh2h41ligc6b5xsb0x2i";
    };
    version = "latest";

    buildInputs = attrs.buildInputs ++ [ prev.krb5 ];

    commandLineArgs = "--ozone-platform=wayland";

    postInstall = (attrs.postInstall or "") + ''
      ln -s $out/bin/code-insiders $out/bin/code
    '';
  });
}
