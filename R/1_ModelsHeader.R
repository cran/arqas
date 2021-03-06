#' Defines a queueing model
#'
#' Constructor for \code{MarkovianModel} class.
#'
#' @import methods distr reshape ggplot2 iterators doParallel foreach fitdistrplus gridExtra
#' @param arrivalDistribution Arrival distribution (object of S4-class \code{distr} 
#' defined in \pkg{distr} package)
#' @param serviceDistribution Service distribution (object of S4-class \code{distr} 
#' defined in \pkg{distr} package)
#' @return 
#' An object of class \code{MarkovianModel}, a list with the following components:
#' \item{arrivalDistribution}{Arrival distribution (object of S4-class \code{distr} 
#' defined in \pkg{distr} package)}
#' \item{serviceDistribution}{Service distribution (object of S4-class \code{distr} 
#' defined in \pkg{distr} package)}
#' @export
MarkovianModel <- function (arrivalDistribution = Exp(1), serviceDistribution = Exp(1)) {
  packagearr <- attr(class(arrivalDistribution), "package")
  packageserv <- attr(class(serviceDistribution), "package")
  if (is.null(packagearr) || packagearr != "distr") stop("Argument 'arrivalDistribution' must be a valid Class of the Distr package")
  if (is.null(packageserv)|| packageserv!= "distr") stop("Argument 'serviceDistribution'must be a valid Class of the Distr package")
  
  obj <- list(arrivalDistribution=arrivalDistribution, serviceDistribution=serviceDistribution)
  oldClass(obj) <- "MarkovianModel"
  return(obj)
}

#' Distribution function of the waiting time in the system
#' 
#' Returns the value of the cumulative distribution function of the waiting time in the system
#' for a queueing model
#' \deqn{W(x) = P(W \le x)}
#' 
#' @name FW
#' @param qm Queueing model
#' @param x Time
#' @return \deqn{W(x)}
#' @rdname FW
#' @examples
#' #Cumulative probability of waiting 1 units 
#' #of time in the system
#' FW(M_M_1(), 1)
#' FW(M_M_S_K(), 1)
#' 
#' #You can also get multiple probabilities
#' #at once
#' FW(M_M_1_INF_H(), c(0, 0.25,0.8))
#' FW(M_M_INF(), c(0, 0.25, 0.8))
#' @export
FW <- function(qm, x) {UseMethod("FW", qm)}

#'  Distribution function of the waiting time in the queue
#'  
#'  Returns the value of the cumulative distribution function of the waiting time in the queue
#'  \ifelse{latex}{\deqn{W_{q} = P(W_{q} \le x)}}{\out{<br><center><i>W<sub>q</sub> = P(W<sub>q</sub> &le; x)</i></center>}}
#'  
#'  @name FWq
#'  @param qm Queueing model
#'  @param x Time
#'  @return \ifelse{latex}{\deqn{W_{q}(x)}}{\out{<i>W<sub>q</sub>(x)</i>}}
#'  @rdname FWq
#'  @examples
#'  #Cumulative probability of waiting 1 unit 
#'  #of time in the system
#'  FWq(M_M_1(), 1)
#'  FWq(M_M_S_K(), 1)
#' 
#'  #You can also get multiple probabilities
#'  #at once
#'  FWq(M_M_1_INF_H(), c(0, 0.25,0.8))
#'  FWq(M_M_INF(), c(0, 0.25, 0.8))
#'  @export
FWq <- function(qm, x) {UseMethod("FWq", qm)}

