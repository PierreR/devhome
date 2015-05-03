{
  provideOldHaskellAttributeNames = true;

  packageOverrides = super: let self = super.pkgs; in
  {
    hsDevEnv = self.haskellngPackages.ghcWithPackages (p: with p; [
      async attoparsec base16-bytestring bytestring case-insensitive containers
      cryptohash Diff directory either exceptions filecache Glob
      hashable hslogger hspec hlint HUnit lens lens-aeson pcre-utils
      mtl operational optparse-applicative parallel-io regex-pcre-builtin
      scientific servant servant-client strict-base-types vector yaml
    ]);

  };
}
