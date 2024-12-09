let
  haydengray = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV";
  users = [ haydengray ];

  vista-main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXsOVZ4CtLCSIBo1Fw/SXQJPQMwFSpQIfgr1SGyKV7o";
  systems = [ vista-main ];
in
{
  "nextcloud_admin.age".publicKeys = [ haydengray vista-main ];
}
