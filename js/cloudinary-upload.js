$("#uploadImages").cloudinary_upload_widget({
    cloud_name: "kdsuneraavinash",
    upload_preset: "moraevents-preset",
    folder: "moraevents",
    sources: ["local", "url", "facebook", "instagram"],
    resource_type: "image",
    minImageHeight: 200,
    minImageWidth: 100,
    form: "#event_form",
    fieldName: "uploaded_images[]",
    buttonCaption: "Upload Images",
    thumbnails: ".feature_thumb",
    thumbnail_transformation: {
      width: 100,
      height: 100,
      crop: "fit"
    },
    styles: {
      palette: {
        "window": "#000000",
        "sourceBg": "#103f54",
        "windowBorder": "#ffffff",
        "tabIcon": "#b71c1c",
        "inactiveTabIcon": "#ffffff",
        "menuIcons": "#ffccff",
        "link": "#b71c1c",
        "action": "#33ffcc",
        "inProgress": "#00ffcc",
        "complete": "#00b300",
        "error": "#b30000",
        "textDark": "#000000",
        "textLight": "#ffffff"
      },
    },
  },
  function (error, result) {}
);