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
    # ------------------------------------------------------------------
    search_desc = doc.createSearchDescriptor()
    search_desc.setPropertyValue("SearchRegularExpression", True)
    search_desc.setPropertyValue("SearchAll", True)

    EXHIBIT_PATTERN = r"\(Thereupon[^)]*?Exhibit\s+\d+[A-Za-z]?[^)]*?\)"
    search_desc.setSearchString(EXHIBIT_PATTERN)

    found_ranges = doc.findAll(search_desc)

    if not found_ranges or found_ranges.getCount() == 0:
        _show_message(doc, "No exhibit tags found in the document.")
        return None

    # ------------------------------------------------------------------
    # Step 2: Extract exhibit info
    # ------------------------------------------------------------------
    exhibits = {}  # key = "2A", "10", etc.

    for i in range(found_ranges.getCount()):
        text_range = found_ranges.getByIndex(i)
        match_text = text_range.getString()

        # Extract exhibit ID (number + optional letter)
        m = re.search(r'Exhibit\s+(\d+[A-Za-z]?)', match_text, re.IGNORECASE)
        if not m:
            continue

        exhibit_id = m.group(1).upper()  # e.g. "2A", "10"

        # Get page number
        controller.select(text_range)
        view_cursor = controller.getViewCursor()
        page_num = view_cursor.getPage()

        # --------------------------------------------------------------
        # Priority 1: [TAG]
        # --------------------------------------------------------------
        tag_match = re.search(r'\[\s*([A-Za-z ]+)\s*\]', match_text)

        if tag_match:
            description = tag_match.group(1).strip().upper()

        else:
            # ----------------------------------------------------------
            # Priority 2: Composite
            # ----------------------------------------------------------
            if re.search(r'Composite\s+Exhibit', match_text, re.IGNORECASE):
                description = "COMPOSITE EXHIBIT"
            else:
                description = "DOCUMENT"

        # --------------------------------------------------------------
        # Remove [TAG]
        # --------------------------------------------------------------
        clean_text = re.sub(r'\s*\[\s*[A-Za-z ]+\s*\]', '', match_text)
        text_range.setString(clean_text)

        # Store first occurrence
        if exhibit_id not in exhibits:
            exhibits[exhibit_id] = (description, page_num)

    if not exhibits:
        _show_message(doc, "Could not parse any exhibit numbers.")
        return None

    # ------------------------------------------------------------------
    # Step 3: Custom sort (handles 2A, 2B, etc.)
    # ------------------------------------------------------------------
    def sort_key(exhibit_id):
        m = re.match(r'(\d+)([A-Za-z]?)', exhibit_id)
        num = int(m.group(1))
        suffix = m.group(2)
        return (num, suffix)

    sorted_exhibits = sorted(exhibits.items(), key=lambda x: sort_key(x[0]))

    # ------------------------------------------------------------------
    # Step 4: Build formatted index
    # ------------------------------------------------------------------
    lines = []
    lines.append("")

    for ex_id, (desc, page) in sorted_exhibits:
        lines.append(f"{'':>3}{ex_id:<14}{desc:<37}{page}")

    index_text = "\n\n".join(lines)

    # ------------------------------------------------------------------
    # Step 5: Replace marker
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

    _show_message(doc, f"Done! Inserted index for {len(exhibits)} exhibit(s).")
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
