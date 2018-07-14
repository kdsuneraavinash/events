from shutil import copyfile

files = ["index.php", "about.php", "addevent.php",
         "footer.php", "header.php",
         "css\\animations.css", "css\\stylesheet.css",
         "js\\form-validate.js"
         ]

for f in files:
    try:
        copyfile("F:\\Projects\\Web\\moraevent-site\\" + f,
             "C:\\wamp\\www\\" + f)
    except Exception as e:
        print (f, "failed:", e)
    else:
        print (f, "done...")
