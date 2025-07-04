% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tracer.R
\name{tracer}
\alias{tracer}
\title{Constructor of a tracer object}
\usage{
tracer(
  objects = NULL,
  Delta = 1,
  save = TRUE,
  time = TRUE,
  expr = NULL,
  plotter = NULL,
  ...
)
}
\arguments{
\item{objects}{a character vector of names of the objects that are to be traced.
The objects are searched for in the calling environment of the
\code{tracer} function. Objects created by the \code{expr} argument
can also be traced.}

\item{Delta}{an integer specifying if and how often trace information is printed.
\code{Delta = 0} means never, and otherwise trace information is printed
every \code{Delta}-th iteration. \code{Delta = 1} is the default.}

\item{save}{a logical value. Determines if the trace information is stored.}

\item{time}{a logical value. Determines if runtime information in seconds
is traced.}

\item{expr}{an expression that will be evaluated in an environment that has
the calling environment of the \code{tracer} function as parent.}

\item{plotter}{an expression, possibly created by the \code{plotter} function.}

\item{...}{other arguments passed to \code{format} for printing and
\code{plot.window}}
}
\value{
A tracer object containing the functions \code{tracer}, \code{get} and
\code{clear}.
}
\description{
Tracer objects can collect, print and summarize trace information from
the evaluation environment of other functions during their evaluation.
}
\details{
The function \code{tracer} constructs a tracer object containing a
\code{tracer}, a \code{get} and a \code{clear} function. A call of
the objects \code{tracer} function can
be inserted in other functions and used to collect, print and plot trace information
about the internals of that function during its evaluation. The objects \code{get}
function can access that information afterwards, and its \code{clear} function deletes
all stored values in the tracer object.

A tracer object can trace time (in seconds) between \code{tracer} calls,
which are measured by
the \code{hires_time} function from the bench package. There are \code{print}
and \code{summary} methods available for summarizing the trace information.
A call of the \code{tracer} function can be manually inserted into the body of
the function that is to be traced, it can be inserted using \code{base::trace},
or it can be passed as an argument to any function with a callback argument.
}
\examples{

test_tracer <- tracer(c("m", "m_sq"), expr = quote(m_sq <- m^2))

test <- function(n, cb = NULL) {
  for(i in 1:n) {
    m <- 2 * i
    Sys.sleep(0.1)
    if(!is.null(cb)) cb()
    }
}

test(10, test_tracer$tracer)
summary(test_tracer)
}
