let
  haydengray = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/ZbPqfUBjnhwW859snOnvqmuvaVtfNq5kuSpn/zOmV";
  vista = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILckIr4ijZRcH/qVyx7pg0Qssfn242pzArywz737vipS";
  vista-vps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGXsOVZ4CtLCSIBo1Fw/SXQJPQMwFSpQIfgr1SGyKV7o";
	minibubbles = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIILt1GUpCQs0ltyH2MSY5UJxVdZHcHc+DAIbPSG3R+gh";
in
{
	# shared
	"tailscale.age".publicKeys = [ haydengray vista vista-vps ];
	# vista
  "nextcloud_admin.age".publicKeys = [ haydengray vista ];
  "nextcloud_whiteboard.age".publicKeys = [ haydengray vista ];
	"onlyoffice.age".publicKeys = [ haydengray vista ];
  "vaultwarden.age".publicKeys = [ haydengray vista ];
  "pocket-id.age".publicKeys = [ haydengray vista ];
  "headscale.age".publicKeys = [ haydengray vista ];
	"headscale-dns.age".publicKeys = [ haydengray vista ];
	"restic-repo.age".publicKeys = [ haydengray vista ];
	"restic-password.age".publicKeys = [ haydengray vista ];
	"restic-env.age".publicKeys = [ haydengray vista ];
	"caddy.age".publicKeys = [ haydengray vista ];
	"valheim.age".publicKeys = [ haydengray vista ];
	"searxng.age".publicKeys = [ haydengray vista ];
	"forgejo-mail.age".publicKeys = [ haydengray vista ];
	"forgejo-runner-vista.age".publicKeys = [ haydengray vista ];
	# vista-vps
  "wedding_site.age".publicKeys = [ haydengray vista-vps ];
	# minibubbles
	"forgejo-runner-minibubbles.age".publicKeys = [ haydengray minibubbles ];
}
