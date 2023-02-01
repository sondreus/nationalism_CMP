# nationalism_CMP
Examining the prevalence of nationalism in party manifestos over time using the [Comparative Manifesto Project](https://manifesto-project.wzb.eu) data.

The final report can be viewed [here](https://sdbock.github.io/nationalism_CMP/).
# Included files for replication
For replication, I suggest utilizing the Rproject workflow to keep file structure intact. 

## `report.RMD` 
This is an Rmarkdown file that generates the final report. Each of the included scripts (i.e., to load and clean data, generate figures, etc.) are called within the document, such that compiling the document runs all required scripts (in the correct order). Note that compilation will fail without a Comparative Manifesto Project (CMP) API key placed within the project folder.

## `get_data.R`
Loads required packages and queries the CMP API for full dataset (via the `manifestoR` package). **Requires [API key](https://manifesto-project.wzb.eu/information/documents/api) stored in project folder**. Generates "cmp.csv". 

## `cleaning_data.R`
Cleans and reshapes data for plotting. 

## `plot_interactive.R`
Generates an interactive scatterplot of prevalance of statements across 4 nationalism measures. 

## `table_top50.r`
Creates a `gt` table of the top-50 parties, sorted by a composite measure of nationalistic statments in manifestos. 
