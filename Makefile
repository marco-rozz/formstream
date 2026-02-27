format:
	go fmt $(shell go list ./... | grep -v /vendor/) && \
	go vet $(shell go list ./... | grep -v /vendor/) && \
	golangci-lint run --timeout 5m0s --issues-exit-code 1

tidy:
	go mod tidy -compat=1.26

# https://go.googlesource.com/vuln
# go install golang.org/x/vuln/cmd/govulncheck@latest
vuln:
	govulncheck -show verbose ./...

test:
	go test -race -covermode=atomic $(shell go list ./... | grep -v /vendor/)
	go test -bench=. $(shell go list ./... | grep -v /vendor/)
	#go test -coverprofile=coverage.out ./...    # Generate report coverage Go