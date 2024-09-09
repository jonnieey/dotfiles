c.new_instance_open_target_window = "last-focused"
c.new_instance_open_target = "tab"
c.colors.webpage.darkmode.enabled = True
c.downloads.location.directory = "~/Downloads/qutebrowser"
c.downloads.location.prompt = False
c.fileselect.handler = "external"
c.fileselect.multiple_files.command = ["st", "-e", "clifm", "--sel-file={}"]
c.fileselect.single_file.command = ["st", "-e", "clifm", "--sel-file={}"]
# [
#     "st",
#     "-e",
#     "/home/sato/.config/clifm/plugins/call_file_picker.sh",
# ]
