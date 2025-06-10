let
  haydengray = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV";

  vista-main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXsOVZ4CtLCSIBo1Fw/SXQJPQMwFSpQIfgr1SGyKV7o";
in
{
  "nextcloud_admin.age".publicKeys = [ haydengray vista-main ];
  "wedding_site.age".publicKeys = [ haydengray vista-main ];
}
