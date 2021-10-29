import wikiDownload
import re

from generatorModule import GenModule,LoopData,Method,Section

class MethodGen(GenModule):

    def __handle_lualreg(self,ld: LoopData):
        #struct luaL_Reg eventAPIMethods [] = {
        #               >   sectionID   <            
        sectionID = ld.line.split("luaL_Reg")[1].split("[")[0].replace(" ", "")
        # Section method definitions
        while True:
            ld.lineNum += 1        
            ld.line = ld.lines[ld.lineNum]

            if ld.line.replace(" ", "").find("{NULL,NULL}") != -1:
                break
            
            split = re.sub(r" |\"|\&|\t|\{|\}|\\","",ld.line)
            split = split.split(",")

            # {"register", event_register},    
            # register,event_register,
            #         >   split[1]   <     
            #>split[0]<

            newMethod = Method()
            newMethod.name = split[0]

            ld.sections[sectionID].methods[split[1]] = newMethod
   
    def __handle_luasetglobal(self,ld: LoopData): 
        split = re.sub(r" |\"|\t","",ld.line)  
        split = split   .split(",")
        
        # lua_setglobal(l, "evt");
        # lua_setglobal(l,evt);
        #                >   <
        name = split[1].split(")")[0]
        
        if(ld.LValType == "func"):
            ld.otherOut += "function "
            ld.otherOut += name
            ld.otherOut += "() end\n"


    def __generate_method(self,section,method):
        out = ""
        wikiData = wikiDownload.try_get_method(section.name,method.name)

        if wikiData.comment != "":
            out += wikiData.comment
            if not wikiData.comment.endswith("\n"):
                out += "\n"

        if len(wikiData.methods) == 0:
            out += f"function {section.name}.{method.name}(...) end\n"
        elif len(wikiData.methods) == 1:                
            out += f"function {section.name}.{wikiData.methods[0]}\n{wikiData.methodContents[0]}end\n"
        else:
            for i in range(len(wikiData.methods)):
                comment = wikiData.comments[i + 1]
                if comment != "  \n--":
                    out += comment                   
                    if not comment.endswith("\n"):
                        out += "\n"
                    
                wikiMethodName = wikiData.methods[i]
                methodContents = wikiData.methodContents[i]

                out += f"function {section.name}.{wikiMethodName}\n{methodContents} end\n"
        
        return out


    def generateLua(self,ld: LoopData):
        out = ""

        for sectionID in ld.sections:
            section = ld.sections[sectionID]
        
            out += f"{section.name} = {{}}\n"

            for methodID in section.methods:
                method = section.methods[methodID]

                print(f"Generating {section.name}.{method.name}")
                out += self.__generate_method(section,method)
                
        
        for aliasID in ld.sectionAliases:
            alias = ld.sectionAliases[aliasID]

            out += f"{alias} = {aliasID}\n"

        return out        

    def parseSource(self,ld: LoopData):
        if ld.line.find("luaL_Reg") != -1:
            self.__handle_lualreg(ld)
            
        elif ld.line.find("lua_setglobal") != -1:
            self.__handle_luasetglobal(ld)

        elif ld.line.find("lua_pushcfunction") != -1:
            ld.LValType = "func"