#' Transform a matrix of input data into a matrix of kernel simmilarities values
#' 
#' The input matrices should have samples as the rows and features as columns. A kernel will 
#' computed across all samples in the first matrix with respect to the samples in the second matrix.
#' The two matrices must have the same features. If all features are binary 0,1, then
#' the Jaccard similarity kernel will be used, otherwise, a Gaussian kernel with standard deviation
#' equal to s times the mean euclidean distances between samples in the second matrix.
#' If there are samples with all NA values, they will not appear in the kernel matrix columns.
#' The row for that sample will just be all NAs.
#' 
#' @importFrom stats dist
#' 
#' @export
#' @param m1 matrix on samples X features to compute kernels on 
#' @param m2 matrix of samples X features to compute kernels with respect to.
#' @param s numeric multiplier of standard deviation for the Gaussian kernels (default:1).
#' 
#' @return matrix of similarities between rows of m1 and rows of m2.
#' 
#' @examples
#' m1 <- matrix(rnorm(200), 8, 25, dimnames=list(paste0('sample.', 1:8), paste0('feat.', 1:25)))
#' m2 <- matrix(rnorm(100), 4, 25, dimnames=list(paste0('sample.', 9:12), paste0('feat.', 1:25)))
#' kernelize(m1, m1)
#' kernelize(m1, m1, s=.5)
#' kernelize(m2, m1)
#' m1 <- matrix(rbinom(200, 1, .5), 8, 25, 
#'              dimnames=list(paste0('sample.', 1:8), paste0('feat.', 1:25)))
#' m2 <- matrix(rbinom(25, 1, .5), 1, 25, 
#'              dimnames=list(c('sample.9'), paste0('feat.', 1:25)))
#' kernelize(m1, m1)
#' kernelize(m2, m1)

kernelize <- function(m1, m2=NA, s=1) {
  if(missing(m2)) m2 <- m1

  # If m1 has no rows, return a matrix with no rows
  if(!nrow(m1)) {
    K <- matrix(NA, 0, nrow(m2))
    colnames(K) <- rownames(m2)
    return(K)    
  }
  
  if(!all.equal(colnames(m1), colnames(m2))) 
    stop('The columns must match between the two matrices')
  
  # Remove any rows of NAs
  m1.na.rows <- apply(m1, 1, function(x) sum(!is.na(x)))==0
  m2.na.rows <- apply(m2, 1, function(x) sum(!is.na(x)))==0

  m1 <- m1[!m1.na.rows,,drop=F]
  m2 <- m2[!m2.na.rows,,drop=F]
  
  # If the matrices are binary, compute Jaccard kernel
  if(min(m1, na.rm=T)==0 && max(m1, na.rm=T)==1 && length(unique(as.vector(m1)))==2 &&
     min(m2, na.rm=T)==0 && max(m2, na.rm=T)==1 && length(unique(as.vector(m2)))==2) {
    # compute Jaccard kernel
    if (identical(m1, m2) == TRUE) {
      K <- 1 - as.matrix(dist(m1, method='binary'))
    } else {
      K <- 1 - as.matrix(dist(rbind(m1, m2), method='binary'))
      K <- K[1:nrow(m1), (nrow(m1) + 1):(nrow(m1) + nrow(m2)), drop=F]
    }
  } else {
    # Compute Gaussian kernel
    if (identical(m1, m2) == TRUE) {
      D <- as.matrix(dist(m1))
    } else {
      D <- as.matrix(dist(rbind(m1, m2)))
      D <- D[1:nrow(m1), (nrow(m1) + 1):(nrow(m1) + nrow(m2)),drop=F]
    }
    d_mean <- mean(as.matrix(dist(m2)))
    sigma2 <- (s * d_mean)^2
    K <- exp(-D^2/(2*sigma2))
  }    
  rownames(K) <- rownames(m1)
  colnames(K) <- rownames(m2)
  
  # Add back in any NA rows
  full.K <- matrix(NA, length(m1.na.rows), nrow(m2), 
                   dimnames=list(names(m1.na.rows), rownames(m2)))
  full.K[!m1.na.rows, ] <- K
  
  return(full.K)
}
