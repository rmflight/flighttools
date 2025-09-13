basic_contents = "me,flighttools,packagedev,start,,2025-09-11 16:12:02.175759
me,flighttools,packagedev,stop,,2025-09-11 16:12:24.925038
rando,overexpression,qcqa,start,manuscript,2025-09-12 09:30:44.216941
rando,overexpression,qcqa,stop,manuscript,2025-09-12 11:03:34.671303
rando,overexpression,analysis,start,manuscript,2025-09-17 13:25:27.879861
rando,overexpression,analysis,stop,manuscript,2025-09-17 17:04:20.110792"

other_contents = "rando,overexpression,othertask,start,manuscript,2025-09-12 13:25:27.879861
rando,overexpression,qcqa,start,manuscript,2025-09-12 13:25:27.879861
rando,overexpression,othertask,stop,manuscript,2025-09-12 13:25:27.879861
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
        expect_message(ft_tk_removelast(), "Removing the last entry")
        tk_contents_2 = ft_tk_parselog()
        expect_equal(nrow(tk_contents_2), 6)
        ft_tk_logtask("rando", "weirdness", "qcqa", "start")
        tk_contents_3 = ft_tk_parselog()
        expect_equal(nrow(tk_contents_3), 7)
      })

      test_that("checking works", {
        expect_warning(ft_tk_check_log(), "has an odd number of")
        ft_tk_removelast()
        expect_no_message(ft_tk_check_log())

        cat(other_contents, file = ft_tk_logfile(), sep = "\n")
        expect_warning(ft_tk_check_log(), "There is a difference")
      })

      test_that("summarizing works", {
        cat(basic_contents, file = ft_tk_logfile())

        d_1 = ft_tk_summarize_time(
          collab_q = "rando",
          project_q = "overexpression",
          category_q = "analysis"
        )
        expect_equal(d_1, 1)

        d_2 = ft_tk_summarize_time(
          collab_q = "rando",
          project_q = "overexpression"
        )
        expect_equal(d_2, 1)

        d_3 = ft_tk_summarize_time(
          collab_q = "rando",
          project_q = "overexpression",
          min_cumulative = 30
        )
        expect_equal(d_3, 2)

        d_4 = ft_tk_summarize_time(
          collab_q = "rando",
          project_q = "overexpression",
          min_cumulative = 30,
          return_type = "full"
        )
        expect_equal(nrow(d_4), 2)
      })
    }
  )
})
