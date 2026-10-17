# Wezterm Config

## Requirements

- Latest Wezterm
- Monaspace NerdFonts (Argon + Radon)

## Dependencies

- [resurrect.wezterm](https://github.com/MLFlexer/resurrect.wezterm)
    - Added `init.lua` with plugin glue
    - Added functions for saving all workspaces (manually and periodically)
    - Added notification system
- sessioneer.wezterm (wrote myself)
    - More robust support than original sessioneer.lua support
    - Supports filesystem-based workspace management
    - Supports SSH-based workspace management

## Keybinds

Keybinds, to the best extend possible, reflect tmux keybinds. I made a few changes for personal ease-of-use.

## Notifications

resurrect.wezterm sends a toast whenever a workspace is saved (`ALT-w`, `ALT-SHIFT-W`, and
on every sessioneer workspace switch). These should be quick, transient popups that don't
pile up in history. WezTerm only shows up in the OS notification settings after it has
sent its first notification, so press `ALT-w` once before configuring.

### macOS

System Settings → Notifications → WezTerm:

- **Allow notifications**: on
- **Desktop**: on
- **Lock Screen**: off
- **Notification Center**: off
- **Alert style**: Temporary (called *Banners* before macOS 15)

macOS ignores the toast timeout WezTerm passes; Temporary banners dismiss themselves after
a few seconds. Focus / Do Not Disturb modes will suppress them.

### Linux (KDE Plasma)

System Settings → Notifications → Application-specific settings → Configure… → WezTerm:

- **Show popups**: on
- **Show in history**: off
- **Show popups in Do Not Disturb mode**: off

KDE honors the 3-second timeout WezTerm sends with each toast. If popups linger anyway,
lower the global *Popups → Hide after* value on the main Notifications page.
