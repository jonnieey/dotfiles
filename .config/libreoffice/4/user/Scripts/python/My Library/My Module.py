# coding: utf-8
from __future__ import unicode_literals

import re

class LibreEditor:
    def __init__(self, text):
        self.text = text
    def replace_fullstops(self):
        pattern = re.compile('\.\s*')
        self.text = re.sub(pattern, ".  ", self.text)

    def replace_question_marks(self):
        pattern = re.compile('\?\s*')
        self.text = re.sub(pattern, "?  ", self.text)

    def replace_decimals(self):

        pattern = re.compile('([0-9]+)\.\s{2}([0-9]+)')
        m =  re.sub(pattern, r"\1.\2", self.text)
        self.text = m

    def multiple_replace(self, dict):
      regex = re.compile("(%s)" % "|".join(map(re.escape, dict.keys())))

      self.text =  regex.sub(lambda mo: dict[mo.string[mo.start():mo.end()]], self.text)

def run_all(text):

    rep = LibreEditor(text=text)
    rep.replace_fullstops()
    rep.replace_question_marks()
    rep.replace_decimals()

    d = {
        "p.  m": "p.m",
        "a.  m": "a.  m",
        "Mr.  ": "Mr. ",
        "MR.  ": "MR. ",
        "Ms.  ": "Ms. ",
        "MS.  ": "MS. ",
    }
    rep.multiple_replace(d)

    print(rep.text)

t = """This is Dr. Alzaaway $323.5232. Are you sure what you are doing? MR. HAYNES: Yes, Mr. Brocolli Yes? p.m. And the rest."""
run_all(t)

