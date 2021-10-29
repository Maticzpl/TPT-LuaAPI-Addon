from generatorModule import GenModule,LoopData,Constant
import re

class ConstGen(GenModule):

    def __handle_setconst(self,ld: LoopData):    
        if ld.lastSectionUsed == '':
            return

        split = re.sub(r" |\t","",ld.line)
        split = split.split(",")

        newElement = Constant()

        #SETCONST(l, XRES);
        #           >    <
        newElement.name = split[1].split(')')[0]
        newElement.section = ld.sections[ld.lastSectionUsed].name

        ld.constants.append(newElement)


    def parseSource(self,ld: LoopData):    
        if ld.line.find("SETCONST") != -1:
            self.__handle_setconst(ld)

    def generateLua(self,ld: LoopData):
        out = ""

        for constant in ld.constants:        
            print(f"Generating {constant.section}.{constant.name}")

            #out += try_get_field(constant.section,constant.name)
            out += f"{constant.section}.{constant.name} = nil\n"
        
        return out



