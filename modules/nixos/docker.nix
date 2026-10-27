# Docker for local project databases (Supabase CLI).
{ ... }: {
  virtualisation.docker = {
    enable = true;
    # Start dockerd on first use via its socket instead of at every boot.
    enableOnBoot = false;
  };
}
