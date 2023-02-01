# nationalism_CMP
Examining the prevalence of nationalism in party manifestos over time using the Comparative Manifesto Project data.


For replication, I suggest utilizing the Rproject workflow to keep file structure intact. 

# Included Files

## `report.RMD` 
This is an Rmarkdown file that generates the final report. Each of the included scripts (i.e., to load and clean data, generate figures, etc.) are called within the document, such that compiling the document runs all required scripts (in the correct order). Note that compilation will fail without a Comparative Manifesto Project (CMP) API key placed within the project folder.

## `get_data.R`
Loads required packages and queries the CMP API for full dataset (via the `manifestoR` package). **Requires API key stored in project folder**. Stores data as .csv file. 

## `cleaning_data.R`
Cleans and reshapes data for plotting. 

## `plot_interactive.R`
Generates an interactive scatterplot of prevalance of statements across 4 nationalism measures. 

## `table_top50.r`
Creates a `gt` table of the top-50 parties, sorted by a composite measure of nationalistic statments in manifestos. 
