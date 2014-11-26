# Fixtures

Fixture data for unit tests. When unit testing, you don't want to load in a ton of data. You only want enough to verify that the unit you are testing (in our case, functions) is working.

Generally you only want fixtures for stuff you load from disk or an API. In our case we'll use fixtures to unit test the functions that read files and do things with their results.