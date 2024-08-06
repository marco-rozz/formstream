format:
	go fmt $(shell go list ./... | grep -v /vendor/) && \
	go vet $(shell go list ./... | grep -v /vendor/) && \
	golangci-lint run --fast --timeout 5m0s --issues-exit-code 1

tidy:
	go mod tidy -compat=1.20

# https://go.googlesource.com/vuln
# go install golang.org/x/vuln/cmd/govulncheck@latest
vuln:
	govulncheck -show verbose ./...
