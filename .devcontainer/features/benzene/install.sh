#!/bin/bash
# Benzene prompt: clone hottahidit/axle at a pinned commit and link only the theme into
# oh-my-zsh. Nothing changes until .zshrc sees SHELLINATOR_THEME=benzene.
set -e

AXLE_REF="${AXLEREF:-f99ab5163c76c8709b839d598f5638b0802eb9fd}"
AXLE_DIR=/usr/local/share/axle
USERNAME=${USERNAME:-${_REMOTE_USER:-john}}
USER_HOME=$(getent passwd "${USERNAME}" 2>/dev/null | cut -d: -f6)
[ -z "$USER_HOME" ] && USER_HOME="/home/${USERNAME}"

if ! [[ $AXLE_REF =~ ^[0-9a-f]{40}$ ]]; then
    echo "benzene: axleRef must be a full 40-character commit SHA, got '$AXLE_REF'" >&2
    exit 1
fi

echo "Installing Benzene from hottahidit/axle@$AXLE_REF..."
rm -rf "$AXLE_DIR"
timeout 300 git clone --quiet https://github.com/hottahidit/axle.git "$AXLE_DIR"
git -C "$AXLE_DIR" -c advice.detachedHead=false checkout --quiet "$AXLE_REF"
chmod -R a+rX "$AXLE_DIR"

# Link the theme (install.sh --theme: links into $ZSH_CUSTOM, never edits .zshrc).
for home in /etc/skel "$USER_HOME"; do
    [ -d "$home/.oh-my-zsh" ] || continue
    HOME="$home" ZSH="$home/.oh-my-zsh" ZSH_CUSTOM="$home/.oh-my-zsh/custom" \
        zsh "$AXLE_DIR/install.sh" --theme --no-configure >/dev/null
    if [ "$home" = "$USER_HOME" ]; then
        chown -h "${USERNAME}:" "$home/.oh-my-zsh/custom/themes/"{benzene,axle}.zsh-theme 2>/dev/null || true
    fi
done

echo "Benzene installed. Opt in with SHELLINATOR_THEME=benzene."
