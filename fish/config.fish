# Path to Oh My Fish install.
set -gx OMF_PATH "/home/mk/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/mk/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Load all the "config" files
for i in ~/.dotfiles/config/*.sh
  sh $i
end
