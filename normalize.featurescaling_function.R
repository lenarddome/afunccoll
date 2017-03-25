# tex commands: z_i=\frac{x_i-\min(x)}{\max(x)-\min(x)}
# Feature Scaling
## Feature scaling is a method used to standardize the range of
## independent variables or features of data.
## In data processing, it is also known as data normalization
## and is generally performed during the data preprocessing step.


function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
