import  os
from    typing         import   Dict

import  methodGenerate as       method
from    methodGenerate import   LoopData
import  constGenerate  as       constants
import  wikiDownload   as       wiki

def parseSource(src):
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

        method.parseSource(ld)
        constants.parseSource(ld)
        

    out += method.generateLUA(ld)
    out += constants.generateLUA(ld)

    out += ld.otherOut
    return out

        

luaAPIimplementation = open("./cppsource/LuaScriptInterface.cpp", "r")

outFS = open("intelisense.lua", "w")

wiki.fetch_wiki_data()

outFS.write(parseSource(luaAPIimplementation.read()))
outFS.close()