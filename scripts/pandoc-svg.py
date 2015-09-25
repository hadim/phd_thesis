#! /usr/bin/env python
"""
Pandoc filter to convert svg files to png using inkscape as suggested at:
https://gist.github.com/jeromerobert/3996eca3acd12e4c3d40
"""

import mimetypes
import subprocess
import os
import sys
from pandocfilters import toJSONFilter, Str, Para, Image

fmt_to_option = {
    "latex": ("--export-png","png"),
    "docx": ("--export-png","png"),
    "html": ("--export-png", "png")
}

inkscape_general_options = "--export-dpi=200"

def svg_to_any(key, value, fmt, meta):

    if key == 'Image':
       alt, [src, title] = value
       mimet,_ = mimetypes.guess_type(src)
       option = fmt_to_option.get(fmt)
       if mimet == 'image/svg+xml' and option:
           base_name,_ = os.path.splitext(src)
           eps_name = base_name + "." + option[1]

           try:
               mtime = os.path.getmtime(eps_name)
           except OSError:
               mtime = -1

           # Only run inkscape if the svg file has been modified
           if mtime < os.path.getmtime(src):
               cmd_line = ['inkscape', inkscape_general_options, option[0], eps_name, src]
               sys.stderr.write("Running {}\n".format(" ".join(cmd_line)))
               subprocess.call(cmd_line, stdout=sys.stderr.fileno())
           return Image(alt, [eps_name, title])

if __name__ == "__main__":
  toJSONFilter(svg_to_any)
