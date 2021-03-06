test_that("returns expected type and size", {
  skip_if_offline()

  expect_s3_class(hostname_to_ip("localhost", multiple = FALSE), "ip_address")
  expect_type(hostname_to_ip("localhost", multiple = TRUE), "list")
  expect_type(ip_to_hostname(ip_address("::1"), multiple = FALSE), "character")
  expect_type(ip_to_hostname(ip_address("::1"), multiple = TRUE), "list")

  expect_length(hostname_to_ip("localhost", multiple = FALSE), 1)
  expect_length(hostname_to_ip("localhost", multiple = TRUE), 1)
  expect_length(hostname_to_ip(c("localhost", "www.r-project.org"), multiple = FALSE), 2)
  expect_length(hostname_to_ip(c("localhost", "www.r-project.org"), multiple = TRUE), 2)

  expect_length(ip_to_hostname(ip_address("::1"), multiple = FALSE), 1)
  expect_length(ip_to_hostname(ip_address("::1"), multiple = TRUE), 1)
  expect_length(ip_to_hostname(ip_address(c("::1", "::2")), multiple = FALSE), 2)
  expect_length(ip_to_hostname(ip_address(c("::1", "::2")), multiple = TRUE), 2)
})

test_that("input validation works", {
  expect_error(ip_to_hostname(ip_network("192.168.0.0/24")))
  expect_error(ip_to_hostname("127.0.0.1"))
  expect_error(ip_to_hostname(ip_address("127.0.0.1"), multiple = "yes"))
  expect_error(ip_to_hostname(ip_address("127.0.0.1"), multiple = NA))

  expect_error(hostname_to_ip(123))
  expect_error(hostname_to_ip(ip_address("127.0.0.1")))
  expect_error(hostname_to_ip("localhost", multiple = "yes"))
  expect_error(hostname_to_ip("localhost", multiple = NA))
})

test_that("DNS resolution works", {
  skip_if_offline()

  expect_equal(hostname_to_ip("unknown"), ip_address(NA))
  expect_equal(ip_to_hostname(ip_address("0.0.0.0")), NA_character_)

  # localhost is a reserved top-level domain (suitable for unit testing?)
  expect_true(is_loopback(hostname_to_ip("localhost")))
  expect_match(ip_to_hostname(ip_address("127.0.0.1")), "localhost")
  expect_match(ip_to_hostname(ip_address("::1")), "localhost")
})

test_that("DNS resolution errors if offline", {
  local_mock("ipaddress:::is_offline" = function() TRUE)
  expect_error(ip_to_hostname(ip_address("127.0.0.1")))
  expect_error(hostname_to_ip("localhost"))
})

test_that("missing values work", {
  skip_if_offline()

  expect_equal(hostname_to_ip(NA_character_), ip_address(NA))
  expect_equal(ip_to_hostname(ip_address(NA), multiple = FALSE), NA_character_)
  expect_equal(ip_to_hostname(ip_address(NA), multiple = TRUE), list(NA_character_))
})

test_that("internal function pluck_first_of_each() works", {
  # works with character vectors
  expect_equal(
    pluck_first_of_each(list("a")),
    "a"
  )
  expect_equal(
    pluck_first_of_each(list(c("a", "b"))),
    "a"
  )
  expect_equal(
    pluck_first_of_each(list("a", "b")),
    c("a", "b")
  )
  expect_equal(
    pluck_first_of_each(list(c("a", "b"), "c")),
    c("a", "c")
  )

  # works with ip_address vectors
  expect_equal(
    pluck_first_of_each(list(ip_address("::a"))),
    ip_address("::a")
  )
  expect_equal(
    pluck_first_of_each(list(ip_address(c("::a", "::b")))),
    ip_address("::a")
  )
  expect_equal(
    pluck_first_of_each(list(ip_address("::a"), ip_address("::b"))),
    ip_address(c("::a", "::b"))
  )
  expect_equal(
    pluck_first_of_each(list(ip_address(c("::a", "::b")), ip_address("::c"))),
    ip_address(c("::a", "::c"))
  )
})
