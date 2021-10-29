import  os
from    typing              import   Dict

from    generatorModule     import   LoopData

from    methodGenerate      import   MethodGen
from    constGenerate       import   ConstGen
from    sectionGenerator    import   SectionGen

import  wikiDownload   as        wiki

def parseSource(src):
    modules = [
        SectionGen(),
        MethodGen(),
        ConstGen()
    ]

    out = ""

    ld = LoopData()

    # Itterate through file lines
    ld.lineNum = -1
    ld.lines = src.splitlines()

    while True:
        ld.lineNum += 1
        if len(ld.lines) <= ld.lineNum:
            break

        ld.line = ld.lines[ld.lineNum]
        #Here ends the boilerplate

        for module in modules:
            module.parseSource(ld)

    for module in modules:   
        out += module.generateLua(ld)

    out += ld.otherOut
    return out

        

luaAPIimplementation = open("./cppsource/LuaScriptInterface.cpp", "r")

outFS = open("intelisense.lua", "w")

wiki.fetch_wiki_data()

outFS.write(parseSource(luaAPIimplementation.read()))
outFS.close()