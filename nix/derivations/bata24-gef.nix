{ pkgs
, lib
, gdb
, python3
, fetchFromGitHub
}:


let
  pythonPath =
    with python3.pkgs;
    makePythonPath [
      keystone-engine
      unicorn
      capstone
      ropper
  ];
in
python3.pkgs.buildPythonPackage rec {
  pname = "bata24-gef";
  version = "unstable-2025-05-28";

  src = fetchFromGitHub {
    owner = "bata24";
    repo = "gef";
    rev = "dev";  # or use a commit hash for reproducibility
    sha256 = "sha256-xlTIQ0VbktdYHT4JRK6HzoKKT7WzKqqPS0aTbpvBMV0="; # replace after first build
  };

  format = "other"; # not a standard Python package layout

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/share/gef
    cp gef.py $out/share/gef
    makeWrapper ${gdb}/bin/gdb $out/bin/bata24-gef \
      --add-flags "-q -x $out/share/gef/gef.py" \
      --set NIX_PYTHONPATH ${pythonPath} \
      --prefix PATH : ${
        lib.makeBinPath [
          pkgs.gdb
          python3
          pkgs.bintools-unwrapped # for readelf
          pkgs.file
          pkgs.ps
        ]
      }
  '';

  meta = with lib; {
    description = "GDB Enhanced Features fork by bata24";
    mainProgram = "bata24-gef";
    platforms = platforms.all;
    homepage = "https://github.com/bata24/gef";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
