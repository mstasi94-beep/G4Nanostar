// Set input and output directories
input = getDirectory("Choose input folder");
output = "/Users/mstasi/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Documents/01_Projects/01_DNA_G4_LLPS/00_Paper/Data/Droplet_Characterization_Microscopy/Fig4_Radius_smallmolecule/PhenDC3/Replicate1/02_Masks/";

// Set measurements once before the loop
run("Set Measurements...", "area shape area_fraction redirect=None decimal=5");

// Get list of files in input folder
list = getFileList(input);

for (i = 0; i < list.length; i++) {
    // Skip non-image files
    if (endsWith(list[i], ".tif") || endsWith(list[i], ".tiff") || endsWith(list[i], ".png")) {
        // Open image
        open(input + list[i]);
        image_name = getTitle();
        image_name_noext = replace(image_name, "\\..*$", "");
        print("Processing: " + image_name);
        // Process
       run("Remove Overlay");
        saveAs("Tiff", output + image_name_noext + "_NoOvr.tif");
        // Close all windows before next image
        close("*");
    }
}

print("Batch processing complete!");
