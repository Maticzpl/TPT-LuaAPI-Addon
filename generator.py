import  os
from    typing   import   List
from    wikiScraper.downloadWikiPages  import   WikiDownloader

from    generators.generatorModule     import   LoopData

from    generators.methodGenerate      import   MethodGen
from    generators.constGenerate       import   ConstGen
from    generators.sectionGenerator    import   SectionGen



def parseSource(src):
    modules:List[MethodGen] = [
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

        for module in modules:
            module.parseSource(ld)

    for module in modules:   
        out += module.generateLua(ld)

    out += ld.otherOut
    return out

        

luaAPIimplementation = open("./cppsource/LuaScriptInterface.cpp", "r")

outFS = open("intelisense.lua", "w")

WikiDownloader.fetch_wiki_data()

outFS.write(parseSource(luaAPIimplementation.read()))
outFS.close()