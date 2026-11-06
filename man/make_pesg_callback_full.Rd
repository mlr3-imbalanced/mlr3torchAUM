\name{make_pesg_callback_full}
\alias{make_pesg_callback_full}
\title{Full PESG Callback for the AUCM Loss}
\description{
Creates an \code{mlr3torch} callback that trains the \code{\link{nn_AUCM_loss}}
parameters with the full PESG rule, matching \code{\link{optim_pesg}}. At each
batch it updates \code{a}, \code{b} via the PESG primal step (clamp + weight
decay + proximal + EMA momentum) and ascends the dual variable \code{alpha};
at the end of each epoch in \code{decay_epochs} (every epoch by default) it
refreshes the proximal reference and decays the learning rate of both the
loss parameters and the network optimizer. Must be paired with
\code{\link{optim_pesg}} as the learner's optimizer for network weights.
}
\usage{
make_pesg_callback_full(lr, clamp_value, weight_decay, epoch_decay,
                        momentum, decay_factor, decay_epochs = NULL)
}
\arguments{
\item{lr}{learning rate for the loss parameters \code{a}, \code{b} and
\code{alpha}.}
\item{clamp_value}{gradient clamping threshold.}
\item{weight_decay}{L2 regularization strength.}
\item{epoch_decay}{strength of the proximal term}
\item{momentum}{EMA momentum weight.}
\item{decay_factor}{the learning rate is divided by this at each decay epoch.}
\item{decay_epochs}{\code{NULL} (default) to decay after every epoch, or a
vector of positive integers giving the epochs after which to decay, as
\code{decay_epochs} in LibAUC, e.g. \code{c(50, 75)} for 100 epochs.
Decaying after every epoch with \code{decay_factor > 1} shrinks the learning
rate geometrically, so training stops after a few epochs and can freeze in a
poor (even inverted, AUC < 0.5) solution.}
}
\value{An \code{mlr3torch} \code{TorchCallback}.}
\author{Wei Cao}
\seealso{\code{\link{nn_AUCM_loss}}, \code{\link{optim_pesg}}}
\examples{
if(torch::torch_is_installed() && requireNamespace("mlr3torch", quietly = TRUE)){
## halve the learning rate after epochs 50 and 75 only
cb <- mlr3torchAUM::make_pesg_callback_full(
  lr = 0.1, clamp_value = 1, weight_decay = 1e-4,
  epoch_decay = 1e-3, momentum = 0.9, decay_factor = 2,
  decay_epochs = c(50, 75))
}
}