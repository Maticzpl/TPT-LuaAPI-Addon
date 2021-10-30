import re
from wikiScraper.wikiCore import wikiCode,GetCommentsReturnType,possibleTypes
from wikiScraper.wikiUtility import WikiUtil


class WikiMethods:
    def find_return_types(wikiMethod: str,section :str,sectionAlias:str,method :str,ret:GetCommentsReturnType):
            regx = r"(?:string|boolean|number).*?(?= "+section+r"| "+sectionAlias+r"\."+method+r")"
            found = re.findall(regx,wikiMethod)

            if len(found) == 0:
                return ""

            methodIn = ""

            returnType = found[0]

            if "," in returnType:
                returnType = re.sub(r"\, +",",",returnType) #Delete spaces after comma

                methodIn += "local ret = {}\n"
                for objPart in returnType.split(','):
                    split = objPart.split(" ")
                    if len(split) > 1:
                        type = split[0]
                        name = split[1]

                        dummyVal = WikiUtil.type_to_dummy_val(type)
                        if dummyVal == "None":
                            continue

                        methodIn += f"ret.{name} = {dummyVal}\n"
                    # else it will be an empty object so can also work as an array
                        
            else:
                returnType = re.sub(r"\, +",",",returnType)
                dummyVal = WikiUtil.type_to_dummy_val(returnType)
                if dummyVal == "None":
                    return ""

                methodIn += f"local ret = {dummyVal}\n"
            
            methodIn += "return ret\n"
            return methodIn


    # FIND METHOD
    def find_methods(ret: GetCommentsReturnType,section,method):
        regx = r"(?<=--).+?\."+method+r"\((?:\w+ (?:\d|\w)+(?:\,|\s)*)+\)"

        searchIn = ret.comment.replace("[","").replace("]","_optional")
        
        searchIn = searchIn.replace("?","")

        methodsFromWiki = re.findall(regx,searchIn,flags=re.IGNORECASE)
        ret.comments = re.split(     regx,searchIn,flags=re.IGNORECASE)

        for i in range(len(ret.comments)):
            ret.comments[i] = ret.comments[i].removeprefix("  \n--```  ")
            ret.comments[i] = ret.comments[i].removesuffix("\n--```  \n--")

        sectionAlias = WikiUtil.get_short(section)

        for wikiMethod in methodsFromWiki:
            # Generate return types inside methods
            methodInside = WikiMethods.find_return_types(wikiMethod,section,sectionAlias,method,ret)       
            ret.methodContents.append(methodInside)

            wikiMethod = re.sub(r"(?<!\()(?:"+possibleTypes+r"|\.\.\.).*?("+section+r"|"+sectionAlias+r")\.","",wikiMethod,flags=re.IGNORECASE)
            wikiMethod = re.sub(r"(?<=\w) (?=\w)","_",wikiMethod)

            ret.methods.append(re.sub(r"("+section+r"|"+sectionAlias+r")\.","",wikiMethod))
    

    def try_get_method(section,method):
        ret = GetCommentsReturnType()

        if section not in wikiCode:
            return ret

        code = wikiCode[section] + "ENDOFCOMMENT" # To prevent catastrophic backtracking 😳
        
        WikiUtil.find_wiki_link(ret,section,method,code)
        
        #find methods
        regx = r"(?<=\n)"+section+r"\."+method+r"\n(?:.|\s)*?(?=\n"+section+r"\.\w+?\n|Constants|Event Types|ENDOFCOMMENT|Properties)"
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
            return WikiMethods.try_get_method(section,redirect.replace(" ",""))     

        ret.comment = ret.comment.replace("Neighbours","Neighbors") #another edge case qwq

        WikiUtil.handle_special_chars(ret)

        ret.comment = re.sub(r"\n{2,}","\n",ret.comment)

        WikiMethods.find_methods(ret,section,method)
        
        return ret

