from wikiScraper.wikiCore import wikiLinks, GetCommentsReturnType

import re

class WikiUtil:
    def find_wiki_link(ret: GetCommentsReturnType,section,method,code):
        ret.comment += f"\n--{wikiLinks[section]}#{section}.{method}"
    
    def handle_special_chars(ret: GetCommentsReturnType):
        # ret.comment = ret.comment.replace(">","\\>")
        ret.comment = ret.comment.replace("----","-- --")
        ret.comment = ret.comment.replace("--    ","--\t")
        
        ret.comment = re.sub(r"^\n","--\n",ret.comment)
        

    #TODO: Make this better
    def get_short(section):
        if section == "simulation":
            return "sim"
        if section == "interface":
            return "ui"
        if section == "renderer":
            return "ren"
        if section == "elements":
            return "elem"
        if section == "graphics":
            return "gfx"
        if section == "fileSystem":
            return "fs"
        if section == "platform":
            return "plat"
        if section == "event":
            return "evt"
        return section

    # TODO: support for no overload methods like renderer.grid
    # RETURN TYPE SECTION
    def type_to_dummy_val(type:str):
        if type == "string":
            return "\"\""
        if type == "boolean":
            return "false"
        if type == "number":
            return "0"

        return "None"

    
            
