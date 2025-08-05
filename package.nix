{pkgs}:
let
  scriptName = "ncore-login";
  scriptContent = builtins.readFile ./src/ncore-login.sh;
in
pkgs.symlinkJoin {
  name = scriptName;
  paths = [
    ((pkgs.writeScriptBin scriptName scriptContent).overrideAttrs(old: {
      buildCommand = "${old.buildCommand}\n patchShebangs $out";
    }))
    pkgs.curl
    pkgs.gnugrep
  ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = "wrapProgram \"$out/bin/${scriptName}\" --prefix PATH : $out/bin";
}
