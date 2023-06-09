This work contains data from Vanadzina, K., Street, S. E., Healy, S. D., Laland, K. N., & Sheard, C. (2023). Global drivers of variation in cup nest size in passerine birds. Journal of Animal Ecology, 92, 338– 351. The data obtained from the data set shared in this article, and the code used for analysis and the processed data set based on these data. The original dataset in the paper consists of measurements of passerine cup nests obtained from museum specimens and literature, as well as a set of life history, biogeographic and environmental variables associated with each species. The data set used in the analysis mainly extracted the variables related to Migrant status and other numerical variables in the original data set for analysis.

Some interpretations of the used data involved in the raw data are as follows:
Nest size measurements:
*Outer volume (cm3)
*Inner volume (cm3)
*Outer volume - full (cm3)
*External diameter (cm)
*Thickness (cm)
*External height (cm)
*Internal diameter (cm)
*Internal height (cm)

Life-history:
*Body mass (g)
*Clutch size
*Migration status ('Not a Migrant,'Nomadic'- non-migratory;  'Full Migrant','Altitudinal Migrant' - migratory)
*Nestling period (time in days from hatching until leaving the nest)

Nest location:
*Average height of species’ nest site from the ground (m)


Biogeography:
*Range midpoint('Latitude of species') 
Insularity - insular if more than 90% of species' range overlaps with landmass shapefiles that are smaller than a) 2,000,000 km2 (Insularity) or b) 2,000 km2 (Insularity_2).

Environment:
*Mean temperature - For tropical species (species' range midpoint between 23.5° and -23.5° in latitude): annual mean temperature.  For temperate species: mean temperature  from March to June or from September to December (inclusive) for northern (above 23.5° in latitude) and southern (below -23.5° in latitude) hemisphere species, respectively.
*Mean rainfall - For tropical species (species' range midpoint between 23.5° and -23.5° in latitude): annual mean precipitation.  For temperate species: mean precipitation from March to June or from September to December (inclusive) for northern (above 23.5° in latitude) and southern (below -23.5° in latitude) hemisphere species, respectively.

The R code included lists the whole process of data analysis in the paper, and generates related pictures.
How the data is used :
Some numerical variables in the original data were logarithmically processed, while other types of variables remained basically unchanged.

Different versions of data :
*nests : raw data
*nest : The data obtained after removing the N/A value in the original data
*nest_clean : New dataset after removing data with variable = 0 from nest
*numeric_vars : A new data set composed of numerical variables filtered out from nestclean

Details about the code that is used for preprocessing the data :
*nests : Use the package"readxl" and "openxlsx" to read the file
*nest : Use the function "na.omit()"
*nest_clean : Use the function "subset()"
*numeric_vars : Use the function "select_if()"

Brief examples :
When I want to clean out the N/A values in the nests, I use the following code :
nest <- na.omit(nests)