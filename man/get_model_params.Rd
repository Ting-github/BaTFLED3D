% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_model_params.R
\name{get_model_params}
\alias{get_model_params}
\title{Get parameters to build a BaTFLED model}
\usage{
get_model_params(args)
}
\arguments{
\item{args}{A character vector of arguments (character strings) of the form "<name>=<value>". 
Values will be converted to logical or numeric when possible.
Accepted <names> are below. Defaults in parenthesis:
\describe{
\item{decomp}{Either 'CP' or 'Tucker'. (Tucker)}
\item{row.share}{Logical. Should the variance be shared across rows of the projection matrices? 
This will cause predictors to be or excluded for the whole model, instead of just for particular 
latent factors. (F)}
\item{seed}{Numeric. Seed used for random initialization. (NA)}
\item{verbose}{Logical. Display more messages during training. (F)}
\item{parallel}{Logical. Perform operations in parallel when possible. (T)}
\item{cores}{Numeric. The number of parallel threads to use. (2)}
\item{lower.bnd}{Logical. Should the lower bound be calculated during training. Setting to FALSE
saves time (F)}
\item{RMSE}{Logical. Should the root mean squared error for the training data be calculated during 
training. (T)}
\item{cor}{Logical. Should the Pearson correlation for the training data be calculated during 
training. (T)}
\item{A1.intercept}{Logical. Add a constant column to the mode 1 predictors. (T)}
\item{A2.intercept}{Logical. Add a constant column to the mode 2 predictors. (T)}
\item{A3.intercept}{Logical. Add a constant column to the mode 3 predictors. (F)}
\item{H1.intercept}{Logical. Add a constant column to the mode 1 latent (H) matrix. (F)}
\item{H2.intercept}{Logical. Add a constant column to the mode 2 latent (H) matrix. (F)}
\item{H3.intercept}{Logical. Add a constant column to the mode 3 latent (H) matrix. (F)}
\item{R}{Numeric. Number of latent factors used in a CP model. (3)}
\item{R1}{Numeric. Number of latent factors used for mode 1 in a Tucker decomposition. (3)}
\item{R2}{Numeric. Number of latent factors used for mode 2 in a Tucker decomposition. (3)}
\item{R3}{Numeric. Number of latent factors used for mode 3 in a Tucker decomposition. (3)}
\item{core.updates}{Numeric. Number of core elements to update each round for stochastic training. (all)}
\item{m1.alpha}{Numeric. Prior for the 'shape' parameter of the gamma distribution on the 
precision values in the mode 1 projection (A) matrix. Set this to a small value (ex. 1e-10)
to encourage sparsity in mode 1 predictors. (1)}
\item{m2.alpha}{Numeric. Same as above for mode 2. (1)}
\item{m3.alpha}{Numeric. Same as above for mode 3. (1)}
\item{m1.beta}{Numeric. Prior for the 'scale' parameter of the gamma distribution on the 
precision values in the mode 1 projection (A) matrix. Set this to a large value (ex. 1e10)
to encourage sparsity in mode 1 predictors. Note this should stay balanced with m1.alpha 
so thir product is 1. (1)}
\item{m2.beta}{Numeric. Same as above for mode 2. (1)}
\item{m3.beta}{Numeric. Same as above for mode 3. (1)}
\item{A.samp.sd}{Numeric. Standard deviation used when initializing values in the projection
(A) matrices. (1)}
\item{H.samp.sd}{Numeric. Standard deviation used when initializing values in the latent
(H) matrices. (1)}
\item{R.samp.sd}{Numeric. Standard deviation used when initializing values in the core
tensor for Tucker models. (1)}
\item{A.var}{Numeric. Initial variance for projection (A) matrices. (1)}
\item{H.var}{Numeric. Initial variance for latent (H) matrices. (1)}
\item{R.var}{Numeric. Initial variance for the core tensor in Tucker models. (1)}
\item{random.H}{Logical. Should the latent matrices be initialized randomly or be the result
of multiplying the input data by the projection matrices. (T)}
\item{core.0D.alpha}{Numeric. Prior for the 'scale' parameter of the gamma distribution on the 
precision value in the element of the core tensor corresponding to the intercept for all
three modes (core.mean[1,1,1]). Only used for Tucker models when all H intercepts are true. 
Set this to a small value (ex. 1e-10) to encourage sparsity in core predictor. (1)}
\item{core.1D.alpha}{Numeric. As above for values corresponding to the intercepts for 
two modes (core.mean[1,1,], core.mean[1,,1] and core.mean[,1,1]). (1)}
\item{core.2D.alpha}{Numeric. As above for values corresponding to the intercepts for 
one mode (core.mean[1,,], core.mean[,1,] and core.mean[,,1]). (1)}
\item{core.3D.alpha}{Numeric. As above for values not corresponding to intercepts. (1)}
\item{core.0D.beta}{Numeric. As above but a prior for the 'scale' parameter. (1)}
\item{core.1D.beta}{Numeric. As above but a prior for the 'scale' parameter. (1)}
\item{core.2D.beta}{Numeric. As above but a prior for the 'scale' parameter. (1)}
\item{core.3D.beta}{Numeric. As above but a prior for the 'scale' parameter. (1)}
\item{m1.sigma2}{Numeric. Variance for the mode 1 latent (H) matrix. Set small to link the
values in the latent matrices to the product of the input and projection matrices. If there 
is no input data, set to one or larger. (0.01)}
\item{m2.sigma2}{Numeric. As above for mode 2. (0.01)}
\item{m3.sigma2}{Numeric. As above for mode 3. (0.01)}
\item{sigma2}{Numeric. Variance parameter for the response tensor or 'auto' (default). 
If set to 'auto' then the square-root of the variance of the training responses is used.}
\item{remove.start}{Numeric. The iteration to begin removing predictors if any of 
\code{m1.remove.lmt}, \code{m2.remove.lmt}, \code{m3.remove.lmt} or \code{remove.per}
are set. (Inf)}
\item{remove.per}{Numeric. Percentage of predictors to remove with the lowest mean of 
squared values across rows of the projection matrix. (0)}
\item{m1.remove.lmt}{Numeric. Remove a mode 1 predictor if the mean squared value of 
its row in the projection matrix drop below this value. (0)}
\item{m2.remove.lmt}{As above for mode 2. (0)}
\item{m3.remove.lmt}{As above for mode 3. (0)}
\item{early.stop}{Numeric. Stop training if the lower bound value changes by less than 
this value. (0)}
\item{plot}{Logical. Show plots while training}
\item{show.mode}{Numeric vector. Display images of the projection and latent matrices
for these modes while training. (c(1,2,3))}
\item{update.order}{Numeric vector. Update the modes in this order (c(3,2,1))}
}}
}
\value{
list of parameters used by \code{train} function. Values in \code{args} that
are not model parameters will be excluded and a warning displayed.
}
\description{
Read in vector of arguments, check their types and add them to a list \code{params} for 
model training. If a parameter isn't in the given list the default is used.
}
\examples{
args <- c('decomp=Tucker', 'row.share=F',
          'A1.intercept=T', 'A2.intercept=T', 'A3.intercept=F',
          'H1.intercept=T', 'H2.intercept=T', 'H3.intercept=T',
          'plot=T', 'verbose=F','R1=4', 'R2=4', 'R3=2',
          'm1.alpha=1e-10', 'm2.alpha=1e-10', 'm3.alpha=1',
          'm1.beta=1e10', 'm2.beta=1e10', 'm3.beta=1',
          'core.3D.alpha=1e-10', 'core.3D.beta=1e10',
          'parallel=T', 'cores=5', 'lower.bnd=T',
          'update.order=c(3,2,1)', 'show.mode=c(1,2,3)',
          'wrong=1')
model.params <- get_model_params(args)
}
\seealso{
\code{\link{CP_model}} \code{\link{Tucker_model}}
}

