% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/network_mask.R
\name{netmask}
\alias{netmask}
\alias{prefix_length}
\alias{hostmask}
\alias{netmask.ip_network}
\alias{hostmask.ip_network}
\alias{netmask.ip_interface}
\alias{hostmask.ip_interface}
\alias{netmask.default}
\alias{hostmask.default}
\title{Network mask}
\usage{
prefix_length(x)

netmask(...)

hostmask(...)

\method{netmask}{ip_network}(x, ...)

\method{hostmask}{ip_network}(x, ...)

\method{netmask}{ip_interface}(x, ...)

\method{hostmask}{ip_interface}(x, ...)

\method{netmask}{default}(prefix_length = integer(), is_ipv6 = logical(), ...)

\method{hostmask}{default}(prefix_length = integer(), is_ipv6 = logical(), ...)
}
\arguments{
\item{x}{An \code{\link{ip_network}} or \code{\link{ip_interface}} vector}

\item{...}{Arguments to be passed to other methods}

\item{prefix_length}{An integer vector}

\item{is_ipv6}{A logical vector}
}
\value{
\itemize{
\item \code{prefix_length()} returns an integer vector
\item \code{netmask()} and \code{hostmask()} return an \code{\link{ip_address}} vector
}
}
\description{
These functions yield equivalent representations of the network mask.
}
\examples{
x <- ip_network(c("192.168.0.0/22", "2001:db00::0/26"))

prefix_length(x)

netmask(x)

hostmask(x)

netmask(c(22L, 26L), c(FALSE, TRUE))

hostmask(c(22L, 26L), c(FALSE, TRUE))
}
\seealso{
\code{\link[=max_prefix_length]{max_prefix_length()}}
}
