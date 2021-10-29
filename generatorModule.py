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

class Constant:
    section: str
    name: str

class GenModule:
    def generateLua(self,ld: LoopData) -> str:
        return ""
    def parseSource(self,ld: LoopData):
        pass
