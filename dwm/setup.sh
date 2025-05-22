#!/bin/bash

# Function to install dependencies for Debian-based distributions
install_debian() {
    sudo apt update
    sudo apt install -y libconfig-dev libdbus-1-dev libegl-dev \
    libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev \
    libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev \
    libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev \
    libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev cmake unzip \
    curl open-vm-tools open-vm-tools-desktop \
    build-essential module-assistant \
    make gcc libimlib2-dev libxcb-res0-dev \
    libx11-xcv-dev libx11-dev libxft-dev libxinerama-dev xorg \
    ripgrep fasd xclip feh

    touch ~/.xinitrc && echo "exec dwm" >> ~/.xinitrc
}

# Detect the distribution and install the appropriate packages
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        debian|ubuntu)
            echo "Detected Debian-based distribution"
            install_debian
            ;;
        *)
            echo "Unsupported distribution"
            exit 1
            ;;
    esac
else
    echo "/etc/os-release not found. Unsupported distribution"
    exit 1
fi

picom_animations() {
    # Clone the repository in the home/build directory
    mkdir -p ~/build
    if [ ! -d ~/build/picom ]; then
        if ! git clone https://github.com/FT-Labs/picom.git ~/build/picom; then
            echo "Failed to clone the repository"
            return 1
        fi
    else
        echo "Repository already exists, skipping clone"
    fi

    cd ~/build/picom || { echo "Failed to change directory to picom"; return 1; }

    # Build the project
    if ! meson setup --buildtype=release build; then
        echo "Meson setup failed"
        return 1
    fi

    if ! ninja -C build; then
        echo "Ninja build failed"
        return 1
    fi

    # Install the built binary
    if ! sudo ninja -C build install; then
        echo "Failed to install the built binary"
        return 1
    fi

    echo "Picom animations installed successfully"
}

# Function to install Meslo Nerd font for dwm and rofi icons to work
install_nerd_font() {
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_ZIP="$FONT_DIR/Meslo.zip"
    FONT_ZIP_2="$FONT_DIR/CommitMono.zip"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip"
    FONT_URL_2="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CommitMono.zip"
    FONT_INSTALLED=$(fc-list | grep -i "Meslo")
    FONT_2_INSTALLED=$(fc-list | grep -i "Commit")

    # Check if Meslo Nerd-font is already installed
    if [ -n "$FONT_INSTALLED" && "$FONT_2_INSTALLED"]; then
        echo "Meslo Nerd-fonts are already installed."
        return 0
    fi

    echo "Installing Meslo Nerd-fonts"

    # Create the fonts directory if it doesn't exist
    if [ ! -d "$FONT_DIR" ]; then
        mkdir -p "$FONT_DIR" || {
            echo "Failed to create directory: $FONT_DIR"
            return 1
        }
    else
        echo "$FONT_DIR exists, skipping creation."
    fi

    # Check if the font zip file already exists
    if [ ! -f "$FONT_ZIP" && "$FONT_ZIP_2" ]; then
        # Download the font zip file
        wget -P "$FONT_DIR" "$FONT_URL" || {
            echo "Failed to download Meslo Nerd-fonts from $FONT_URL"
            return 1
        }
    else
        echo "Meslo.zip already exists in $FONT_DIR, skipping download."
    fi

    # Unzip the font file if it hasn't been unzipped yet
    if [ ! -d "$FONT_DIR/Meslo" && "$FONT_DIR/Commit"]; then
        unzip "$FONT_ZIP" -d "$FONT_DIR" || {
            echo "Failed to unzip $FONT_ZIP"
            return 1
        }
    else
        echo "Meslo font files already unzipped in $FONT_DIR, skipping unzip."
    fi

    # Remove the zip file
    rm "$FONT_ZIP" || {
        echo "Failed to remove $FONT_ZIP"
        return 1
    }

    # Rebuild the font cache
    fc-cache -fv || {
        echo "Failed to rebuild font cache"
        return 1
    }

    echo "Meslo Nerd-fonts installed successfully"
}

# Call the function
picom_animations

install_nerd_font

echo "All dependencies installed successfully."

