{
  description = "Dion's NixOS config and dotfiles";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.explorer = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/explorer ];
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
  };
}
