test_that("IPv4-mapped IPv6 addresses work", {
  # IPv4: none
  expect_false(is_ipv4_mapped(ip_address("0.0.0.0")))
  expect_false(is_ipv4_mapped(ip_network("0.0.0.0/32")))

  # IPv6: ::ffff:0.0.0.0/96
  expect_equal(
    is_ipv4_mapped(ip_address(c("::fffe:ffff:ffff", "::ffff:0.0.0.0", "::ffff:255.255.255.255", "::1:0:0:0"))),
    c(FALSE, TRUE, TRUE, FALSE)
  )
  expect_equal(
    is_ipv4_mapped(ip_network(c("::ffff:0.0.0.0/96", "::ffff:0.0.0.0/97", "::fffe:0.0.0.0/95"))),
    c(TRUE, TRUE, FALSE)
  )
  expect_equal(
    extract_ipv4_mapped(ip_address(c("192.168.0.1", "::ffff:192.0.2.128", "2001:db8::"))),
    ip_address(c(NA, "192.0.2.128", NA))
  )

  expect_equal(is_ipv4_mapped(ip_address()), logical())
  expect_equal(is_ipv4_mapped(ip_network()), logical())
  expect_equal(extract_ipv4_mapped(ip_address()), ip_address())

  expect_equal(is_ipv4_mapped(ip_address(NA)), NA)
  expect_equal(is_ipv4_mapped(ip_network(NA)), NA)
  expect_equal(extract_ipv4_mapped(ip_address(NA)), ip_address(NA))

  expect_error(is_ipv4_mapped("hello"))
  expect_error(extract_ipv4_mapped("hello"))
  expect_error(extract_ipv4_mapped(ip_network()))
  expect_error(extract_ipv4_mapped(NA))
})

test_that("6to4 IPv6 addresses work", {
  # IPv4: none
  expect_false(is_6to4(ip_address("0.0.0.0")))
  expect_false(is_6to4(ip_network("0.0.0.0/32")))

  # IPv6: 2002::/16
  expect_equal(
    is_6to4(ip_address(c("2001:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "2002::", "2002:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "2003::"))),
    c(FALSE, TRUE, TRUE, FALSE)
  )
  expect_equal(
    is_6to4(ip_network(c("2002::/16", "2002::/17", "2000::/15"))),
    c(TRUE, TRUE, FALSE)
  )
  expect_equal(
    extract_6to4(ip_address(c("192.168.0.1", "2002:c000:0280::", "2001:db8::"))),
    ip_address(c(NA, "192.0.2.128", NA))
  )

  expect_equal(is_6to4(ip_address()), logical())
  expect_equal(is_6to4(ip_network()), logical())
  expect_equal(extract_6to4(ip_address()), ip_address())

  expect_equal(is_6to4(ip_address(NA)), NA)
  expect_equal(is_6to4(ip_network(NA)), NA)
  expect_equal(extract_6to4(ip_address(NA)), ip_address(NA))

  expect_error(is_6to4("hello"))
  expect_error(extract_6to4("hello"))
  expect_error(extract_6to4(ip_network()))
  expect_error(extract_6to4(NA))
})

test_that("Teredo IPv6 addresses work", {
  # IPv4: none
  expect_false(is_teredo(ip_address("0.0.0.0")))
  expect_false(is_teredo(ip_network("0.0.0.0/32")))

  # IPv6: 2001::/32
  expect_equal(
    is_teredo(ip_address(c("2000:ffff:ffff:ffff:ffff:ffff:ffff:ffff", "2001::", "2001:0:ffff:ffff:ffff:ffff:ffff:ffff", "2001:1::"))),
    c(FALSE, TRUE, TRUE, FALSE)
  )
  expect_equal(
    is_teredo(ip_network(c("2001::/32", "2001::/33", "2000::/31"))),
    c(TRUE, TRUE, FALSE)
  )
  expect_equal(
    extract_teredo_server(ip_address(c("192.168.0.1", "2001:0000:4136:e378:8000:63bf:3fff:fdd2", "2001:db8::"))),
    ip_address(c(NA, "65.54.227.120", NA))
  )
  expect_equal(
    extract_teredo_client(ip_address(c("192.168.0.1", "2001:0000:4136:e378:8000:63bf:3fff:fdd2", "2001:db8::"))),
    ip_address(c(NA, "192.0.2.45", NA))
  )

  expect_equal(is_teredo(ip_address()), logical())
  expect_equal(is_teredo(ip_network()), logical())
  expect_equal(extract_teredo_server(ip_address()), ip_address())
  expect_equal(extract_teredo_client(ip_address()), ip_address())

  expect_equal(is_teredo(ip_address(NA)), NA)
  expect_equal(is_teredo(ip_network(NA)), NA)
  expect_equal(extract_teredo_server(ip_address(NA)), ip_address(NA))
  expect_equal(extract_teredo_client(ip_address(NA)), ip_address(NA))

  expect_error(is_teredo("hello"))
  expect_error(extract_teredo_server("hello"))
  expect_error(extract_teredo_server(ip_network()))
  expect_error(extract_teredo_server(NA))
  expect_error(extract_teredo_client("hello"))
  expect_error(extract_teredo_client(ip_network()))
  expect_error(extract_teredo_client(NA))
})
