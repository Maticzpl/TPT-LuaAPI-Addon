import requests
import re

wikiCode = {}
wikiLink = {}
possibleTypes = r"nil|number|table|boolean|type|object|string"

class GetCommentsReturnType:
    def __init__(self):
        self.comment = ""
        self.methods = []
        self.comments = []


def get_from_page(suffix: str):   
    wikiLink[suffix.lower()] = f'https://powdertoy.co.uk/Wiki/W/Lua_API:{suffix}.html'
    req = requests.get(wikiLink[suffix.lower()])
    wikiCode[suffix.lower()] = req.text
    req.close()
    handle_page(suffix.lower())

def handle_page(section):
    code = wikiCode[section]

    #remove everything but the wiki page 
    code = re.sub(r"\<\!DOCTYPE html>(?:.|\s)*?class=\"mw-parser-output\"\>","",code)
    code = re.sub(r"\<\!\-\-\s\nNewPP(?:.|\s)*?\<\/html\>","",code)

    #remove HTML tags
    code = re.sub(r"\<.*?\>","\n",code)

    # replace many new lines with a single one
    code = re.sub(r"\n+","\n",code)
    
    #remove contents table
    code = re.sub(r"\n\d\.\d+.*\n \n.*","",code)
    wikiCode[section] = code

def fetch_wiki_data():    
    get_from_page("Interface")
    get_from_page("Renderer")
    get_from_page("Elements")
    get_from_page("Simulation")
    get_from_page("Graphics")
    get_from_page("Event")

    wikiLink["fileSystem"] = 'https://powdertoy.co.uk/Wiki/W/Lua_API:File_System.html'
    req = requests.get(wikiLink["fileSystem"])
    wikiCode["fileSystem"] = req.text
    req.close()
    handle_page("fileSystem")

    wikiLink["http"] = 'https://powdertoy.co.uk/Wiki/W/Lua_API:HTTP.html'
    req = requests.get(wikiLink["http"])
    wikiCode["http"] = req.text
    req.close()
    handle_page("http")

    wikiLink["tpt"] = 'https://powdertoy.co.uk/Wiki/W/Lua.html'
    req = requests.get(wikiLink['tpt'])
    wikiCode["tpt"] = req.text
    req.close()
    handle_page("tpt")



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




def find_wiki_link(ret: GetCommentsReturnType,section,method,code):
    ret.comment += f"\n--{wikiLink[section]}#{section}.{method}"

def find_methods(ret: GetCommentsReturnType,section,method):
    regx = r"(?<=--).+?\."+method+r"\((?:\w+ (?:\d|\w)+(?:\,|\s)*)+\)"

    searchIn = re.sub(r"\[|\]","",ret.comment)

    methodsFromWiki = re.findall(regx,searchIn,flags=re.IGNORECASE)
    ret.comments = re.split(     regx,searchIn,flags=re.IGNORECASE)

    for wikiMethod in methodsFromWiki:

        wikiMethod = wikiMethod.replace("?","_optional")
        
        sectionAlias = get_short(section)

        wikiMethod = re.sub(r"(?<!\()(?:"+possibleTypes+r"|\.\.\.).*?("+section+r"|"+sectionAlias+r")\.","",wikiMethod,flags=re.IGNORECASE)
        wikiMethod = re.sub(r"(?<=\w) (?=\w)","_",wikiMethod)

        ret.methods.append(re.sub(r"("+section+r"|"+sectionAlias+r")\.","",wikiMethod))

def handle_special_chars(ret: GetCommentsReturnType):
    #TODO: Handle code blocks where tabs are detected

    ret.comment = ret.comment.replace(">","\\>")
    #(?<=--)[ \t]+
    # WHY LOOKAROUND CANT BE VARIABLE WIDTH qwq
    ret.comment = re.sub(r"(?<=--)[ \t]{4}","\t",ret.comment)

    # TODO to terminate bulletpoint use "\n--  "
    ret.comment = re.sub(r"(?<=--[ \t][ \t])[ \t]|(?<=--[ \t])[ \t]|(?<=--)[ \t]"," * ",ret.comment)    
    

def try_get_method(section,method):
    ret = GetCommentsReturnType()

    if section not in wikiCode:
        return ret

    code = wikiCode[section] + "ENDOFCOMMENT" # To prevent catastrophic backtracking 😳
    
    find_wiki_link(ret,section,method,code)
    
    #find methods
    regx = r"(?<=\n)"+section+r"\."+method+r"\n(?:.|\s)*?(?=\n"+section+r"\.\w+?\n|Constants|Event Types|ENDOFCOMMENT)"
    foundMethod = re.findall(regx,code)
    
    if len(foundMethod) == 0:
        return ret
            
    found = foundMethod[0]            
    found = "--" + found #Add comment for first line

    # remove excess newlines
    ret.comment = re.sub(r"\n+","  \n--",found)

    # Handle redirects
    redirect = re.findall(r"(?<=Same as ).*",ret.comment)
    if len(redirect) > 0:
        redirect = re.sub(r".*?\.|\(\)","",redirect[0])        
        print("Redirected ",method," -> ",redirect)
        return try_get_method(section,redirect.replace(" ",""))     

    ret.comment = ret.comment.replace("Neighbours","Neighbors") #another edge case qwq

    handle_special_chars(ret)

    ret.comment = re.sub(r"\n{2,}","\n",ret.comment)
    find_methods(ret,section,method)
    

    return ret

# TODO list:
# Blocks of code in comments are ugly (use ``` ```)
# Return type intelisense: (dummy returns for tables,numbers,strings etc.)
# Add support to classes like Slider in UI