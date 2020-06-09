#' Complete list of palettes
#'
#' Use \code{\link{elgreco_palette}} to construct palettes of desired length.
#'
#' @export
elgreco_palettes <- list(
  AndrewFrancis1 = c("#3F93A6","#91A644","#8C5B30","#73685F","#0D0D0D"),
  AndrewFrancis2 = c("#3F93A6","#8DA1A6","#3C732D","#91A644","#A67041"),
  Annunciation1 = c("#591C27","#D9A74A","#8C5B30","#59422E","#0D0D0D"),
  Annunciation2 = c("#591C27","#2C403E","#8C5B30","#59422E","#261914"),
  Caridad1 = c("#8C7C5D","#593A1E","#F2D4C2","#8C3D35","#260202"),
  Caridad2 = c("#BFB895","#735E45","#F2D4C2","#BF7B75","#8C3030"),
  Disrobing1 = c("#59202F","#D9AD29","#BF8821","#8C591B","#A65D56"),
  Disrobing2 = c("#A9C6D9","#BF8821","#F2E2C4","#8C591B","#D99D8F"),
  Immaculate1 = c("#59202F","#08070D","#BF8821","#8C591B","#73441A"),
  Immaculate2 = c("#59202F","#D9AD29","#BF8821","#8C591B","#A65D56"),
  Laocoon1 = c("#4F868C","#D3D9C5","#735C32","#BFB3A4","#262626"),
  Laocoon2 = c("#54592D","#262522","#403E3B","#A69F92","736E65"),
  Marriage1 = c("#5A798C","#BBDDF2","#BF923F","#A67A44","#593D25"),
  Marriage2 = c("#261D23","#4C6473","#BF923F","#8C6535","#593D25"),
  Shepherds1 = c("#3C5473","#D9AB73","#8C623E","#403128","#D95525"),
  Luke1 = c("#6A7327","#898C2A","#F2D479","#BF984E","#73503C"),
  Luke2 = c("#898C2A","#F2D479","#D9AF62","#594D46","#403432"),
  Toledo1 = c("#225459","#364028","#4E5936","#D99C52","#0D0D0D"),
  Toledo2 = c("#516F73","#34403F","#4E5936","#A6A29C","#D99C52"),
  John1 = c("#809BA6","#BF913B","#D9CAB8","#A69485","#59443C"),
  John2 = c("#4C6C73","#595732","#594842","#261A17","#733636")
)

#' An El Greco palette generator
#'
#' Color palettes from El Greco paintings.
#'
#' @param n Number of colors desired. All color
#'   schemes are derived from El Greco paintings.
#' @param name Name of desired palette. Choices are:
#'   \code{AndrewFrancis1}, \code{AndrewFrancis2},  \code{Annunciation1},
#'   \code{Annunciation2}, \code{Caridad1},  \code{Caridad2}, \code{Disrobing1},
#'   \code{Disrobing2},  \code{Immaculate1} , \code{Immaculate2} ,
#'   \code{Laocoon1}, \code{Laocoon2}, \code{Marriage1}, \code{Marriage2},
#'   \code{Shepherds1}, \code{Luke1}, \code{Luke2}, \code{Toledo1},
#'   \code{Toledo2}, \code{John1}, \code{John2}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' elgreco_palette("Laocoon1")
#' elgreco_palette("Shepherds1")
#' elgreco_palette("Toledo1")
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- elgreco_palette(21, name = "Toledo1", type = "continuous")
elgreco_palette <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- elgreco_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}


