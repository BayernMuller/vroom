#!/bin/bash

VREW_PATH="$HOME/Library/Application Support/vrew"
VGX_DIR="$VREW_PATH/ffmpeg_gpl_vgx_v5"
LGPL_DIR="$VREW_PATH/ffmpeg_lgpl_v18"

function log() {
    now=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$now] $1"
}

function error() {
    log "ERROR: $1" >&2
    exit 1
}

function success() {
    log "SUCCESS: $1"
}

function warning() {
    log "WARNING: $1"
}

function install_brew {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function check_apple_silicon {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        if [[ $(uname -m) == "arm64" ]]; then
            success "It's Apple Silicon"
            return 1
        else
            error "It's not Apple Silicon"
        fi
    else
        error "It's not macOS"
    fi
}

function check_brew_installed {
    if ! command -v brew &> /dev/null; then
        warning "Homebrew is not installed"
        read -r -p "Do you want to install Homebrew? (y/n): " response < /dev/tty
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            install_brew
        else
            error "Homebrew is required"
        fi
    fi
    success "Homebrew is installed"
    return 1
}

function check_ffmpeg_installed {
    if ! command -v ffmpeg &> /dev/null; then
        warning "FFmpeg is not installed"
        read -r -p "Do you want to install FFmpeg? (y/n): " response < /dev/tty
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            brew install ffmpeg
        else
            error "FFmpeg is required"
        fi
    fi
    
    if [[ $(file "$(which ffmpeg)") == *"arm64"* ]]; then
        success "FFmpeg is installed"
    else
        error "FFmpeg is not installed for Apple Silicon"
    fi
}

function check_vrew_installed {
    if [[ -f "$VREW_PATH/ffmpeg_gpl_vgx_v5/ffmpeg" ]]; then
        success "Vrew is installed"
    else
        error "Vrew is not installed"
    fi
}

function confirm_continue {
    read -r -p "Do you want to continue? (y/n): " response < /dev/tty
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        return 1
    else
        error "Aborted"
    fi
}

function install_patch {
    confirm_continue
    log "Installing patch"
    
    mv "$VGX_DIR/ffmpeg" "$VGX_DIR/ffmpeg_original"
    mv "$LGPL_DIR/ffmpeg" "$LGPL_DIR/ffmpeg_original"
    mv "$LGPL_DIR/ffprobe" "$LGPL_DIR/ffprobe_original"

    ln -s "$(which ffmpeg)" "$VGX_DIR/ffmpeg"
    ln -s "$(which ffmpeg)" "$LGPL_DIR/ffmpeg"
    ln -s "$(which ffprobe)" "$LGPL_DIR/ffprobe"

    success "Installed patch"
}

function uninstall_patch {
    confirm_continue
    log "Uninstalling patch"
    if [[ -L "$VGX_DIR/ffmpeg" ]]; then
        unlink "$VGX_DIR/ffmpeg"
        if [[ -f "$VGX_DIR/ffmpeg_original" ]]; then
            mv "$VGX_DIR/ffmpeg_original" "$VGX_DIR/ffmpeg"
        else
            error "Original ffmpeg is not found"
        fi
    else
        error "patch is not installed"
    fi

    if [[ -L "$LGPL_DIR/ffmpeg" ]]; then
        unlink "$LGPL_DIR/ffmpeg"
        if [[ -f "$LGPL_DIR/ffmpeg_original" ]]; then
            mv "$LGPL_DIR/ffmpeg_original" "$LGPL_DIR/ffmpeg"
        else
            error "Original ffmpeg is not found"
        fi
    else
        error "patch is not installed"
    fi

    if [[ -L "$LGPL_DIR/ffprobe" ]]; then
        unlink "$LGPL_DIR/ffprobe"
        if [[ -f "$LGPL_DIR/ffprobe_original" ]]; then
            mv "$LGPL_DIR/ffprobe_original" "$LGPL_DIR/ffprobe"
        else
            error "Original ffprobe is not found"
        fi
    else
        error "patch is not installed"
    fi    
    success "Uninstalled patch"
}

function main()
{
    log "Checking environment"
    check_apple_silicon
    check_brew_installed
    check_ffmpeg_installed
    check_vrew_installed

    read -r -p "Which do you want to do? (install/uninstall): " response < /dev/tty

    if [[ "$response" == "install" ]]; then
        install_patch
    elif [[ "$response" == "uninstall" ]]; then
        uninstall_patch
    else
        error "Invalid command"
    fi
}

main
