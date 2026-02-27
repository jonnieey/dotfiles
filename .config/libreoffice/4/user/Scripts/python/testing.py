# def PythonVersion(*args):
#     """Prints the Python version into the current document"""
# #get the doc from the scripting context which is made available to all scripts
#     desktop = XSCRIPTCONTEXT.getDesktop()
#     model = desktop.getCurrentComponent()
# #check whether there's already an opened document. Otherwise, create a new one
#     if not hasattr(model, "Text"):
#         model = desktop.loadComponentFromURL(
#             "private:factory/swriter","_blank", 0, () )
# #get the XText interface
#     text = model.Text
# #create an XTextRange at the end of the document
#     tRange = text.End
# #and set the string
#     tRange.String = "The Python version is %s.%s.%s" % sys.version_info[:3] + " and the executable path is " + sys.executable
#     return None

# from com.sun.star.beans import PropertyValue
from com.sun.star.beans import PropertyValue
from  com.sun.star.awt.FontWeight import (NORMAL, BOLD)
from com.sun.star.util import XPropertyReplace

def replace(s_string, r_string, use_regex=False, bold=False):
    document = XSCRIPTCONTEXT.getDocument()
    # search = document.createSearchDescriptor()
    replace = document.createReplaceDescriptor()

    replace.SearchString = s_string
    replace.ReplaceString = r_string
    replace.SearchRegularExpression=use_regex
    replace.SearchCaseSensitive = True
    replace.SearchAll=False
    # if bold is True:
        # replace.queryInterface(XPropertyReplace)
        # x = PropertyValue()]
        # x.Name = "CharWeight"
        # x.Value = BOLD
        # replace.setReplaceAttributes(x)
        # replace.setReplaceAttributes(x)
        # replaceAttribute = PropertyValue()
        # replaceAttribute.Name = 'FontWeight'
        # replaceAttribute.Value = BOLD
        # replace.setReplaceAttributes(replaceAttribute)

        # replace.setPropertyValue("FontWeight", BOLD)
    #     ReplaceAttributes = PropertyValue
    #     ReplaceAttributes.Name = "FontWeight"
    #     ReplaceAttributes.Value = 150
    #     # ReplaceAttributes(0).Name = "FontWeight"
    #     # ReplaceAttributes(0).Value = com.sun.star.awt.FontWeight.BOLD
    #     replace.setReplaceAttributes(ReplaceAttributes)

    document.replaceAll(replace)

def main():
    replace('\.\s*', '.  ', use_regex=True)
    replace('\?\s*', '?  ', use_regex=True)
    replace('([0-9]+)\.\s{1,}([0-9]+)', '$1.$2', use_regex=True)
    d = {
        "p\.\s{1,}m\.{1,}": "p.m.",
        "P\.\s{1,}M\.{1,}": "P.M.",
        "a\.\s{1,}m\.{1,}": "a.m.",
        "A\.\s{1,}M\.{1,}": "A.M.",
        "Mr\.\s{1,}": "Mr. ",
        "Mrs\.\s{1,}": "Mrs. ",
        "MR\.\s{1,}": "MR. ",
        "MRS\.\s{1,}": "MRS. ",
        "Ms\.\s{1,}": "Ms. ",
        "MS\.\s{1,}": "MS. ",
        "Dr\.\s{1,}": "Dr. ",
        "Inc\.\s{2,}": "Inc. ",
        "INC\.\s{2,}": "INC. ",
        "St\.\s{1,}": "St. ",
        "\.\s{1,}\.\s{1,}\.\s{1,}": "...  ",
        # "\.  \.  \.  ": "...",
        '\.\s{1,}\"': '."',
        '\?\s{1,}\"': '?"',
        '\.\s{1,}\)': '.)',
        '\?\s{1,}\]': '?]',
        '\.\s{1,}”': '.”  ',
        '\?\s{1,}”': '?”  ',
        '\?”\s{3,}': '?”  ',
        '\.”\s{3,}': '.”  ',
        "\.\s{1,},": ".,",
        "\.\s{1,}\?": ".?",
        '---': '--',
        "\.\s{1,}com":'.com',
        "\.\s{1,}net":'.net',
        "\.\s{1,}gov":'.gov',
        "www\.\s{1,}":'www.',
        "\.\s{1,}:": '.:',
        ":\s{1,}": ":  ",
        "p\.m\.\s{2,}": "p.m. ",
        "P\.M\.\s{2,}": "P.M. ",
        "a\.m\.\s{2,}": "a.m. ",
        "A\.M\.\s{2,}": "A.M. ",
    }

    for k, v in d.items():
        replace(k, v, use_regex=True)

# def bold_questions():
#     replace("^\s*Q.*$", "&", use_regex=True, bold=True)

    # replace()
    # replace()
    # replace()
    # search.SearchString = "MR. ROTH"
    # search.SearchAll = True
    # search.SearchWords = True
    # search.SearchCaseSensitive = False
    # selsFound = document.findAll(search)
    #
    # if selsFound.getCount() == 0:
    #         return ""
    #
    # for selIndex in range(0, selsFound.getCount()):
    #     selFound = selsFound.getByIndex(selIndex)
    #     selFound.setString(search.SearchString.lower())
