# -*- coding: utf-8 -*-
# exhibit_marker.py
import re
import uno

def mark_exhibits(*args):
    ctx = uno.getComponentContext()
    doc = XSCRIPTCONTEXT.getDocument()
    controller = doc.getCurrentController()
    text = doc.getText()

    # ------------------------------------------------------------------
    # Step 1: Find exhibit tags
    # Supports: Exhibit 1, Exhibit 1A, Exhibit A  (letter-only added)
    # ------------------------------------------------------------------
    search_desc = doc.createSearchDescriptor()
    search_desc.setPropertyValue("SearchRegularExpression", True)
    search_desc.setPropertyValue("SearchAll", True)
    EXHIBIT_PATTERN = r"\(Thereupon[^)]*?Exhibit\s+(?:\d+[A-Za-z]?|[A-Za-z]+)[^)]*?\)"
    search_desc.setSearchString(EXHIBIT_PATTERN)
    found_ranges = doc.findAll(search_desc)

    if not found_ranges or found_ranges.getCount() == 0:
        _show_message(doc, "No exhibit tags found in the document.")
        return None

    # ------------------------------------------------------------------
    # Step 2: Extract exhibit info — split by party
    # ------------------------------------------------------------------
    plaintiff_exhibits = {}
    defendant_exhibits = {}

    for i in range(found_ranges.getCount()):
        text_range = found_ranges.getByIndex(i)
        match_text = text_range.getString()

        # Extract exhibit ID — number+letter, number only, OR letter only
        m = re.search(r'Exhibit\s+(\d+[A-Za-z]?|[A-Za-z]+)', match_text, re.IGNORECASE)
        if not m:
            continue
        exhibit_id = m.group(1).upper()

        # Detect party from tag text; default to plaintiff when ambiguous
        is_defendant = bool(re.search(r'\bdefendant\b', match_text, re.IGNORECASE))
        is_plaintiff = bool(re.search(r'\bplaintiff\b', match_text, re.IGNORECASE))
        if is_defendant and not is_plaintiff:
            party = "defendant"
        else:
            party = "plaintiff"

        # Get page number
        controller.select(text_range)
        view_cursor = controller.getViewCursor()
        page_num = view_cursor.getPage()

        # Priority 1: [TAG]
        tag_match = re.search(r'\[\s*([A-Za-z ]+)\s*\]', match_text)
        if tag_match:
            description = tag_match.group(1).strip().upper()
        else:
            if re.search(r'Composite\s+Exhibit', match_text, re.IGNORECASE):
                description = "COMPOSITE EXHIBIT"
            else:
                description = "DOCUMENT"

        # Remove [TAG] from document text
        clean_text = re.sub(r'\s*\[\s*[A-Za-z ]+\s*\]', '', match_text)
        text_range.setString(clean_text)

        # Store first occurrence only
        target = defendant_exhibits if party == "defendant" else plaintiff_exhibits
        if exhibit_id not in target:
            target[exhibit_id] = (description, page_num)

    if not plaintiff_exhibits and not defendant_exhibits:
        _show_message(doc, "Could not parse any exhibit numbers.")
        return None

    # ------------------------------------------------------------------
    # Step 3: Sort key — handles A/B/C, 1/2/10, 1A/2B
    # ------------------------------------------------------------------
    def sort_key(exhibit_id):
        m = re.match(r'^(\d+)([A-Za-z]?)$', exhibit_id)
        if m:
            # Numeric (with optional letter suffix): sort numerically
            return (1, int(m.group(1)), m.group(2).upper())
        # Letter-only (A, B, AA …): sort alphabetically, listed first
        return (0, 0, exhibit_id.upper())

    # ------------------------------------------------------------------
    # Step 4: Build a formatted section for one party
    # ------------------------------------------------------------------
    def build_section(title, exhibits_dict, show_title=True):
        if not exhibits_dict:
            return ""
        sorted_ex = sorted(exhibits_dict.items(), key=lambda x: sort_key(x[0]))
        rows = [f"{'':>3}{ex_id:<14}{desc:<37}{page}"
                for ex_id, (desc, page) in sorted_ex]
        if show_title:
            header = f"{title}\n{'EXHIBIT':<17}{'DESCRIPTION':<37}PAGE"
            return header + "\n\n" + "\n".join(rows)
        else:
            header = f"{'EXHIBIT':<17}{'DESCRIPTION':<37}PAGE"
            return header + "\n\n" + "\n".join(rows)

    both_present = bool(plaintiff_exhibits) and bool(defendant_exhibits)

    sections = []
    if plaintiff_exhibits:
        sections.append(build_section("PLAINTIFF'S EXHIBITS", plaintiff_exhibits, show_title=both_present))
    if defendant_exhibits:
        sections.append(build_section("DEFENDANT'S EXHIBITS", defendant_exhibits, show_title=both_present))

    index_text = "\n\n".join(sections)

    # ------------------------------------------------------------------
    # Step 5: Replace [MARKED EXHIBITS] marker
    # ------------------------------------------------------------------
    marker_search = doc.createSearchDescriptor()
    marker_search.setPropertyValue("SearchRegularExpression", False)
    marker_search.setSearchString("[MARKED EXHIBITS]")
    marker_range = doc.findFirst(marker_search)

    if marker_range is None:
        _show_message(doc, "Could not find [MARKED EXHIBITS] tag in the document.")
        return None

    cursor = text.createTextCursorByRange(marker_range)
    cursor.setString(index_text)

    total = len(plaintiff_exhibits) + len(defendant_exhibits)
    p_count = len(plaintiff_exhibits)
    d_count = len(defendant_exhibits)
    _show_message(doc,
        f"Done! {total} exhibit(s) indexed — "
        f"{p_count} Plaintiff's, {d_count} Defendant's.")
    return None


def _show_message(doc, msg):
    ctx = uno.getComponentContext()
    smgr = ctx.ServiceManager
    toolkit = smgr.createInstanceWithContext("com.sun.star.awt.Toolkit", ctx)
    msgbox = toolkit.createMessageBox(
        doc.getCurrentController().getFrame().getContainerWindow(),
        uno.Enum("com.sun.star.awt.MessageBoxType", "MESSAGEBOX"),
        1,
        "Exhibit Marker",
        msg
    )
    msgbox.execute()


g_exportedScripts = (mark_exhibits,)
