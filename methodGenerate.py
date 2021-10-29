import wikiDownload

class LoopData:
    def __init__(self):
        self.sections = {}
        self.lineNum = -1
        self.lines = []
        self.line = ""

        self.lastLval = ""
        self.LValType = "alias"

        self.sectionAliases = {}
        self.otherOut = ""
        self.constants = []
        self.lastSectionUsed = ""

class Method:
    def __init__(self):
        self.name = ""

class Section:    
    def __init__(self):
        self.name = ""
        self.methods = {}



def replace_null_sections(ld: LoopData,replaceWith :str):    
    for sectionID in ld.sections.copy():
        if ld.sections[sectionID].name == 'NULL':
            ld.sections[sectionID].name = replaceWith


def handle_lualreg(ld: LoopData):
    #struct luaL_Reg eventAPIMethods [] = {
    #               >   sectionID   <            
    sectionID = ld.line.split("luaL_Reg")[1].split("[")[0].replace(" ", "")
    ld.lastSectionUsed = sectionID

    newSection = Section()    

    # Section method definitions
    while True:
        ld.lineNum += 1        
        ld.line = ld.lines[ld.lineNum]

        if ld.line.replace(" ", "").find("{NULL,NULL}") != -1:
            break

        
        split = ld.line .replace(" ", "")
        split = split   .replace("&", "")
        split = split   .replace("\t", "")
        split = split   .replace("{", "")
        split = split   .replace("}", "")
        split = split   .replace("\"", "")
        split = split.split(",")

		# {"register", event_register},    
		# register,event_register,
        #         >   split[1]   <     
        #>split[0]<

        newMethod = Method()
        newMethod.name = split[0]

        newSection.methods[split[1]] = newMethod
    
    ld.sections[sectionID] = newSection
        
def handle_lualregister(ld: LoopData):
    split = ld.line .replace(" ", "")
    split = split   .replace("\t", "")
    split = split   .replace("\"", "")
    
    split = split.split(",")

    #luaL_register(l,event,eventAPIMethods);
    #                     >               <
    sectionID = split[2].split(")")[0]
    
    section = ld.sections[sectionID]

    #luaL_register(l,event,eventAPIMethods);
    #               >     <
    section.name = split[1]

    if(split[1] == 'NULL'):
        ld.LValType = "section"
    
    ld.sections[sectionID] = section

def handle_luagetglobal(ld: LoopData):    
    split = ld.line .replace(" ", "")
    split = split   .replace("\t", "")
    split = split   .replace("\"", "")
    split = split   .split(",")

    # lua_getglobal(l, "event");
    # lua_getglobal(l,event);
    #                >     <
    globalName = split[1].split(")")[0]
    ld.LValType = "alias"
    ld.lastLval = globalName

def handle_luasetglobal(ld: LoopData): 
    split = ld.line .replace(" ", "")
    split = split   .replace("\t", "")
    split = split   .replace("\"", "")
    split = split   .split(",")
    
    # lua_setglobal(l, "evt");
    # lua_setglobal(l,evt);
    #                >   <
    name = split[1].split(")")[0]
    
    if(ld.LValType == "func"):
        ld.otherOut += "function "
        ld.otherOut += name
        ld.otherOut += "() end\n"
    elif(ld.LValType == "alias"):
        ld.sectionAliases[ld.lastLval] = name
    elif(ld.LValType == "section"):
        replace_null_sections(ld,name)



def generateLUA(ld: LoopData):
    out = ""

    for sectionID in ld.sections:
        section = ld.sections[sectionID]
    
        out += f"{section.name} = {{}}\n"

        for methodID in section.methods:
            method = section.methods[methodID]

            print(f"Generating {section.name}.{method.name}")

            wikiData = wikiDownload.try_get_method(section.name,method.name)
            
            if wikiData.comment != "":
                out += wikiData.comment
                if not wikiData.comment.endswith("\n"):
                    out += "\n"

            if len(wikiData.methods) == 0:
                out += f"function {section.name}.{method.name}() end\n"
            elif len(wikiData.methods) == 1:                
                out += f"function {section.name}.{wikiData.methods[0]} end\n"
            else:
                for i in range(len(wikiData.methods)):
                    comment = wikiData.comments[i + 1]
                    if comment != "  \n--":
                        out += comment                   
                        if not comment.endswith("\n"):
                            out += "\n"
                        
                    wikiMethodName = wikiData.methods[i]

                    out += f"function {section.name}.{wikiMethodName} end\n"
    
    for aliasID in ld.sectionAliases:
        alias = ld.sectionAliases[aliasID]

        out += f"{alias} = {aliasID}\n"

    return out        

def parseSource(ld: LoopData):
    if ld.line.find("luaL_Reg") != -1:
        handle_lualreg(ld)

    elif ld.line.find("luaL_register") != -1:
        handle_lualregister(ld)

    elif ld.line.find("lua_getglobal") != -1:
        handle_luagetglobal(ld)

    elif ld.line.find("lua_setglobal") != -1:
        handle_luasetglobal(ld)

    elif ld.line.find("lua_pushcfunction") != -1:
        ld.LValType = "func"