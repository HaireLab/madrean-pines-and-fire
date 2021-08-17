# vigilant-bassoon
The purpose of this repository is to document the methods and results for exploratory, quantitative and conceptual models of pine species distributions in relation to fire, in the context of changing climate. The study area is the sky islands of the US and Mexico.

### Spatial models that quantify fire regime attributes, e.g. predicted burn severity at multiple scales; persistent and transient fire refugia.
Coming soon. Investigating the option of downscaling predictors, i.e., bioclimatic variables (1991-2020 normals) to use in burn severity models. See: downscaling.example.R

Fire refugia models are under development for a set of large fires (low severity ~ terrain metrics + burn date + drought/water deficit metrics)

### Exploratory (e.g. graphical) and predictive models (e.g. regression) of the distribution of pines in relation to fire regime attributes.
gbm.sppprob.dnbr.R: First start at setting up analysis with a random sample of points. Modifying to generate and analyze many model outputs using multiple stratified random subsample of the data.

### Conceptual models that build upon existing theories related to species adaptations to fire.
The visualizations produced in these scripts will be evaluated in the context of findings in:
Rainsford, Frederick W, Luke T Kelly, Steve W J Leonard, and Andrew F Bennett. 2021. “Post-Fire Habitat Relationships for Birds Differ among Ecosystems.” Biological Conservation 260: 109218. https://doi.org/https://doi.org/10.1016/j.biocon.2021.109218.

See fires-pines-habitats.png for a first try at the layout of the graphs and other information that will comprise the conceptual models.

times.burned.hexbinplots.R: sample the times burned raster (1985-2011) at random point locations and plot using stat summaries in hexbins

time.since.fire.hexbins.R: sample the fire perimeters (1985-2011) at random point locations and plot using stat summaries in hexbins

dnbr.hexbins.R: sample the stacked dnbr images (1985-2011) at random point locations and plot using stat summaries in hexbins

sdms.hexbinplots.R: sample the species distribution models for the five pines (terrain + ndvi) at random point locations and plot using stat summaries in hexbins
