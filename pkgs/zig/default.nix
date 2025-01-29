{ lib, stdenv, fetchurl, pkg-config, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "zig";
  version = "0.14.0-dev.2851+b074fb7dd";

  src = fetchurl {
    url = "https://ziglang.org/builds/zig-linux-x86_64-${version}.tar.xz";
    hash = "sha256:0fq6dw32mdq48j2bnmhl007pkdq2raz14nyxc4madxzfm6h779k0";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r . $out/
    ln -s $out/zig $out/bin/zig
    chmod +x $out/bin/zig

    runHook postInstall
  '';

  meta = with lib; {
    description = "General-purpose programming language and toolchain";
    homepage = "https://ziglang.org/";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ ];
  };
}
