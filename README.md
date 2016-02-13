# RESTer CLI

Command line tool from making HTTP requests.

## Unit Tests

Run all tests:

```bash
npm test
```

Run all tests with coverage:

```bash
npm test -- -c
npm test -- --coverage
```

Run a test or directory of tests:

```bash
npm test -- [path to file or directory relative to test/]
```

Run tests with code coverage:

```bash
npm test -- -c [path]
npm test -- --coverage [path]
```

Running tests will generate a code coverage report. To view:

```bash
open coverage/lcov-report/index.html
```
