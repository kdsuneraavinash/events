from shutil import copyfile

files = ["index.php", "about.php", "addevent.php",
         "footer.php", "header.php", "model_forms\\login_form.php", "model_forms\\logout_form.php", "model_forms\\signup_notice.php",
         "user_login\\login.php", "user_login\\logout.php", "js\\cloudinary-upload.js", "post.php", 
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
