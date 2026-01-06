let
  haydengray = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV";
  vista = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILckIr4ijZRcH/qVyx7pg0Qssfn242pzArywz737vipS";
  vista-vps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXsOVZ4CtLCSIBo1Fw/SXQJPQMwFSpQIfgr1SGyKV7o";
in
{
  "nextcloud_admin.age".publicKeys = [ haydengray vista vista-vps ];
  "nextcloud_whiteboard.age".publicKeys = [ haydengray vista vista-vps ];
  "wedding_site.age".publicKeys = [ haydengray vista vista-vps ];
  "vaultwarden.age".publicKeys = [ haydengray vista vista-vps ];
  "authentik.age".publicKeys = [ haydengray vista vista-vps ];
  "pocket-id.age".publicKeys = [ haydengray vista vista-vps ];
  "open-webui.age".publicKeys = [ haydengray vista vista-vps ];
  "headscale.age".publicKeys = [ haydengray vista vista-vps ];
}
