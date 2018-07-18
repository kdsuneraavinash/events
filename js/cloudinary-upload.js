// DEPENDANCY: JQuery
// DEPENDANCY: Cloudinary

$("#uploadImages").cloudinary_upload_widget({
    cloud_name: "kdsuneraavinash",
    upload_preset: "moraevents-preset",
    folder: "moraevents",
    sources: ["local", "url", "camera", "facebook", "instagram"],
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
    // https://demo.cloudinary.com/uw/
    styles: {
      palette: {
        "window": "#103f54",
        "sourceBg": "#ffffff",
        "windowBorder": "#90a0b3",
        "tabIcon": "#ffffff",
        "inactiveTabIcon": "#c0c0c0",
        "menuIcons": "#5a616a",
        "link": "#b71c1c",
        "action": "#0080ff",
        "inProgress": "#0078ff",
        "complete": "#20b832",
        "error": "#b71c1c",
        "textDark": "#000000",
        "textLight": "#ffffff"
      },
    },
    
  },


  function (error, result) {
    if (error != null) console.error("CLOUDINARY: " + error);
  }
);