#' Steady-state probability of having n customers in the system
#' 
#' Returns the probability of having n customers in the given queueing model
#' 
#' @name Pn
#' @param qm Queueing model
#' @param n Number of customers. With \code{OpenJacksonNetwork} objects must be a vector with same length as nodes. With \code{ClosedJacksonNetwork} objects also the sum the vector must be equal to the number of customers in the network.
#' @return \ifelse{latex}{\deqn{P_n}}{\out{<i>P<sub>n</sub></i>}}
#' @rdname Pn
#' @examples
#' #Probability of having one customer in the
#' #system
#' Pn(M_M_S(), 1)
#' Pn(M_M_INF(), 1)
#' 
#' #You can also get multiple probabilities
#' #at once
#' Pn(M_M_1_INF_H(), 0:5)
#' Pn(M_M_S_K(), 1:3)
#' 
#' #With networks must be a vector with
#' #same length as nodes
#' 
#' #Probability of having 0 customers in
#' #the node 1, and 2 customers in node 2
#' Pn(OpenJacksonNetwork(), c(0, 2))
#' 
#' #Probability of having 1,2,0, and 0
#' #customers in nodes 1,2,3 and 4 respectively
#' Pn(ClosedJacksonNetwork(), c(1,2,0,0))
#' @export
Pn <- function(qm, n) {UseMethod("Pn", qm)}

#' Steady-state probability of finding n customers in the system when a new customer arrives
#' 
#' Returns the probability of having n customers in the system at the moment of the
#' arrival of a customer.
#' 
#' @param qm Queueing model
#' @param n Customers
#' @return \ifelse{latex}{\deqn{Q_n}}{\out{<i>Q<sub>n</sub></i>}}
#' @rdname Qn
#' @examples
#' #Probability of having one customer in the
#' #queue
#' Qn(M_M_1_K(), 1)
#' Qn(M_M_S_INF_H(), 1)
#' 
#' #You can also get multiple probabilities
#' #at once
#' Qn(M_M_1_INF_H(), 0:5)
#' Qn(M_M_S_K(), 1:3)
#' @export
Qn <- function(qm, n) {UseMethod("Qn", qm)}

#' Steady-state probability of 0 customers in the system on the node i of an Open Jackson Network.
#' 
#' Returns the value of the probability of having 0 customers at node i of an Open Jackson Network.
#' 
#' @param net Network
#' @param i Node. Index starts in 1.
#' @return \ifelse{latex}{\deqn{P_{0,i}}}{\out{<i>P<sub>0,i</sub></i>}}
#' @rdname P0i
#' @examples
#' #Probability of having 0 customers on the node 2
#' P0i(OpenJacksonNetwork(), 2)
#' @export
P0i <- function(net, i) {UseMethod("P0i", net)}

#' Steady-state probability of i customers in the system on the node 0 of an Open Jackson Network.
#' 
#' Returns the value of the probability of i customers in node 0 of an Open Jackson Network.
#' 
#' @param net Open Jackson Network
#' @param i Customers
#' @return \ifelse{latex}{\deqn{P_{i,0}}}{\out{<i>P<sub>i,0</sub></i>}}
#' @keywords internal
Pi0 <- function(net, i) {UseMethod("Pi0", net)}

#' Returns the queueing model which corresponds to the node i of the Open Jackson Network
#' 
#' @param net Open Jackson Network
#' @param i Node
#' @return \code{MarkovianModel} object
#' @rdname node
#' @examples
#' node(OpenJacksonNetwork(), 1)
#' @keywords internal
#' @export
node <- function(net, i) {UseMethod("node", net)}

#' Steady-state probability of n customers at node i of a network.
#' 
#' Returns the value \ifelse{latex}{\eqn{P_{i}(n)}}{\out{<i>P<sub>i</sub>(n)</i>}} in the node i of a Closed Jackson Network
#' 
#' @param net Closed Jackson Network
#' @param n Customers
#' @param node Node
#' @return \ifelse{latex}{\eqn{P_{n}}}{\out{<i>P<sub>n</sub></i>}} in the selected node
#' @rdname Pi
#' @examples
#' #Probability of having 0 customers on node 2
#' Pi(ClosedJacksonNetwork(), 0, 2)
#' 
#' #It is possible obtain multiple probabilities
#' #for a node at once.
#' Pi(ClosedJacksonNetwork(), 0:2, 2)
#' @export
Pi <- function(net, n, node) {UseMethod("Pi", net)}


