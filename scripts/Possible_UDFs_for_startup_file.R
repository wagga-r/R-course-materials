# UDF collection for use in R startup file '.Rprofile', located in the user's
# home directory.

# Davd Luckett, djluckett@gmail.com, 0408750703

# Single character shortcuts - BEWARE!
s <- base::summary
h <- utils::head
l <- base::levels
si <- utils::sessionInfo

# e.g. si()
# e.g. l(iris$Species)

# headtail, i.e., show the first and last n items of a dataframe
ht <- function(in.df, n=6) {
  if (!is.data.frame(in.df)) stop("Error: object is not a dataframe\n")
  col_num <- dim(in.df)[2]
  midline.df <- data.frame()
  
  for (ii in 1:col_num) {
    mnum <- max(nchar(as.character(in.df[,ii])))
    fnum <- nchar(names(in.df)[ii])
    rnum <- max(mnum, fnum)-1
    midline.df[1,ii] <- c(paste(rep("-", rnum), sep="", collapse=""))
  }
  
  names(midline.df) <- names(in.df)
  comb.df <- rbind(head(in.df, n=n), midline.df, tail(in.df, n=n))
  row.names(comb.df)[n+1] <- c("**split")
  comb.df
}

# e.g.    ht(iris)
# e.g.    ht(iris, n=2)


# Function to show the 'middle' of a dataframe
# It preserves the original row names/numbers
# It has to compromise on number shown due to odd/even differences in object length
# and value of n.
middle <- function(x, n=6){
  if (!is.data.frame(x)) stop("Error: object is not a dataframe\n")
  mid <- ceiling(nrow(x)/2)
  top <- mid + ceiling(n/2)
  bot <- mid - ceiling(n/2)
  print(x[bot:top, ])
}

# e.g.    middle(iris)

# Simple time indicator
now <- function() {format(Sys.time(), "%I:%M %p")}

# counts all NAs in an object
na_count <- function(x) {sum(is.na(x))}

# Returns a logical vector TRUE for elements of X not in Y
"%nin%" <- function(x, y) !(x %in% y) 

# Converts a list to a dataframe where list is unnamed and equal width (e.g from lapply + UDF)
l2df <- function(xx) {
  out <- data.frame(matrix(unlist(xx), nrow=length(xx), byrow=TRUE))
  return(out)
}

# Translate a factor containing numbers into a numeric vector
fac.num <- function(x) {
  if (is.null(x)) {stop("x does not exist \n")}
  if (!is.factor(x)) {stop("x is not a factor \n")}
  if (is.na(as.numeric(levels(x)))[1]) {stop("factor x contains non-numeric strings \n\n")}
           as.numeric(as.character(x)) 
}


# Bulk convert dataframe columns
# e.g. from numeric to factor; from character to factor; and from character to date.
# Use in lapply

convert <- function (d, columns=names(d), action=as.factor, val_limit=10) 
{
    arg1 <- deparse(substitute(d))
    arg2 <- deparse(substitute(action))
    
    e <- d
    vals <- unlist(lapply(e[,columns], dplyr::n_distinct))
    if (max(vals) > val_limit & arg2=="as.factor") 
      { cat("Error - Some columns have large numbers of categories\n\n")
        print(vals)
        cat("\n")
        stop()
        }
    e[,columns] <- lapply(e[,columns], action) 
    assign(arg1, e, pos=1)
    print(head(e))
    cat("\n")
    str(e)
}
 

# Draw a histogram with normal overlay (From http://www.statmethods.net/graphs/density.html)
histnormal <- function(d, main=NULL, xlab=NULL, breaks="FD", ...) {
    if (any(is.na(d))) warning(paste(sum(is.na(d)), "missing values"));	d <- na.omit(d) 
    h <- hist(d, plot=FALSE, breaks=breaks, ...)
    x <- seq(min(d), max(d), length=40)
    y <- dnorm(x, mean=mean(d), sd=sd(d))
    y <- y*diff(h$mids[1:2])*length(d)
    hist(d, col="gray20", main=main, xlab=xlab, ylim=c(0,max(y)), breaks=breaks,...)
    lines(x,y, col="blue", lwd=2)
    rug(x)
}

# e.g.  histnormal(iris$Sepal.Length)


# Draw a histogram with density overlay
histdensity <- function(x, main=NULL, breaks="FD", ...) {
    if (any(is.na(x))) warning(paste(sum(is.na(x)), "missing values"));	x <- na.omit(x) 
	hist(x, col="gray20", probability=TRUE,  breaks=breaks, main=main, ...)
	lines(density(x, na.rm = TRUE), col = "blue", lwd=2)
	rug(x)
}

# e.g.  histdensity(iris$Sepal.Length)

# Plot scatterplot with trendline and confidence interval (From http://tinyurl.com/3bvrth7)
scatterci <- function(x, y, ...) {
    plot(x, y, ...)
    mylm <- lm(y~x)
    abline(mylm, col="blue")
    x=sort(x)
    prd<-predict(mylm,newdata=data.frame(x=x),interval = c("confidence"), level = 0.95)
    lines(x,prd[,2],col="blue",lty=3)
    lines(x,prd[,3],col="blue",lty=3)
}

# e.g.  scatterci(iris[,1], iris[,2])

# Correlation matrix with p-values. See http://goo.gl/nahmV for documentation of this function
cor.prob <- function(X, dfr = nrow(X) - 2) {
     R <- cor(X)
	 above <- row(R) < col(R)
	 r2 <- R[above]^2
	 Fstat <- r2 * dfr / (1 - r2)
	 R[above] <- 1 - pf(Fstat, 1, dfr)
	 R[row(R)==col(R)]<-NA
     R
}

# e.g.   cor_prob(iris[,1:4])

# Ends.

