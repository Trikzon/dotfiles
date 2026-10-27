# Lets prebuilt generic-linux binaries run (e.g. the Supabase CLI from npm).
{ ... }: {
  programs.nix-ld.enable = true;
}