#' @describeIn FW Implements the default method (generates a message)
#' @method FW MarkovianModel
#' @usage NULL
#' @export
FW.MarkovianModel <- function(qm, x) {stop(simpleError("W(t): Model not defined"))}

#' @describeIn FWq Implements the default method (generates a message)
#' @method FWq MarkovianModel
#' @usage NULL
#' @export
FWq.MarkovianModel <- function(qm, x) {stop(simpleError("Wq(t): Model not defined"))}

#' @describeIn Pn Implements the method for a Markovian model
#' @method Pn MarkovianModel
#' @usage NULL
#' @export
Pn.MarkovianModel <- function(qm, n) {stop(simpleError("Pn(t): Model not defined"))}

#' @describeIn Qn Implements the default method (generates a message)
#' @method Qn MarkovianModel
#' @usage NULL
#' @export
Qn.MarkovianModel <- function(qm, n) {stop(simpleError("Qn(t): Model not defined"))}

#' Print the main characteristics of a queueing model
#' @param x MarkovianModel object
#' @param ... Further arguments passed to or from other methods.
#' @method print MarkovianModel
#' @keywords internal
#' @export
print.MarkovianModel <- function(x, ...) {
  cat("Model: ", class(x)[1])
  cat("\nL =\t", x$out$l, "\tW =\t", x$out$w, "\t\tIntensidad =\t", x$out$rho , "\n")
  cat("Lq =\t", x$out$lq, "\tWq =\t", x$out$wq, "\tEficiencia =\t", x$out$eff, "\n\n")
}

#' Shows the main graphics of the parameters of a Markovian Model
#' 
#' @param x Markovian Model
#' @param t range for drawing the waiting plots
#' @param n range for drawing the probabilities plot
#' @param only Allow to only show the waiting plots or the probabilites plots.
#'             Must be NULL, "t" or "n"
#' @param graphics library used to draw the plots 
#' @param ... Further arguments
#' @method plot MarkovianModel
#' @details
#' \code{plot.MarkovianModel} implements the function for an object of class MarkovianModel.
#' @export
plot.MarkovianModel <- function(x, t=list(range=seq(x$out$w, x$out$w*3, length.out=100)), n=c(0:5), only=NULL, graphics="ggplot2",...) {
  switch(graphics,
      "ggplot2" = {if (is.null(only)) {
                        graphics::layout(matrix(c(1,2), nrow=2))
                        gridExtra::grid.arrange(summaryWtWqt(x, t, graphics),
                                     summaryPnQn(x, n, graphics))
                   } else if(only == "t") 
                          summaryWtWqt(x, t, graphics)
                     else if(only == "n") 
                          summaryPnQn(x, n , graphics)
                   },
      "graphics"= {if (is.null(only))
                        graphics::par(mfrow=c(2,1)) 
                   if(is.null(only) || only == "t" ) 
                        summaryWtWqt(x, t, graphics)
                   if(is.null(only) || only == "n" )
                        summaryPnQn(x, n , graphics)
      
      })
}

