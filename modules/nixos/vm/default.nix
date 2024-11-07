{config, pkgs, lib, ... }:

{
  options = {
    system-modules.vm.enable = lib.mkEnableOption "Enables Virtual Machine with Virtio Support";
  };

  config = lib.mkIf config.system-modules.vm.enable {  
    programs.dconf.enable = true;
  
    users.users.ukimnix.extraGroups = [ "libvirtd" ];
    
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice 
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];
    
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}