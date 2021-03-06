% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/VisVineR.R
\name{VisVineR}
\alias{VisVineR}
\title{VisVineR}
\usage{
VisVineR(RVM, group, group.size, colours, shape = c("square", "triangle",
  "box", "circle", "dot", "star", "ellipse", "database", "text", "diamond")[1],
  nodesIdSelection = F, seed = 3141)
}
\arguments{
\item{RVM}{RVineMatrix object}

\item{group}{a vector containing the name of the groups (by default, groups are 1)}

\item{group.size}{a vector with the number of variables in each group}

\item{colours}{a vector of length equal to \code{group.size} specifying colours for each group}

\item{shape}{parameter specifying node shape}

\item{seed}{formation seed}
}
\value{
Packages loaded into R
}
\description{
Interface that uses a \code{RVineMatrix} object that can be displayed using \code{visNetworks}
}
\examples{

load_pkg(c("dplyr", "visNetwork", "tidyr", "VineCopula"))

group <- Market_info$Hanjo.Industry \%>\% as.character()
group.size <-  
 Market_info \%>\% 
 group_by(Hanjo.Industry) \%>\%
 summarise(n = n()) \%>\% 
 select(n) \%>\% unlist 
colours <- c("#39c9bb", "#398fc9", "#39c973"," #bb39c9", 	"#c9bb39")

VisVineR(
 RVM,
 group = group,
 group.size = group.size,
 seed = seed,
 colours = colours,
 shape = shape,
 seed = 50)

}
\references{
\url{http://datastorm-open.github.io/visNetwork/}
}

