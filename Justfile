kurtosis-check:
    kurtosis-lint --checked-calls --local-imports src/ test/

kurtosis-lint:
    kurtosis lint .

lint: kurtosis-check kurtosis-lint

test: kurtosis-test .
