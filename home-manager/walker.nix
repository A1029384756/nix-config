{ inputs, ... }:
{
  imports = [ inputs.walker.homeManagerModules.walker ];

  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      placeholder = "Search...";

      show_initial_entries = true;
      fullscreen = false;

      search = {
        delay = 0;
        hide_icons = false;
        margin_spinner = 0;
        hide_spinner = true;
      };

      runner = {
        excludes = [ "rm" ];
      };

      hyprland = {
        context_aware_history = false;
      };

      clipboard = {
        max_entries = 10;
        image_height = 300;
      };

      icons = {
        theme = "";
        hide = false;
        size = 28;
        image_height = 200;
      };

      align = {
        width = 1000;
      };

      list = {
        height = 300;
        always_show = true;
        hide_sub = false;
      };

      modules = [
        {
          name = "applications";
          prefix = "";
        }
        {
          name = "applications";
          prefix = "";
        }
        {
          name = "commands";
          prefix = "";
          switcher_exclusive = true;
        }
        {
          name = "finder";
          prefix = "!";
        }
        {
          name = "runner";
          prefix = "@";
          excludes = [ "rm" ];
        }
        {
          name = "switcher";
          prefix = "/";
        }
      ];
    };

    style = ''
      * {
        color: #cdd6f4;
      }

      #window {
        border-radius: 10px;
      }

      #box {
        background: #1e1e2e;
        padding: 10px;
      }

      #searchwrapper {
      }

      #search,
      #typeahead {
        border-radius: 5px;
        outline: none;
        outline-width: 0px;
        box-shadow: none;
        border-bottom: none;
        border: none;
        background: #313244;
        padding-left: 10px;
        padding-right: 10px;
        padding-top: 0px;
        padding-bottom: 0px;
      }

      #spinner {
        opacity: 0;
      }

      #spinner.visible {
        opacity: 1;
      }

      #typeahead {
        background: none;
        opacity: 0.5;
      }

      #search placeholder {
        opacity: 0.5;
      }

      #list {
        padding-top: 5px;
      }

      row:selected {
        background: #585b70;
        border-radius: 5px;
      }

      .item {
        padding: 5px;
        border-radius: 5px;
      }

      .icon {
        padding-right: 5px;
      }

      .textwrapper {
      }

      .label {
      }

      .sub {
        opacity: 0.5;
      }

      .activationlabel {
        opacity: 0.25;
      }

      .activation .activationlabel {
        opacity: 1;
        color: #b4befe;
      }

      .activation .textwrapper,
      .activation .icon,
      .activation .search {
        opacity: 0.5;
      }
    '';
  };
}
