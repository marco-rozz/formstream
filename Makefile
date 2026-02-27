format:
	go fmt $(shell go list ./... | grep -v /vendor/) && \
	go vet $(shell go list ./... | grep -v /vendor/) && \
	go tool -modfile=go.tool.mod golangci-lint run --timeout 5m0s --issues-exit-code 1

# https://www.alexedwards.net/blog/how-to-manage-tool-dependencies-in-go-1.24-plus
# go mod init -modfile=go.tool.mod github.com/marco-rozz/formstream/v2
install-tools:
	go get -tool -modfile=go.tool.mod github.com/golangci/golangci-lint/v2/cmd/golangci-lint
	go get -tool -modfile=go.tool.mod golang.org/x/vuln/cmd/govulncheck
	go get -tool -modfile=go.tool.mod mvdan.cc/gofumpt

tidy:
	go mod tidy -compat=1.26

# https://go.googlesource.com/vuln
# go install golang.org/x/vuln/cmd/govulncheck@latest
vuln:
	go tool -modfile=go.tool.mod govulncheck -show verbose ./...

test:
	go test -short -race -covermode=atomic $(shell go list ./... | grep -v /vendor/)
	#go test -coverprofile=coverage.out ./...    # Generate report coverage Go

test_complete:
	go test -short -race -covermode=atomic $(shell go list ./... | grep -v /vendor/)
	go test -short -bench=. $(shell go list ./... | grep -v /vendor/)
	#go test -coverprofile=coverage.out ./...    # Generate report coverage Go

qa: tidy format vuln test
