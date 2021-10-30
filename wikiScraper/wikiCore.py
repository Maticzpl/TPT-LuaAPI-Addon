class GetCommentsReturnType:
    def __init__(self):
        self.comment = ""

        self.methods = []
        self.comments = []
        self.methodContents = []

wikiCode = {}
wikiLinks = {}
possibleTypes = r"nil|number|table|boolean|type|object|string"


# TODO list:
# Blocks of code in comments are ugly (use ``` ```)
# Return type intelisense: (dummy returns for tables,numbers,strings etc.)
# Add support to classes like Slider in UI