#' Plot of the waiting times of a Markovian Model
#' 
#' Shows a plot with the W(t) and \ifelse{latex}{\eqn{W_{q}(t)}}{<i>W<sub>q</sub>(t)<i>} values of a Markovian Model
#' @param object Markovian Model
#' @param t Range of t
#' @param graphics Type of graphics: "graphics" uses the basic R plot and "ggplot2" the library ggplot2
#' @keywords internal
summaryWtWqt <- function(object, t, graphics="ggplot2") {
  try({
    epsilon <- 0.001
    if (is.list(t)) {
      searchvalues <- FW(object, t$range)
      closeone <- t$range[which.min(1-searchvalues)]
      t <- seq(0, closeone, 0.01)
    }
    data <- data.frame(t, "W"=FW(object, t), "Wq"=FWq(object, t))
    switch(graphics,
           "graphics" = {                  
                  plot(data$t, data$W, col="red", type="l", ylim=c(0,1),  xlab="t", ylab="W(t) & Wq(t)", ann=FALSE)
                  graphics::lines(data$t, data$Wq, col="blue")
                  graphics::legend("bottomright", c("W", "Wq"), lty =c(1,1), col = c("red", "blue"), bty="n")
                  graphics::title(main=paste("Distribution functions of waiting times (t from ", data$t[1], " to ", data$t[length(data$t)], ")", sep=""))
           },
           "ggplot2" = {
                  value <- variable <- NULL
                  data <- melt(data, id.var="t") 
                  ggplot2::qplot(t, value, data=data, geom="line", colour=variable, 
                        main=paste("Distribution functions of waiting times (t from ", data$t[1], " to ", data$t[length(data$t)], ")", sep=""),
                        ylab="Cumulative Probability") + scale_colour_discrete(name="")
           })
  })
}

#' Plot of the probabilities of a Markovian Model
#' 
#' Shows a plot with the P(n) and Q(n) values of a Markovian Model
#' 
#' @param object Markovian Model
#' @param n Range of n
#' @param graphics Type of graphics: "graphics" uses the basic R plot and "ggplot2" the library ggplot2
#' @keywords internal
summaryPnQn <- function(object, n, graphics="ggplot2") {
  switch(graphics,
         "graphics" = {
              tryCatch({
                graphics::barplot(rbind(Qn(object, n), Pn(object, n)), names.arg=n, col=c("blue", "red"),  legend.text=c("Qn", "Pn"), beside=TRUE)
                graphics::legend(0, 0, legend=c("Qn", "Pn"))
              }, error=function(e) {
                graphics::barplot(Pn(object, n), col="red", legend.text="Pn")
              })
              graphics::title(main=paste("Probability of n customers in the system (n from ", n[1], " to ", n[length(n)], ")", sep=""))
         },
         "ggplot2" = {
             tryCatch({
               value <- variable <- NULL
               data <- melt(data.frame(n, "Pn"=Pn(object, n), "Qn"=Qn(object, n)), id.var="n")
              ggplot2::qplot(n, value, data=data, geom="bar", stat="identity", fill=variable, position="dodge",
                    main=paste("Probabilities of n customers (n from ", n[1], " to ", n[length(n)], ")", sep=""),
                    ylab="Probability") + scale_fill_discrete(name="")
             }, error= function(e) {
                 data <- melt(data.frame(n, "Pn"=Pn(object, n)), id.var="n")
                 ggplot2::qplot(n, value, data=data, geom="bar", stat="identity", fill=variable,
                       main=paste("Probability of n customers (n from ", n[1], " to ", n[length(n)], ")", sep=""),
                       ylab="Probability") + scale_fill_discrete(name="")
             })
         })
}

#' Returns the maximun value of n that satisfies the condition \ifelse{latex}{\eqn{P_{n}}}{\out{P<sub>n</sub>}} > 0
#' 
#' @param qm object MarkovianModel
#' @rdname maxCustomers
#' @examples
#' maxCustomers(M_M_1_K())
#' 
#' maxCustomers(M_M_S_INF_H_Y())
#' @export
maxCustomers <- function(qm) {UseMethod("maxCustomers", qm)}


setClass("no_distr", representation(), prototype())
#' Defines an empty object representing the inexistence of a distribution.
#' @export
no_distr <- function() {
    obj <- new("no_distr")
    attr(class(obj), "package") <- "distr"
    return(obj)
}

#' @describeIn maxCustomers implements the default method. Returns infinite.
#' @method maxCustomers MarkovianModel
#' @usage NULL
#' @export
maxCustomers.MarkovianModel <- function(qm) {
      return(Inf)
}