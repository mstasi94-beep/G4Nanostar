// Set input and output directories
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

        // Difference of Gaussian (radius 3 and 1)
        run("Duplicate...", "title=g3");
        run("Gaussian Blur...", "sigma=3");
        selectWindow(image_name);
        run("Duplicate...", "title=g1");
        run("Gaussian Blur...", "sigma=1");
        imageCalculator("Subtract create 8-bit", "g1", "g3");
        selectWindow("Result of g1");
        rename("DoG");
        close("g1");
        close("g3");

        // Threshold
        selectWindow("DoG");
        run("Auto Threshold", "method=Li ignore_black white");
        //run("Erode");
        //run("Watershed");
        run("Analyze Particles...", "size=1-Infinity display exclude clear overlay add");

        // Save results
        saveAs("Results", output1 + image_name_noext + "_measurements.csv");
        saveAs("Tiff", output2 + image_name_noext + "_mask.tiff");

        // Close all windows before next image
        close("*");
    }
}

print("Batch processing complete!");
