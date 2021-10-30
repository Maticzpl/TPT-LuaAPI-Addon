from generators.generatorModule import GenModule,LoopData,Method,Section
import re


class SectionGen(GenModule):
    def __replace_null_sections(self,ld: LoopData,replaceWith :str):    
        for sectionID in ld.sections.copy():
            if ld.sections[sectionID].name == 'NULL':
                ld.sections[sectionID].name = replaceWith


    def __handle_lualreg(self,ld: LoopData):
        #struct luaL_Reg eventAPIMethods [] = {
        #               >   sectionID   <            
        sectionID = ld.line.split("luaL_Reg")[1].split("[")[0].replace(" ", "")
        ld.lastSectionUsed = sectionID

        ld.sections[sectionID] = Section() 
            
    def __handle_lualregister(self,ld: LoopData):
        split = re.sub(r" |\"|\t","",ld.line)  
        split = split.split(",")

        #luaL_register(l,event,eventAPIMethods);
        #                     >               <
        sectionID = split[2].split(")")[0]
        
        #luaL_register(l,event,eventAPIMethods);
        #               >     <
        ld.sections[sectionID].name = split[1]

        if(split[1] == 'NULL'):
            ld.LValType = "section"

    def __handle_luagetglobal(self,ld: LoopData):  
        split = re.sub(r" |\"|\t","",ld.line)  
        split = split   .split(",")
        # lua_getglobal(l, "event");
        # lua_getglobal(l,event);
        #                >     <

        globalName = split[1].split(")")[0]
        ld.LValType = "alias"
        ld.lastLval = globalName

    def __handle_luasetglobal(self,ld: LoopData): 
        split = re.sub(r" |\"|\t","",ld.line)  
        split = split   .split(",")
        
        # lua_setglobal(l, "evt");
        # lua_setglobal(l,evt);
        #                >   <
        name = split[1].split(")")[0]
        
        if(ld.LValType == "alias"):
            ld.sectionAliases[ld.lastLval] = name
        elif(ld.LValType == "section"):
            self.__replace_null_sections(ld,name)
        

    def parseSource(self,ld: LoopData):
        if ld.line.find("luaL_Reg") != -1:
            self.__handle_lualreg(ld)

        elif ld.line.find("luaL_register") != -1:
            self.__handle_lualregister(ld)
            
        elif ld.line.find("lua_getglobal") != -1:
            self.__handle_luagetglobal(ld)

        elif ld.line.find("lua_setglobal") != -1:
            self.__handle_luasetglobal(ld)

