from wikiScraper.wikiCore import wikiLinks, wikiCode

import requests
import re

class WikiDownloader:

    def get_from_page(suffix: str):   
        wikiLinks[suffix.lower()] = f'https://powdertoy.co.uk/Wiki/W/Lua_API:{suffix}.html'
        req = requests.get(wikiLinks[suffix.lower()])
        wikiCode[suffix.lower()] = req.text
        req.close()
        WikiDownloader.handle_page(suffix.lower())

    
    def fetch_wiki_data():    
        WikiDownloader.get_from_page("Interface")
        WikiDownloader.get_from_page("Renderer")
        WikiDownloader.get_from_page("Elements")
        WikiDownloader.get_from_page("Simulation")
        WikiDownloader.get_from_page("Graphics")
        WikiDownloader.get_from_page("Event")

        wikiLinks["fileSystem"] = 'https://powdertoy.co.uk/Wiki/W/Lua_API:File_System.html'
        req = requests.get(wikiLinks["fileSystem"])
        wikiCode["fileSystem"] = req.text
        req.close()
        WikiDownloader.handle_page("fileSystem")

        wikiLinks["http"] = 'https://powdertoy.co.uk/Wiki/W/Lua_API:HTTP.html'
        req = requests.get(wikiLinks["http"])
        wikiCode["http"] = req.text
        req.close()
        WikiDownloader.handle_page("http")

        wikiLinks["tpt"] = 'https://powdertoy.co.uk/Wiki/W/Lua.html'
        req = requests.get(wikiLinks['tpt'])
        wikiCode["tpt"] = req.text
        req.close()
        WikiDownloader.handle_page("tpt")


    def handle_page(section):
        code = wikiCode[section]

        #remove everything but the wiki page 
        code = re.sub(r"\<\!DOCTYPE html>(?:.|\s)*?class=\"mw-parser-output\"\>","",code)
        code = re.sub(r"\<\!\-\-\s\nNewPP(?:.|\s)*?\<\/html\>","",code)

        # add code blocks
        code = re.sub(r"\<\/?pre\>","\n```\n",code)

        #remove HTML tags
        code = re.sub(r"\<.*?\>","\n",code)

        # replace many new lines with a single one
        code = re.sub(r"\n+","\n",code)
        
        # remove contents table
        code = re.sub(r"\n\d\.\d+.*\n \n.*","",code)
        wikiCode[section] = code


