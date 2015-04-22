{
  packageOverrides = super: let self = super.pkgs; in
  {
    hsEnv = self.haskellngPackages.ghcWithPackages (p: with p; [
      async attoparsec ghc-mod base16-bytestring bytestring case-insensitive containers
      cryptohash Diff directory either exceptions filecache Glob
      hashable hslogger hspec hlint HUnit lens lens-aeson
      mtl operational optparse-applicative parallel-io
      scientific strict-base-types vector yaml
    ]);
  };
}
