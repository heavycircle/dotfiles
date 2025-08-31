# masked-ronin ranger colorscheme

from ranger.gui.color import bold, default_colors, normal, reverse
from ranger.gui.colorscheme import ColorScheme

TRANSPARENT = -1

# Ronin palette
P = {
    # Darks / UI
    "bg": 233,  # #0A0A0A  (Void Black)
    "midnight": 235,  # #1E2A36  (Iron Midnight)
    "gray": 239,  # #495159  (Steel Gray)
    "fg": 253,  # #D5D9DD  (Moonlight Silver)
    "ash": 254,  # #ECE6DA  (Spirit Ash)
    "white": 15,  # #FFFFFF
    # Reds
    "red": 124,  # #A11212  (Crimson Glow)
    "red2": 160,  # #C01A1A  (Highlight Crimson)
    "red3": 167,  # #D64933  (Blood Ember)
    "red4": 211,  # #E27396  (Rose Ash)
    # “Blues” (teals & cools)
    "blue": 30,  # #2B6C73  (Storm Teal)
    "blue2": 24,  # #20505B  (Deep Ocean)
    "blue3": 37,  # #3FA7A4  (Jade Mist)
    "blue4": 152,  # #9FD9D5  (Ice Silver)
    # Earths
    "ember": 173,  # #D1643B  (Sunset Ember)
    "sand": 187,  # #E0C9A6  (Warm Sand)
    "clay": 137,  # #A86F3E  (Desert Clay)
    "umber": 94,  # #704214  (Burnt Umber)
    # Highlights
    "rose": 168,  # #B84A62  (Iron Rose)
    "bronze": 172,  # #C27C2C  (Molten Bronze)
    "indigo": 62,  # #3B5C9F  (Midnight Indigo)
}


class RoninBushido(ColorScheme):
    progress_bar_color = P["blue3"]

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        # --------------------------- Browser pane ---------------------------
        elif context.in_browser:
            attr = reverse if context.selected else normal

            # Common surfaces
            fg = P["fg"]
            bg = TRANSPARENT
            if context.border:
                fg = P["gray"]

            # Filetype coloring
            if context.directory:
                attr |= bold
                fg = P["blue"]  # directories: Storm Teal
            elif context.executable and not any(
                (context.media, context.container, context.fifo, context.socket)
            ):
                attr |= bold
                fg = P["blue3"]  # executables: Jade Mist

            if context.image:
                fg = P["blue4"]  # images: Ice Silver
            if context.video:
                fg = P["indigo"]  # videos: Midnight Indigo
            if context.audio:
                fg = P["rose"]  # audio: Iron Rose
            if context.document:
                fg = P["sand"]  # docs: Warm Sand
            if context.container:
                attr |= bold
                fg = P["bronze"]  # archives/containers: Molten Bronze

            # Special nodes
            if context.socket:
                attr |= bold
                fg = P["red3"]
            if context.fifo or context.device:
                fg = P["clay"]
                if context.device:
                    attr |= bold

            if context.link:
                fg = P["blue3"] if context.good else P["red3"]
                bg = TRANSPARENT

            # Cut/copied
            if not context.selected and (context.cut or context.copied):
                fg = P["blue2"]
                bg = TRANSPARENT

            # Marked & main column emphasis
            if context.main_column:
                if context.selected:
                    attr |= bold
                if context.marked:
                    attr |= bold
                    fg = P["ember"]

            # Errors / bad entries
            if context.empty or context.error or context.bad:
                fg = P["red2"]
                bg = TRANSPARENT

            # Tag marker
            if context.tag_marker and not context.selected:
                attr |= bold
                fg = P["red2"]

            # Inline highlights (search etc.)
            if context.text and context.highlight:
                attr |= reverse

        # --------------------------- Title bar ------------------------------
        elif context.in_titlebar:
            attr |= bold
            bg = TRANSPARENT
            fg = P["fg"]
            if context.hostname:
                fg = P["red2"] if context.bad else P["indigo"]
            elif context.directory:
                fg = P["blue"]
            elif context.link:
                fg = P["blue3"]
            elif context.tab and context.good:
                bg = P["blue2"]

        # -------------------------- Status bar ------------------------------
        elif context.in_statusbar:
            bg = TRANSPARENT
            fg = P["fg"]

            if context.permissions:
                fg = P["blue3"] if context.good else P["red2"]

            if context.marked:
                attr |= bold | reverse
                fg = P["ember"]

            if context.message and context.bad:
                attr |= bold
                fg = P["red2"]

            if context.loaded:
                bg = self.progress_bar_color

            if context.vcsinfo:
                fg = P["blue3"]
                attr &= ~bold
            if context.vcscommit:
                fg = P["clay"]
                attr &= ~bold

        # ------------------------------ Taskview ----------------------------
        if context.in_taskview:
            if context.title:
                fg = P["blue3"]
            if context.selected:
                attr |= reverse
            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        # ------------------------------- VCS -------------------------------
        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflict:
                fg = P["red2"]
            elif context.vcschanged:
                fg = P["ember"]
            elif context.vcsunknown:
                fg = P["red3"]
            elif context.vcsstaged:
                fg = P["blue3"]
            elif context.vcssync:
                fg = P["blue3"]
            elif context.vcsignored:
                fg = P["gray"]

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = P["blue3"]
            elif context.vcsbehind:
                fg = P["red3"]
            elif context.vcsahead:
                fg = P["indigo"]
            elif context.vcsdiverged:
                fg = P["red2"]
            elif context.vcsunknown:
                fg = P["red3"]

        return fg, bg, attr
