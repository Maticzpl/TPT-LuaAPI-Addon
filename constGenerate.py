from    methodGenerate import   LoopData
#from wikiDownload import try_get_field

class Constant:
    section: str
    name: str

def handle_setconst(ld: LoopData):    
    if ld.lastSectionUsed == '':
        return


    split = ld.line .replace(" ", "")
    split = split   .replace("\t", "")
    split = split.split(",")

    newElement = Constant()
    #SETCONST(l, XRES);
    #           >    <
    newElement.name = split[1].split(')')[0]
    newElement.section = ld.sections[ld.lastSectionUsed].name

    ld.constants.append(newElement)


def parseSource(ld: LoopData):    
    if ld.line.find("SETCONST") != -1:
        handle_setconst(ld)


def generateLUA(ld: LoopData):
    out = ""

    for constant in ld.constants:        
        print(f"Generating {constant.section}.{constant.name}")

        #out += try_get_field(constant.section,constant.name)
        out += f"{constant.section}.{constant.name} = nil\n"
    
    return out



