% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/1_ModelsHeader.R, R/2_SimpleModels.R, R/3_ComplexModels.R
\name{FWq}
\alias{FWq}
\alias{FWq.M_M_1}
\alias{FWq.M_M_1_INF_H}
\alias{FWq.M_M_1_K}
\alias{FWq.M_M_INF}
\alias{FWq.M_M_S}
\alias{FWq.M_M_S_INF_H}
\alias{FWq.M_M_S_INF_H_Y}
\alias{FWq.M_M_S_K}
\alias{FWq.MarkovianModel}
\title{Distribution function of the waiting time in the queue}
\usage{
FWq(qm, x)
}
\arguments{
\item{qm}{Queueing model}

\item{x}{Time}
}
\value{
\ifelse{latex}{\deqn{W_{q}(x)}}{\out{<i>W<sub>q</sub>(x)</i>}}
}
\description{
Returns the value of the cumulative distribution function of the waiting time in the queue
 \ifelse{latex}{\deqn{W_{q} = P(W_{q} \le x)}}{\out{<br><center><i>W<sub>q</sub> = P(W<sub>q</sub> &le; x)</i></center>}}
}
\section{Methods (by class)}{
\itemize{
\item \code{MarkovianModel}: Implements the default method (generates a message)

\item \code{M_M_1}: Implements the method for a M/M/1 queueing model

\item \code{M_M_S}: Implements the method for a M/M/S queueing model

\item \code{M_M_1_K}: Implements the method for a M/M/1/K queueing model

\item \code{M_M_S_K}: Implements the method for a M/M/S/K queueing model

\item \code{M_M_1_INF_H}: Implements the method for a M/M/1/\eqn{\infty}/H queueing model

\item \code{M_M_S_INF_H}: Implements the method for a M/M/s/\eqn{\infty}/H queueing model

\item \code{M_M_S_INF_H_Y}: Implements the method for a M/M/s/\eqn{\infty}/H with Y replacements queueing model

\item \code{M_M_INF}: Implements the method for a M/M/\eqn{\infty} queueing model
}}
\examples{
#Cumulative probability of waiting 1 unit
 #of time in the system
 FWq(M_M_1(), 1)
 FWq(M_M_S_K(), 1)

 #You can also get multiple probabilities
 #at once
 FWq(M_M_1_INF_H(), c(0, 0.25,0.8))
 FWq(M_M_INF(), c(0, 0.25, 0.8))
}

