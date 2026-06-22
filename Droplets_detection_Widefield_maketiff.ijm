// Set input and output directories
//input = getDirectory("Choose input folder");
//input = "/Users/mstasi/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Documents/01_Projects/01_DNA_G4_LLPS/00_Paper/Data/Droplet_Characterization_Microscopy/Fig4_Radius_smallmolecule/PhenDC3/Nikon_Replicate1/260324_T4_PhenDC3_Nikon/";
//output = "/Users/mstasi/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Documents/01_Projects/01_DNA_G4_LLPS/00_Paper/Data/Droplet_Characterization_Microscopy/Fig4_Radius_smallmolecule/PhenDC3/Nikon_Replicate1/03_Tiff_processed/";
input = getDirectory("Choose INPUT folder");
if (input == "") exit("No input folder selected. Macro cancelled.");

output = getDirectory("Choose OUTPUT folder");
if (output == "") exit("No output folder selected. Macro cancelled.");
// Get list of files in input folder
list = getFileList(input);

for (i = 0; i < list.length; i++) {
    // Skip non-image files
    if (endsWith(list[i], ".tif") ||  endsWith(list[i], ".png")) {
        // Open image
        open(input + list[i]);
        image_name = getTitle();
        image_name_noext = replace(image_name, "\\..*$", "");
        print("Processing: " + image_name);

        // Process
        run("Duplicate...", " ");
        //run("Gaussian Blur...", "sigma=2");
        //run("Minimum...", "radius=2");
        run("Subtract Background...", "rolling=50");
        saveAs("Tiff", output + image_name_noext + "_preprocessed.tif");
        // Close all windows before next image
        close("*");
    }
}

print("Batch processing complete!");
