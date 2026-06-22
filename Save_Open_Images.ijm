// Macro for saving sets of images with increasing index in the name. 
// Use it for preparing tiff of droplet size analysis pipeline

// ===== USER SETTINGS =====
outputFolder = getDirectory("Choose output folder");
baseName     = "T1_PhenDC3_10_3";                        // prefix for saved files
fileFormat   = "Tiff";                           // "Tiff", "PNG", "Jpeg", etc.
extension    = ".tif";                           // must match fileFormat
// =========================

n = nImages;
if (n == 0) exit("No images are open.");

// Create the folder if it doesn't exist
//if (!File.exists(outputFolder)) File.makeDirectory(outputFolder);

setBatchMode(false);  // set to true if you want it to run silently/faster

for (i = 1; i <= n; i++) {
    selectImage(i);
    savePath = outputFolder + baseName + "_" + i + extension;
    saveAs(fileFormat, savePath);
}

showMessage("Done", "Saved " + n + " images to:\n" + outputFolder);