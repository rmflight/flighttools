test_that("setting function parameters works", {
  test_fun = function(x = 1, y = 10, z = "five") {
    return(NULL)
  }
  fun_params = ft_set_function_params(
    test_fun,
    verbose = TRUE
  )
  expect_equal(fun_params$value, c("1", "10", "five"))

  test_fun2 = function(x = 1, y = 10, z = c(1, 2)) {
    return(NULL)
  }
  fun_params2 = ft_set_function_params(
    test_fun2,
    verbose = TRUE
  )
  expect_equal(fun_params2$value, c("1", "10", "1,2"))
})
