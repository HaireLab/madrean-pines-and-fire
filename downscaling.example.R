Code below, is from supplementary material:
Rodman, Kyle C., Thomas T. Veblen, Mike A. Battaglia, Marin E. Chambers, Paula J. Fornwalt, Zachary A. Holden, Thomas E. Kolb, Jessica R. Ouzts, and Monica T. Rother. 2020. “A Changing Climate Is Snuffing out Post-Fire Recovery in Montane Forests.” Global Ecology and Biogeography 29 (11): 2039–51. https://doi.org/10.1111/geb.13174.


###################################################################################
####
## NOTE: The following is a simple example of downscaling with the functions above.
# To use in larger areas and at higher resolutions, data must be split into tiles
# and later merged to deal with memory limits on most computers
###################################################################################
####
## Boundary of example area
bounds <- extent(c(-106, -105, 39, 40))
## Getting example data from WorldClim and global DEM
clim <- crop(getData("worldclim",var="tmean",res=0.5,lon=-105, lat = 40)[[1]],
bounds)
elev <- crop(get_elev_raster(clim, z = 8), bounds)
## Projecting both to UTM 13N
clim <- projectRaster(clim, crs = CRS("+proj=utm +zone=13 +ellps=GRS80 +datum=NAD83
+units=m +no_defs"))
elev <- projectRaster(elev, crs = CRS("+proj=utm +zone=13 +ellps=GRS80 +datum=NAD83
+units=m +no_defs"))
## Creating second DEM at same resolution as climate grid
elev_coarse <- projectRaster(from = elev, to = clim)
## NOTE: The goal of the code below is essentially to develop a relationship
between
# the coarse-scale climate data and coarse-scale DEM (aligned and projected to the
# same grid), and use the higher-resolution DEM and coarse-scale climate data to
# interpolate higher-resolution climate surfaces. This could also be done with
higher-
# resolution climate data, as we did for annual AET and CWD in this study.
## A clipping perimeter is necessary for the function
bound_object <- as(bounds, "SpatialPolygons")
crs(bound_object) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
bound_object <- spTransform(bound_object, CRS("+proj=utm +zone=13 +ellps=GRS80
+datum=NAD83 +units=m +no_defs"))
# Reducing the size of clipping perimeter to reduce edge effects. This is how the
function is used
bound_object <- gBuffer(bound_object, width = -20000)
# Showing study area and clipping area
plot(clim)
plot(bound_object, add = T)
## And actually doing the downscaling, takes a minute or so depending on PC.
# Warning message happens because number of raster cells is not evenly divisible
# by number of cores on PC
ds_layer <- multiLevelInterpParrallel(boundary = bound_object, ds_layer = clim,
ancillary_list = list(elev_coarse, elev),
clip_dists = c(20000, 5000, 500))
## Showing difference in number of cells between original layer and downscaled
layer
# Cropping both layers to reduced area to prevent edge effects
clim <- crop(clim, bound_object)
ds_layer <- crop(ds_layer, bound_object)
## Comparing summary statistics in same area. New layer has many more cells than
old layer.
# Means of the two are relaticely similar, but min and max values show wider range
in
# downscaled layer
ncell(clim); cellStats(clim, mean); maxValue(clim); minValue(clim); res(clim)
ncell(ds_layer); cellStats(ds_layer, mean); maxValue(ds_layer); minValue(ds_layer);
res(ds_layer)
## Plotting the two layers (new and old) to show difference in resolutions
par(mfrow = c(1,2))
plot(clim); plot(ds_layer)
par(mfrow = c(1,1))
