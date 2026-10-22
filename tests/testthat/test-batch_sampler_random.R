test_that("random sampler: no shuffle, multiple batches", {
  batch_sampler_class <- mlr3torchAUM::batch_sampler_random(
    batch_size = 4, shuffle = FALSE)
  sampler <- batch_sampler_class(list(task = list(nrow = 10)))
  expect_equal(unname(lapply(sampler$batch_list, length)), list(4, 4, 2))
  expect_equal(unname(sampler$batch_list), list(1:4, 5:8, 9:10))
})

test_that("random sampler: N equal to batch_size gives one batch", {
  batch_sampler_class <- mlr3torchAUM::batch_sampler_random(
    batch_size = 4)
  sampler <- batch_sampler_class(list(task = list(nrow = 4)))
  expect_equal(length(sampler$batch_list), 1)
  expect_equal(length(sampler$batch_list[[1]]), 4)
})
