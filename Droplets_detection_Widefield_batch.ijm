// Set input and output directories
//input = getDirectory("Choose input folder");
//input = "/Users/mstasi/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Documents/01_Projects/01_DNA_G4_LLPS/00_Paper/Data/Droplet_Characterization_Microscopy/Fig4_Radius_smallmolecule/PhenDC3/Nikon_Replicate1/260324_T4_PhenDC3_Nikon/";
//output = "/Users/mstasi/Library/CloudStorage/OneDrive-ImperialCollegeLondon/Documents/01_Projects/01_DNA_G4_LLPS/00_Paper/Data/Droplet_Characterization_Microscopy/Fig4_Radius_smallmolecule/PhenDC3/Nikon_Replicate1/260324_T4_PhenDC3_Nikon/";
input = getDirectory("Choose INPUT folder");
if (input == "") exit("No input folder selected. Macro cancelled.");

output1 = getDirectory("Choose OUTPUT folder");
if (output1 == "") exit("No output folder selected. Macro cancelled.");

output2 = getDirectory("Choose OUTPUT folder");
if (output2 == "") exit("No output folder selected. Macro cancelled.");
// Set measurements once before the loop
run("Set Measurements...", "area shape area_fraction redirect=None decimal=2");

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
        run("Duplicate...", " ");
        //run("Gaussian Blur...", "sigma=1");
        //run("Minimum...", "radius=1");
        //run("Subtract Background...", "rolling=50");
        run("Auto Threshold", "method=Otsu ignore_black white");
        run("Erode");
        run("Watershed");
        run("Analyze Particles...", "size=1-Infinity display exclude clear overlay add");

        // Save results
        saveAs("Results", output1 + image_name_noext + "_measurements.csv");
		saveAs("Tiff", output2 + image_name_noext + "_mask.tiff");
        // Close all windows before next image
        close("*");
    }
}

print("Batch processing complete!");
