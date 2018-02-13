# pic <- image_read('C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src.png', density="36x36")
#
# image_write(pic, path = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src.svg", format = "svg", density = "36x36")
#
#
#
#
# pacman::p_load(svglite,rsvg)
#
# bitmap <- rsvg("C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src.svg",width=3840)
#
# png::writePNG(bitmap, "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src - 4K.png", dpi = 1440)
# browseURL("C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src - 4K.png")
#
#
#
# # read a sample file (R logo)
#
# library(ReporteRs)
#
#
# doc = pptx( )
# doc = addSlide(doc, slide.layout = "Title and Content")
# doc = addPlot(doc, fun = function() {
#   img <- readPNG("C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\nature header src.png")
#   plot(1:2, type='n')
#
#   transparent <- img[,,4] == 0
#   img <- as.raster(img[,,1:3])
#   img[transparent] <- NA
#   rasterImage(img, 1.2, 1.27, 1.8, 1.73, interpolate=FALSE)
# },
# vector.graphic = TRUE, width = 4, height = 6 * 3/4)
# writeDoc(doc, file = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\test.pptx")
#
#
#
#
# pacman::p_load(magick)
# img <- image_read('C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.svg')
#
# img <- image_read('C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\srep20207-f3.jpg')
#
# image_write(img, path = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.emf", format = "emf")
#
#
# library(rsvg)
# bitmap <- rsvg("C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.svg")
# png::writePNG(bitmap, "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.png")
#
# pacman::p_load(devEMF)
# emf(file = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.emf")
# plot(1)
# dev.off()
#
#
# library(devtools)
# # install_github("mukul13/RCloudConvert")
# library(RCloudConvert)
#
# convert_file("c0O823MztUGxW43pQtI2fDu0FgohVgRyqFPyuB4oZNXPhYBeJHa7ZRY3Z-n9hw5-5sgaJvsMPsquoG5vZK17Fg",input_format = "svg",output_format = "emf",input="upload",file="temp.svg",dest_file = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.emf")
#
#
#
#
#
#
# download.file("http://chemrichdb2.fiehnlab.ucdavis.edu/db/abib/scatter%20plot_68410298_1516832876171/test_68410298_1517248588511_68410298_TEMP.svg", "temp.svg", quiet = FALSE)
#
#
# library(RCloudConvert)
#
#
#
# convert_file("c0O823MztUGxW43pQtI2fDu0FgohVgRyqFPyuB4oZNXPhYBeJHa7ZRY3Z-n9hw5-5sgaJvsMPsquoG5vZK17Fg",input_format = "svg",output_format = "emf",input="download",file=URLencode("http://127.0.0.1:5985/abib/scatter%20plot_68410298_1516832876171/test_68410298_1517248588511_68410298_TEMP.svg"),dest_file = "C:\\Users\\Sili\\Documents\\Github\\Abib.alpha\\inst\\www\\img\\bimo\\Scatter plot\\5AL.emf")
#
#







