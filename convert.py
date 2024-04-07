#!/bin/python3
# Convert function definition with mediawiki format to a rough lua ls definition
# Input and oyutput through clipboard

# EXAMPLE:
# === interface.activeTool ===
#
# Gets or sets an active element selection.
#
#   interface.activeTool(toolIndex, identifier)
#   identifier = interface.activeTool(toolIndex)
# * <code>toolIndex</code>: The tool index. Should be between 0 and <code>interface.NUM_TOOLINDICES</code>. The indices correspond to:
# ** <code>0</code>: Left click
# ** <code>1</code>: Right click
# ** <code>2</code>: Middle click
# ** <code>3</code>: "Replace Mode" element
# * <code>identifier</code>. The tool identifier. This is a string that uniquely identifies a tool, for example <code>"DEFAULT_PT_BGLA"</code> or <code>"DEFAULT_TOOL_HEAT"</code>.

import pyclip
import re

wiki = pyclip.paste(text=True)

# Remove === Header ===
wiki = re.sub(r"===.*\n(^\n)*", "", wiki, flags=re.MULTILINE)

# Get example code
code = re.findall(r"^ +(.*)$", wiki, flags=re.MULTILINE)
# Remove example code
wiki = re.sub(r"(^\n)?^ +(.*)\n(^\n)?", "", wiki, flags=re.MULTILINE)

# Convert code tags to `
wiki = re.sub(r"(.*?)<code>(.*?)<\/code>(.*?)", "\\1`\\2`\\3", wiki, flags=re.MULTILINE)

# Convert [[]] links to []()
wiki = re.sub(r"\[\[(.*?)(#.*?)?\|(.*?)\]\]", "[\\3](https://powdertoy.co.uk/Wiki/W/\\1.html\\2)", wiki, flags=re.MULTILINE)

# Convert * bulletpoints to -
for i in range(5):  # who needs more than that
    wiki = re.sub(r"^([ -]*)\*(.*)$", "\\1  -\\2", wiki, flags=re.MULTILINE)
# Remove duplicate -
for i in range(5):
    wiki = re.sub(r"-  -", "   -", wiki, flags=re.MULTILINE)

# Convert ''' bold to **
wiki = re.sub(r"'''(.*?)'''", "**\\1**", wiki, flags=re.MULTILINE)

# Convert ==== header to ###
wiki = re.sub(r"====(.*?)====", "### \\1", wiki, flags=re.MULTILINE)

commented = "--```\n"
for line in code:
    commented += f"--{line}\n"
commented += "--```\n"
for line in wiki.split("\n"):
    commented += f"--{line}\n"

pyclip.copy(commented)
