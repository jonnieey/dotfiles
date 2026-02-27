from com.sun.star.beans import PropertyValue
from com.sun.star.awt.FontWeight import BOLD

def replace_patterns(patterns_dict, use_regex=True, bold=False):
    """Helper function to replace multiple patterns efficiently"""
    document = XSCRIPTCONTEXT.getDocument()
    replace = document.createReplaceDescriptor()
    
    replace.SearchRegularExpression = use_regex
    replace.SearchCaseSensitive = True
    replace.SearchAll = False
    
    if bold:
        prop = PropertyValue()
        prop.Name = "CharWeight"
        prop.Value = BOLD
        replace.setReplaceAttributes((prop,))
    
    for s_string, r_string in patterns_dict.items():
        replace.SearchString = s_string
        replace.ReplaceString = r_string
        document.replaceAll(replace)

def bold_specific_lines(pattern):
    """Apply bold formatting to lines matching the pattern"""
    document = XSCRIPTCONTEXT.getDocument()
    search = document.createSearchDescriptor()
    
    search.SearchString = pattern
    search.SearchRegularExpression = True
    
    prop = PropertyValue()
    prop.Name = "CharWeight"
    prop.Value = BOLD
    
    found = document.findFirst(search)
    while found:
        found.setPropertyValue("CharWeight", BOLD)
        found = document.findNext(found.End, search)

def highlight_patterns(patterns, color=0xFFFF00):  # Yellow highlight by default
    """Highlight text matching patterns with a background color"""
    document = XSCRIPTCONTEXT.getDocument()
    
    for pattern in patterns:
        search = document.createSearchDescriptor()
        search.SearchString = pattern
        search.SearchRegularExpression = True
        
        found = document.findFirst(search)
        while found:
            # Apply highlight color
            found.setPropertyValue("CharBackColor", color)
            found = document.findNext(found.End, search)

def main():
    # Define all replacement patterns in one dictionary
    REPLACEMENT_PATTERNS = {
        r'\.\s*': '.  ',
        r'\?\s*': '?  ',
        r'([0-9]+)\.\s{1,}([0-9]+)': r'$1.$2',
        r'p\.\s{1,}m\.{1,}': 'p.m.',
        r'P\.\s{1,}M\.{1,}': 'P.M.',
        r'a\.\s{1,}m\.{1,}': 'a.m.',
        r'A\.\s{1,}M\.{1,}': 'A.M.',
        r'Mr\.\s{1,}': 'Mr. ',
        r'Mrs\.\s{1,}': 'Mrs. ',
        r'MR\.\s{1,}': 'MR. ',
        r'MRS\.\s{1,}': 'MRS. ',
        r'Ms\.\s{1,}': 'Ms. ',
        r'MS\.\s{1,}': 'MS. ',
        r'Dr\.\s{1,}': 'Dr. ',
        r'Inc\.\s{2,}': 'Inc. ',
        r'INC\.\s{2,}': 'INC. ',
        r'St\.\s{1,}': 'St. ',
        r'\.\s{1,}\.\s{1,}\.\s{1,}': '...  ',
        r'\.\s{1,}\"': '."',
        r'\?\s{1,}\"': '?"',
        r'\.\s{1,}\)': '.)',
        r'\?\s{1,}\]': '?]',
        r'\.\s{1,}”': '.”  ',
        r'\?\s{1,}”': '?”  ',
        r'\?”\s{3,}': '?”  ',
        r'\.”\s{3,}': '.”  ',
        r'\.\s{1,},': '.,',
        r'\.\s{1,}\?': '.?',
        r'---': '--',
        r'\.\s{1,}com': '.com',
        r'\.\s{1,}net': '.net',
        r'\.\s{1,}gov': '.gov',
        r'www\.\s{1,}': 'www.',
        r'\.\s{1,}:': '.:',
        r':\s{1,}': ':  ',
        r'p\.m\.\s{2,}': 'p.m. ',
        r'P\.M\.\s{2,}': 'P.M. ',
        r'a\.m\.\s{2,}': 'a.m. ',
        r'A\.M\.\s{2,}': 'A.M. ',
    }
    HIGHLIGHT_PATTERNS = [
        r'\[\?\]',          # Matches [?]
        r'\[\d{2}:\d{2}:\d{2}\]',  # Matches time format [00:01:04]
    ]

    # Process all replacements in one call
    replace_patterns(REPLACEMENT_PATTERNS)
    
    # Bold question lines
    bold_specific_lines(r'^\s*\*?Q\t.*$')

    highlight_patterns(HIGHLIGHT_PATTERNS)

