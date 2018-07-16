from shutil import copyfile

files = ["index.php", "about.php", "addevent.php",
         "footer.php", "header.php", "login_form.php", "logout_form.php", "signup_notice.php",
         "post\\login.php", "post\\logout.php", "js\\cloudinary-upload.js", "post.php", 
         "css\\animations.css", "css\\stylesheet.css",
         "js\\form-validate.js", "js\\events.js", "js\\firestore-db.js"
         ]

for f in files:
    try:
        copyfile("F:\\Projects\\Web\\moraevent-site\\" + f,
             "C:\\wamp\\www\\" + f)
    except Exception as e:
        print (f, "failed:", e)
    else:
        print (f, "done...")
