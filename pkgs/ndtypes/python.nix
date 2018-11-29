{ pythonPackages
, libndtypes
}:

pythonPackages.buildPythonPackage {
  name = "ndtypes";

  src = libndtypes.src;

  propagatedBuildInputs = [ pythonPackages.numpy ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'include_dirs = ["libndtypes"]' \
                'include_dirs = ["${libndtypes}/include"]' \
      --replace 'library_dirs = ["libndtypes"]' \
                'library_dirs = ["${libndtypes}/lib"]' \
      --replace 'runtime_library_dirs = ["$ORIGIN"]' \
                'runtime_library_dirs = ["${libndtypes}/lib"]'
  '';

  postInstall = ''
    mkdir $out/include
    cp python/ndtypes/*.h $out/include
  '';

  meta = libndtypes.meta;
}
