basic_contents = "me,flighttools,packagedev,start,,2025-09-11 16:12:02.175759
me,flighttools,packagedev,stop,,2025-09-11 16:12:24.925038
rando,overexpression,qcqa,start,manuscript,2025-09-12 09:30:44.216941
rando,overexpression,qcqa,stop,manuscript,2025-09-12 11:03:34.671303
rando,overexpression,qcqa,start,manuscript,2025-09-12 13:25:27.879861
rando,overexpression,qcqa,stop,manuscript,2025-09-12 17:04:20.110792"

tk_cats = "qcqa,analysis,packagedev,cleaning,reporting,writing"

withr::with_tempfile("timekeep_file", {
  fs::file_create(timekeep_file)
  cat(basic_contents, file = timekeep_file, sep = "\n")

  withr::with_envvar(
    new = c("R_FT_TK_LOGFILE" = timekeep_file, "R_FT_TK_CATEGORIES" = tk_cats),
    {
      test_that("parsing works", {
        tk_contents = ft_tk_parselog()
        expect_equal(nrow(tk_contents), 6)
      })

      test_that("error when another category", {
        expect_error(
          ft_tk_logtask("rando", "overexpression", "crap"),
          "not in the list"
        )
      })

      test_that("error when not start / stop", {
        expect_error(
          ft_tk_logtask("rando", "overexpression", "writing", "end"),
          "must be either"
        )
      })

      test_that("removing last works", {
        ft_tk_logtask("rando", "overexpression", "qcqa", "start")
        tk_contents = ft_tk_parselog()
        expect_equal(nrow(tk_contents), 7)
        ft_tk_removelast()
        tk_contents_2 = ft_tk_parselog()
        expect_equal(nrow(tk_contents_2), 6)
        ft_tk_logtask("rando", "weirdness", "qcqa", "start")
        tk_contents_3 = ft_tk_parselog()
        expect_equal(nrow(tk_contents_3), 7)
      })
    }
  )
})
