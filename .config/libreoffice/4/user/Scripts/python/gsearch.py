import webbrowser
import urllib.parse

def search_google_selection(*args):
    """Grabs the current selection in Writer and opens it in a browser."""
    # XSCRIPTCONTEXT is pre-defined in the LibreOffice Python environment
    desktop = XSCRIPTCONTEXT.getDesktop()
    model = desktop.getCurrentComponent()
    
    # Get the current selection
    selection = model.getCurrentSelection()
    if not selection:
        return

    # Extract the string from the first selected block
    try:
        selected_text = selection.getByIndex(0).getString()
        if selected_text.strip():
            # URL encode the text for safety
            query = urllib.parse.quote(selected_text)
            url = f"https://www.google.com/search?q={query}"
            webbrowser.open(url)
    except Exception:
        # Silently fail if no text is selected
        pass

# Optional: This allows the function to show up in the Macro Selector
g_exportedScripts = (search_google_selection,)
