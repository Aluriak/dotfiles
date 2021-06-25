

# seems to be the arch install dir
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

# that would be a user-wide one
[[ -s /home/lucas/.autojump/etc/profile.d/autojump.sh ]] && source /home/lucas/.autojump/etc/profile.d/autojump.sh

# that would be on ubuntu
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh
