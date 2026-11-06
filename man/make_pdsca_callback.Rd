\name{make_pdsca_callback}
\alias{make_pdsca_callback}
\title{PDSCA callback for CompositionalAUCLoss}
\description{
Creates an \code{mlr3torch} callback used together with
\code{optim_pdsca} and \code{nn_CompositionalAUC_loss}.
}
\usage{
make_pdsca_callback(lr, clamp_value, weight_decay, epoch_decay,
                    momentum, decay_factor, decay_epochs = NULL)
}
\arguments{
\item{lr}{learning rate for the loss parameters \code{a}, \code{b} and
\code{alpha}.}
\item{clamp_value}{gradient clamping threshold.}
\item{weight_decay}{L2 regularization strength.}
\item{epoch_decay}{strength of the proximal term}
\item{momentum}{EMA weight for the descent buffer of \code{a} and \code{b};
same convention as in \code{\link{optim_pdsca}}.}
\item{decay_factor}{the learning rate is divided by this at each decay epoch.}
\item{decay_epochs}{\code{NULL} (default) to decay after every epoch, or a
vector of positive integers giving the epochs after which to refresh the
proximal reference and decay the learning rates (\code{lr}, \code{lr0} of
\code{\link{optim_pdsca}}, and \code{lr} here), as \code{decay_epochs} in
LibAUC. Decaying after every epoch with \code{decay_factor > 1} shrinks the
learning rate geometrically, so training stops after a few epochs and can
freeze in a poor (even inverted, AUC < 0.5) solution.}
}
\value{An \code{mlr3torch} \code{TorchCallback}.}
\note{
These arguments govern \strong{only} the loss parameters \code{a}, \code{b} and
\code{alpha}. The network weights are governed by the separate arguments of
\code{\link{optim_pdsca}}. So the complete usage of PDSCA optimizer
should be together with \code{\link{optim_pdsca}}. 
}
\author{Wei Cao}
\seealso{\code{\link{nn_CompositionalAUC_loss}}, \code{\link{optim_pdsca}},
\code{\link{make_pesg_callback_full}}}
\examples{
if(torch::torch_is_installed() && requireNamespace("mlr3torch", quietly = TRUE)){
cb <- mlr3torchAUM::make_pdsca_callback(
  lr = 0.1, clamp_value = 1, weight_decay = 1e-4,
  epoch_decay = 1e-3, momentum = 0.9, decay_factor = 2,
  decay_epochs = c(50, 75))
}
}
