{ ... }: {
  home-manager = {
    # Use the system's pkgs instead of a separate nixpkgs instance.
    useGlobalPkgs = true;
    # Install home.packages via users.users.<name>.packages.
    useUserPackages = true;
  };
}
