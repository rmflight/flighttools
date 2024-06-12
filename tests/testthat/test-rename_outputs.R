test_that("copying files with new name works", {
  rename_outputs("test_rename_file.md")
  new_file = paste0("test_rename_file", "_", Sys.Date(), ".md")
  expect_true(file.exists(new_file))
  file.remove(new_file)
  
  
  rename_outputs(file_names = "test_rename_file.md", prefix = "hello")
  new_file = paste0("hello_test_rename_file", "_", Sys.Date(), ".md")
  expect_true(file.exists(new_file))
  file.remove(new_file)
  
  expect_error(rename_outputs(file_names = "", prefix = "hello"), regexp = "provided, aborting")
})
