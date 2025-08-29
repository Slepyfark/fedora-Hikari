#!/usr/bin/env bash
set -euo pipefail

# ==== Настройки ====
DOTFILES_REPO="https://github.com/ViegPhunt/Dotfiles.git"   # откуда брать конфиги
DOTFILES_DIR="$HOME/Fedora-Hyprland/.dotfiles"              # временная папка для конфигов

echo "==> Клонируем конфиги из $DOTFILES_REPO ..."
rm -rf "$DOTFILES_DIR"
git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"

echo "==> Устанавливаем пакеты Fedora..."
sudo dnf install -y \
    hyprland waybar rofi \
    grim slurp hyprpaper \
    xdg-desktop-portal-hyprland \
    wl-clipboard swaync wlogout dunst \
    ghostty nemo \
    papirus-icon-theme bibata-cursor-themes gnome-themes-extra \
    stow git

echo "==> Бэкапим старые конфиги..."
mkdir -p ~/.config.bak
cp -rf ~/.config/* ~/.config.bak/ 2>/dev/null || true

echo "==> Устанавливаем новые конфиги..."
cp -rf "$DOTFILES_DIR/.config/"* ~/.config/

echo "==> Ставим тему и иконки..."
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark" || true
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark" || true
gsettings set org.gnome.desktop.interface cursor-theme "Bibata-Modern-Ice" || true

echo "==> Всё готово! Перезагрузка через 5 секунд..."
sleep 5
sudo reboot
