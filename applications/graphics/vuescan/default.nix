{ autoPatchelfHook
, fetchurl
, gtk2
, lib
, libSM
, stdenv
}:

stdenv.mkDerivation {
  pname = "vuescan";
  version = "9.7.92";
  
  src = fetchurl {
    url = "https://www.hamrick.com/files/vuex6497.tgz";
    sha256 = "0w605nq9kb5qcrf4bqdbnfshjvr0ad8p7dinvjy2vbc5bbdhqzwk";
  };

  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    gtk2
    libSM
  ];

  sourceRoot = ".";
  
  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/etc/udev/rules.d
    mkdir -p $out/usr/share/icons/hicolor/scalable/apps
    install -m755 -D VueScan/vuescan $out/usr/lib/vuescan
    cp VueScan/vuescan.rul $out/etc/udev/rules.d/60-vuescan.rules
    cp VueScan/vuescan.svg $out/usr/share/icons/hicolor/scalable/apps/
    ln -s $out/usr/lib/vuescan $out/bin/vuescan
  ''; # Binary for some reason has to be in /usr/lib/, which is then linked to /bin/.
  
  meta = with lib; {
    description = "A powerful proprietary scanning tool developed by Hamrick Software";
    homepage = "https://hamrick.com";
    license = licenses.unfree;
    maintainers = with maintainers; [];
    platforms = [ "x86_64-linux" ];
  };
}
  
