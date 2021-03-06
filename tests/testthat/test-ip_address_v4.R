x <- c("0.0.0.0", "0.0.0.1", "192.168.0.1", "255.255.255.255")

test_that("construction works", {
  expect_s3_class(ip_address(), c("ip_address", "vctrs_rcrd", "vctrs_vctr"), exact = TRUE)
  expect_true(is_ip_address(ip_address(x)))
  expect_length(ip_address(), 0)
  expect_length(ip_address(x), length(x))
  expect_equal(as.character(ip_address(x)), x)
})

test_that("formats correctly", {
  expect_equal(format(ip_address(x)), x)
})

test_that("casting works", {
  expect_equal(vec_cast(ip_address("1.2.3.4"), ip_address()), ip_address("1.2.3.4"))
  expect_equal(vec_cast("1.2.3.4", ip_address()), ip_address("1.2.3.4"))
  expect_equal(vec_cast(ip_address("1.2.3.4"), character()), "1.2.3.4")
})

test_that("coercion works", {
  expect_s3_class(vec_c(ip_address(), ip_address()), "ip_address")
  expect_type(vec_c(character(), ip_address()), "character")
  expect_type(vec_c(ip_address(), character()), "character")

  expect_error(vec_c(ip_address(), ip_network()), class = "vctrs_error_incompatible_type")
  expect_error(vec_c(ip_network(), ip_address()), class = "vctrs_error_incompatible_type")
})

test_that("missing values work", {
  expect_equal(field(ip_address(NA), "is_ipv6"), NA)
  expect_equal(ip_address(c(x, NA)), c(ip_address(x), NA))
  expect_equal(as.character(ip_address(c(x, NA))), c(x, NA))
  expect_equal(is.na(ip_address(c(x, NA))), c(rep(FALSE, length(x)), TRUE))
})

test_that("invalid inputs are caught", {
  expect_warning(ip_address("1.2.3.4/5"), "Invalid value")
  expect_warning(ip_address("abc"), "Invalid value")
  expect_warning(ip_address("1.2.3.256"), "Invalid value")
  expect_warning(ip_address("1.2.3.-1"), "Invalid value")
  expect_warning(ip_address("1.2.3.4.5"), "Invalid value")

  # Windows accepts IP addresses in alternative formats: https://superuser.com/a/486936
  skip_on_os("windows")
  expect_warning(ip_address("1.2.3"), "Invalid value")
})

test_that("equality operations work", {
  expect_true(all(ip_address(x) == ip_address(x)))
  expect_false(any(ip_address(x) == ip_address(rev(x))))
})

test_that("comparison operations work", {
  shifter <- function(x, n = 1L) {
    if (n == 0) x else c(tail(x, -n), head(x, n))
  }
  expect_equal(
    vec_compare(ip_address(x), ip_address(shifter(x, 1L))),
    c(rep(-1L, length(x) - 1L), 1L)
  )
  expect_equal(
    vec_compare(ip_address(x), ip_address(shifter(x, -1L))),
    c(-1L, rep(1L, length(x) - 1L))
  )
  expect_equal(vec_compare(ip_address("192.168.0.1"), ip_address(NA)), NA_integer_)
})
