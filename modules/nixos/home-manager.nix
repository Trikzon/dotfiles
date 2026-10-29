{ inputs, ... }: {
  home-manager = {
    # Use the system's pkgs instead of a separate nixpkgs instance.
    useGlobalPkgs = true;
    # Install home.packages via users.users.<name>.packages.
    useUserPackages = true;
    # Makes programs.nixvim available to every user's home config.
    sharedModules = [ inputs.nixvim.homeModules.nixvim ];
  };
}
