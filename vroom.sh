#!/bin/bash

VREW_PATH="$HOME/Library/Application Support/vrew"

# UI 헬퍼 함수
log() { echo " - $1"; }
error() { echo "$(tput setaf 1)✖ ERROR:$(tput sgr0) $1"; exit 1; }
success() { echo "$(tput setaf 2)✔ SUCCESS:$(tput sgr0) $1"; }
warning() { echo "$(tput setaf 3)⚠ WARNING:$(tput sgr0) $1"; }
info() { echo "$(tput setaf 4)ℹ INFO:$(tput sgr0) $1"; }

check_apple_silicon() {
    if [[ "$OSTYPE" == "darwin"* && $(uname -m) == "arm64" ]]; then
        success "Apple Silicon detected!"
        return 0
    fi
    error "This script is only for macOS with Apple Silicon."
}

check_brew_installed() {
    if ! command -v brew &> /dev/null; then
        warning "Homebrew is not installed!"
        echo -e "\nTo install Homebrew, run:\n$(tput setaf 6)/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"$(tput sgr0)"
        error "Homebrew is required."
    fi
    success "Homebrew is installed."
}

check_ffmpeg_installed() {
    if ! command -v ffmpeg &> /dev/null; then
        warning "FFmpeg is not installed!"
        read -r -p "Do you want to install FFmpeg? (y/n): " response < /dev/tty
        [[ "$response" =~ ^[Yy]$ ]] && brew install ffmpeg || error "FFmpeg is required."
    fi
    
    if [[ $(file "$(which ffmpeg)") == *"arm64"* ]]; then
        success "FFmpeg (Apple Silicon) is installed."
    else
        error "FFmpeg is not optimized for Apple Silicon!"
    fi
}

check_vrew_installed() {
    if [[ -d "$VREW_PATH" && -d "/Applications/Vrew.app" ]]; then
        success "Vrew is installed."
    else
        error "Vrew is not installed."
    fi
}

check_patch_installed() {
    if find "$VREW_PATH" -name "ffmpeg" -o -name "ffprobe" | while read -r file; do
        if [ ! -L "$file" ]; then
            return 1
        fi
    done; then
        return 0
    else
        return 1
    fi
}

install_patch() {
    info "Installing patch..."
    
    for program in ffmpeg ffprobe; do
        find "$VREW_PATH" -name "$program" | while read -r file; do
            info "- Moving $file to ${file}_original"
            mv "$file" "${file}_original" || error "Failed to move $file to ${file}_original"
            info "- Linking $file to $(which $program)"
            ln -s "$(which $program)" "$file" || error "Failed to link $file to $(which $program)"
        done
    done

    success "Patch installed!"
}

uninstall_patch() {
    info "Uninstalling patch..."

    for program in ffmpeg ffprobe; do
        find "$VREW_PATH" -name "$program" | while read -r file; do
            info "- Unlinking $file"
            unlink "$file" || error "Failed to unlink $file"
            info "- Moving ${file}_original to $file"
            mv "${file}_original" "$file" || error "Failed to move ${file}_original to $file"
        done
    done
    
    success "Patch uninstalled!"
}

main() {
    clear
    tput setaf 6
    echo 
    echo "░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░ ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓██████████████▓▒░  "
    echo "░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo " ░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo " ░▒▓█▓▒▒▓█▓▒░░▒▓███████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo "  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo "  ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo "   ░▒▓██▓▒░  ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
    echo
    echo "                  https://github.com/bayernmuller/vroom"
    echo 
    echo "                     Vroom will make you Vrew faster!"
    echo
    tput sgr0
    
    info "Checking system compatibility..."
    check_apple_silicon
    check_brew_installed
    check_ffmpeg_installed
    check_vrew_installed
    
    if check_patch_installed; then
        echo 
        info "Vroom patch is already installed! Do you want to uninstall it? (y/n)"
        echo
        read -r -p "Enter your choice (y/n): " response < /dev/tty
        [[ "$response" =~ ^[Yy]$ ]] && uninstall_patch || error "Operation aborted."
    else
        echo 
        info "Vroom patch is not installed. Do you want to install it? (y/n)"
        echo
        read -r -p "Enter your choice (y/n): " response < /dev/tty
        [[ "$response" =~ ^[Yy]$ ]] && install_patch || error "Operation aborted."
    fi   
}

main