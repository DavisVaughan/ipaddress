# ipaddress (development version)

## New features

* New `seq()` and `hosts()` functions provide ability to list all addresses within a network.
* New `num_addresses()`, `network_address()` and `broadcast_address()` functions provide basic information about a network.
* New `max_prefix_length()` function specifies the size of the address space (32-bit for IPv4 and 128-bit for IPv6).
* New `is_multicast()`, `is_unspecified()`, `is_loopback()` and `is_link_local()` functions check if addresses or networks are reserved for special use.
* `netmask()` and `hostmask()` are now generics, so they can accept either an `ip_network` vector or an integer vector of prefix lengths. Previously they only accepted an `ip_network` vector.
* Added an `ip_network` constructor that accepts `ip_address` and prefix length vectors.
* Improved input validation warnings. They now report the row number involved and no longer mentioned internal function names.
* Performance improvements.

## Bug fixes

* Fixed decoding bug which meant that some IP addresses were interpreted as NA
  * In IPv4, this affected `0.0.0.128`
  * In IPv6, this affected any address in the `0:80::/32` network
* Network membership functions (`is_within()`, `is_within_any()`, `is_subnet()` and `is_supernet()`) now report that the network address and broadcast address are within the network.
* `is_subnet()` and `is_supernet()` now check the prefix length, to ensure they are a true subnet or supernet.


# ipaddress 0.1.0

First CRAN release

* Added `ip_address` and `ip_network` classes
  * Full support for both IPv4 and IPv6 address spaces
  * Efficiently store data in their native representations (i.e. a sequence of bits)
  * Classes based on `vctrs` package for full tidyverse compatibility
* Added functions to determine network membership
  * `is_within()` and `is_within_any()` check if addresses are within networks
  * `is_subnet()` and `is_supernet()` check if networks are within other networks
* Added convenience functions to extract IP metadata
  * `is_ipv4()` and `is_ipv6()` classify the address space
  * `prefix_length()`, `netmask()` and `hostmask()` yield different representations of the network mask
* Calculations performed in C++ (using `Rcpp` and `AsioHeaders` packages) for improved performance